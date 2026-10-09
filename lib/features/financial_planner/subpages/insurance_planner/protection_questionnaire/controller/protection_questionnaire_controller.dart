import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/2_financial_dependency_questionnaire/financial_dependency_question.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/1_protection_horizon_questionnaire/models/protection_horizon_answers.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';

class ProtectionQuestionnaireController extends GetxController {
  Future<void> _initializeQuestionnaire() async {
    await database.protectionDao.seedDefaultProtectionScenarios();

    await Future.wait([loadProtectionHorizons(), loadFinancialDependency()]);
  }

  final CashflowController cashflowController = Get.find<CashflowController>();
  final RxMap<int, Map<ProtectionType, double>> continuityShares =
      <int, Map<ProtectionType, double>>{}.obs;

  double getContinuityShare(int planId, ProtectionType protectionType) {
    return continuityShares[planId]?[protectionType] ?? 1.0;
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
  /// Missing protection types default to 100%.
  Future<void> loadContinuitySharesForPlans(Iterable<int> planIds) async {
    for (final planId in planIds) {
      if (!_loadedContinuityPlanIds.add(planId)) {
        continue;
      }

      try {
        final saved = await database.protectionDao.getContinuitySharesForPlan(
          planId,
        );

        continuityShares[planId] = {
          for (final type in ProtectionType.values) type: saved[type] ?? 1.0,
        };
      } catch (_) {
        // Allow a retry if loading fails.
        _loadedContinuityPlanIds.remove(planId);
        rethrow;
      }
    }
  }

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
            continuityShare: planEntry.value[type] ?? 1.0,
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

    Get.back();
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

  @override
  void onInit() {
    super.onInit();
    _initializeQuestionnaire();
  }
}
