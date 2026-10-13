import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/extensions/insurance_questtionaire_completion_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/2_financial_dependency_questionnaire/financial_dependency_question.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/1_protection_horizon_questionnaire/models/protection_horizon_answers.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';

class ProtectionQuestionnaireController extends GetxController {
  Future<void> loadContinuityMonthlyTotals() async {
    final protectionPlan = await database.protectionDao
        .getActiveProtectionPlan();

    if (protectionPlan == null) return;

    for (final type in ProtectionType.values) {
      final monthlyAmount = await database.protectionDao
          .getExpenseContinuityMonthlyExpense(
            protectionPlanId: protectionPlan.id,
            protectionType: type,
          );

      continuityMonthlyTotals[type] = monthlyAmount ?? 0.0;
    }
  }

  Future<double> refreshTotalMonthlyContinuityExpense({
    required List<SavedCashflowPlanData> plans,
    required ProtectionType type,
    required int protectionNeedId,
  }) async {
    final total = await calculateTotalMonthlyContinuityExpense(
      plans: plans,
      type: type,
    );

    await saveTotalMonthlyContinuityExpense(
      protectionNeedId: protectionNeedId,
      monthlyExpense: total,
    );

    return total;
  }

  Future<double> calculateTotalMonthlyContinuityExpense({
    required List<SavedCashflowPlanData> plans,
    required ProtectionType type,
  }) async {
    var total = 0.0;

    for (final plan in plans) {
      final share = getContinuityShare(plan.planId, type);

      final monthlyAmount = plan.budgetPeriod.toAnnual(plan.amount) / 12;

      total += monthlyAmount * share;
    }

    return total;
  }

  Future<void> saveTotalMonthlyContinuityExpense({
    required int protectionNeedId,
    required double monthlyExpense,
  }) async {
    await database.protectionDao.updateExpenseContinuityMonthlyExpense(
      protectionNeedId: protectionNeedId,
      monthlyExpense: monthlyExpense,
    );
  }

  final continuityMonthlyTotals = <ProtectionType, double>{}.obs;
  final Set<int> _loadingContinuityPlanIds = {};
  Future<void> updateContinuityShare({
    required int planId,
    required ProtectionType protectionType,
    required double share,
  }) async {
    final normalizedShare = share.clamp(0.0, 1.0);

    try {
      // 1. Save the individual cash flow plan's continuity share.
      await database.protectionDao.saveContinuityShare(
        cashFlowPlanId: planId,
        protectionType: protectionType,
        continuityShare: normalizedShare,
      );

      // 2. Update the in-memory continuity share.
      setContinuityShare(
        planId: planId,
        protectionType: protectionType,
        share: normalizedShare,
      );

      // 3. Load cash flow plans and calculate the total monthly expense.
      final plans = await cashflowController.watchSavedBudgetPlans().first;

      final total = await calculateTotalMonthlyContinuityExpense(
        plans: plans,
        type: protectionType,
      );

      // 4. Update the displayed total.
      continuityMonthlyTotals[protectionType] = total;

      // 5. Persist the total if an expense continuity record exists.
      final protectionPlan = await database.protectionDao
          .getActiveProtectionPlan();

      if (protectionPlan == null) return;

      final need = await database.protectionDao.getProtectionNeed(
        protectionPlanId: protectionPlan.id,
        protectionType: protectionType,
        needType: ProtectionNeedType.expenseContinuity,
      );

      if (need != null) {
        await database.protectionDao.updateExpenseContinuityMonthlyExpense(
          protectionNeedId: need.id,
          monthlyExpense: total,
        );
      }
    } catch (error) {
      Get.snackbar(
        'Unable to save',
        'Your changes could not be saved. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _initializeQuestionnaire() async {
    // await database.protectionDao.seedDefaultProtectionScenarios();

    await Future.wait([
      loadProtectionHorizons(),
      loadFinancialDependency(),
      loadContinuityMonthlyTotals(),
    ]);
  }

  final CashflowController cashflowController = Get.find<CashflowController>();
  final RxMap<int, Map<ProtectionType, double>> continuityShares =
      <int, Map<ProtectionType, double>>{}.obs;

  double _defaultContinuityShare(ProtectionType protectionType) {
    return switch (protectionType) {
      ProtectionType.death => 0.0,
      ProtectionType.criticalIllness || ProtectionType.disability => 1.0,
    };
  }

  double getContinuityShare(int planId, ProtectionType protectionType) {
    return continuityShares[planId]?[protectionType] ??
        _defaultContinuityShare(protectionType);
  }

  void setContinuityShare({
    required int planId,
    required ProtectionType protectionType,
    required double share,
  }) {
    final updated = Map<ProtectionType, double>.from(
      continuityShares[planId] ?? const <ProtectionType, double>{},
    );

    updated[protectionType] = share.clamp(0.0, 1.0);
    continuityShares[planId] = updated;
  }

  final isSavingContinuityShares = false.obs;

  final Set<int> _loadedContinuityPlanIds = {};

  /// Load saved values once per plan ID.
  /// Missing protection types use their product-specific default share.
  /// Death benefit defaults to 0% because dependent expenses should be opted in.

  // Future<void> loadContinuitySharesForPlans({
  //   required int protectionPlanId,
  //   required Iterable<int> cashflowPlanIds,
  // }) async {
  //   for (final cashflowPlanId in cashflowPlanIds) {
  //     if (_loadedContinuityPlanIds.contains(cashflowPlanId) ||
  //         !_loadingContinuityPlanIds.add(cashflowPlanId)) {
  //       continue;
  //     }

  //     try {
  //       final saved = await database.protectionDao
  //           .getContinuitySharesForCashflowPlan(
  //             protectionPlanId: protectionPlanId,
  //             cashflowPlanId: cashflowPlanId,
  //           );

  //       continuityShares[cashflowPlanId] = {
  //         for (final type in ProtectionType.values)
  //           type: saved[type] ?? _defaultContinuityShare(type),
  //       };

  //       _loadedContinuityPlanIds.add(cashflowPlanId);
  //     } finally {
  //       _loadingContinuityPlanIds.remove(cashflowPlanId);
  //     }
  //   }
  // }
  Future<void> loadContinuitySharesForPlans1(Iterable<int> planIds) async {
    for (final planId in planIds) {
      if (_loadedContinuityPlanIds.contains(planId) ||
          !_loadingContinuityPlanIds.add(planId)) {
        continue;
      }

      try {
        final saved = await database.protectionDao.getContinuitySharesForPlan(
          planId,
        );

        continuityShares[planId] = {
          for (final type in ProtectionType.values)
            type: saved[type] ?? _defaultContinuityShare(type),
        };

        _loadedContinuityPlanIds.add(planId);
      } catch (_) {
        rethrow;
      } finally {
        _loadingContinuityPlanIds.remove(planId);
      }
    }
  }
  // Future<void> loadContinuitySharesForPlans(Iterable<int> planIds) async {
  //   for (final planId in planIds) {
  //     if (!_loadedContinuityPlanIds.add(planId)) {
  //       continue;
  //     }

  //     try {
  //       final saved = await database.protectionDao.getContinuitySharesForPlan(
  //         planId,
  //       );

  //       continuityShares[planId] = {
  //         for (final type in ProtectionType.values) type: saved[type] ?? 1.0,
  //       };
  //     } catch (_) {
  //       // Allow a retry if loading fails.
  //       _loadedContinuityPlanIds.remove(planId);
  //       rethrow;
  //     }
  //   }
  // }

  /// Persist all currently loaded plan shares.
  Future<bool> saveContinuityShares() async {
    if (isSavingContinuityShares.value) return false;

    isSavingContinuityShares.value = true;

    try {
      for (final planEntry in continuityShares.entries) {
        for (final type in ProtectionType.values) {
          await database.protectionDao.saveContinuityShare(
            cashFlowPlanId: planEntry.key,
            protectionType: type,
            continuityShare:
                planEntry.value[type] ?? _defaultContinuityShare(type),
          );
        }
      }

      return true;
    } catch (error) {
      Get.snackbar(
        'Unable to save',
        'Your survivor budget selections could not be saved. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return false;
    } finally {
      isSavingContinuityShares.value = false;
    }
  }

  final financialDependency = Rxn<FinancialDependency>();
  void setFinancialDependency(FinancialDependency dependency) {
    financialDependency.value = dependency;
  }

  Future<void> saveFinancialDependency() async {
    final dependency = financialDependency.value;

    if (dependency == null) {
      return;
    }

    await database.protectionDao.saveFinancialDependency(dependency);

    Get.back();
  }

  Future<void> loadFinancialDependency() async {
    financialDependency.value = await database.protectionDao
        .getFinancialDependency();
  }

  Rx<ProtectionHorizon> getHorizonObservable(ProtectionType type) {
    switch (type) {
      case ProtectionType.death:
        return deathBenefitHorizon;
      case ProtectionType.criticalIllness:
        return criticalIllnessBenefitHorizon;
      case ProtectionType.disability:
        return disabilityBenefitHorizon;
    }
  }

  final deathBenefitHorizon = ProtectionHorizon.zero.obs;

  final criticalIllnessBenefitHorizon = ProtectionHorizon.one.obs;

  final disabilityBenefitHorizon = ProtectionHorizon.two.obs;

  void setDeathBenefitHorizon(ProtectionHorizon horizon) {
    deathBenefitHorizon.value = horizon;
  }

  void setCriticalIllnessBenefitHorizon(ProtectionHorizon horizon) {
    criticalIllnessBenefitHorizon.value = horizon;
  }

  void setDisabilityBenefitHorizon(ProtectionHorizon horizon) {
    disabilityBenefitHorizon.value = horizon;
  }

  ProtectionHorizonAnswers get protectionHorizonAnswers {
    return ProtectionHorizonAnswers(
      death: deathBenefitHorizon.value,
      criticalIllness: criticalIllnessBenefitHorizon.value,
      disability: disabilityBenefitHorizon.value,
    );
  }

  Future<void> saveProtectionHorizon() async {
    await database.protectionDao.saveProtectionHorizons(
      protectionHorizonAnswers,
    );

    // Refresh the insurance planner's questionnaire status.
    final insuranceController = Get.find<InsurancePlannerController>();

    await insuranceController.checkInsuranceQuestionnaireCompletion();

    Get.back();
  }

  Future<void> saveSingleProtectionHorizon(ProtectionType type) async {
    final horizon = switch (type) {
      ProtectionType.death => protectionHorizonAnswers.death,
      ProtectionType.criticalIllness =>
        protectionHorizonAnswers.criticalIllness,
      ProtectionType.disability => protectionHorizonAnswers.disability,
    };

    if (!_isHorizonConfigured(horizon)) {
      Get.snackbar(
        'Horizon required',
        'Please select a protection horizon before saving.',
      );
      return;
    }

    await database.protectionDao.saveProtectionHorizon(
      protectionType: type,
      horizon: horizon,
    );

    Get.back();
  }

  bool _isHorizonConfigured(ProtectionHorizon? horizon) {
    return horizon != null;
  }
  // Future<void> saveProtectionHorizon() async {
  //   await database.protectionDao.saveProtectionHorizons(
  //     protectionHorizonAnswers,
  //   );

  //   Get.back();
  // }

  Future<void> loadProtectionHorizons() async {
    final scenarios = await database.protectionDao.getProtectionScenarios();

    for (final scenario in scenarios) {
      final horizon = ProtectionHorizon.values.firstWhere(
        (value) => value.name == scenario.horizon,
        orElse: () => ProtectionHorizon.zero,
      );

      switch (scenario.protectionType) {
        case 'death':
          deathBenefitHorizon.value = horizon;
          break;

        case 'criticalIllness':
          criticalIllnessBenefitHorizon.value = horizon;
          break;

        case 'disability':
          disabilityBenefitHorizon.value = horizon;
          break;
      }
    }
  }

  // @override
  // void onInit() {
  //   super.onInit();
  //   debugPrint('ProtectionQuestionnaireController initialized');
  //   _initializeQuestionnaire();
  // }
  @override
  void onInit() {
    super.onInit();

    debugPrint('QUESTIONNAIRE CONTROLLER: onInit');

    _initializeQuestionnaire()
        .then((_) {
          debugPrint('QUESTIONNAIRE CONTROLLER: initialization completed');
        })
        .catchError((Object error, StackTrace stackTrace) {
          debugPrint('QUESTIONNAIRE CONTROLLER: initialization failed: $error');
          debugPrintStack(stackTrace: stackTrace);
        });
  }

  @override
  void onClose() {
    debugPrint('QUESTIONNAIRE CONTROLLER: onClose');
    super.onClose();
  }
}
