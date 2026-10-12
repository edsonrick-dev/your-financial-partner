import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/utils/age_calculator.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/fake_data/fake_death_benefit_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/fake_data/fake_insurance_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_result.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/enums/protection_gap_severity_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/enums/protection_profile_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/2_financial_dependency_questionnaire/financial_dependency_question.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/models/death_benefit_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/models/death_benefit_input.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/models/death_benefit_result.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/2_critical_illness_benefit/models/critical_illness_benefit_result.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/3_disability_benefit/disability_benefit_result.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/extensions/insurance_questtionaire_completion_extension.dart';

class InsurancePlannerController extends GetxController {
  final deathBenefitResult = Rxn<DeathBenefitResult>();
  final criticalIllnessBenefitResult = Rxn<CriticalIllnessBenefitResult>();
  final disabilityBenefitResult = Rxn<DisabilityBenefitResult>();
  Map<ProtectionType, bool> get protectionGapCompletion => {
    ProtectionType.death: deathBenefitResult.value != null,
    ProtectionType.criticalIllness: criticalIllnessBenefitResult.value != null,
    ProtectionType.disability: disabilityBenefitResult.value != null,
  };
  final isInsuranceQuestionnairesFinished = false.obs;
  final deathBenefitHorizon = ProtectionHorizon.ten.obs;
  final isExpenseProjectionExpanded = false.obs;

  final expenseContinuityResult = Rxn<ExpenseContinuityResult>();
  final financialDependency = Rxn<FinancialDependency>();
  final isExpenseContinuityCompleted = false.obs;
  final protectionScenarios = <ProtectionScenariosTableData>[].obs;
  final isCalculatingDeathBenefit = false.obs;
  final deathBenefitError = RxnString(); // Protection needs
  ///Funds the family's living expenses after the insured person's death.
  final deathExpenseContinuityFund = 0.0.obs;
  final criticalIllnessExpenseContinuityFund = 0.0.obs;
  final disabilityExpenseContinuityFund = 0.0.obs;

  final funeralAndFinalExpenseFund = 4726.35.obs;
  final debtsAndObligations = 4726.35.obs;
  final estateSettlementFund = 4726.35.obs;
  final educationFunding = 4726.35.obs;
  final deathBenefitNeed = FakeInsuranceData.deathBenefitNeed.obs;
  final criticalIllnessNeed = FakeInsuranceData.criticalIllnessNeed.obs;
  final disabilityNeed = FakeInsuranceData.disabilityNeed.obs;

  // Existing protection
  final deathBenefitCovered = FakeInsuranceData.deathBenefitCovered.obs;
  final criticalIllnessCovered = FakeInsuranceData.criticalIllnessCovered.obs;
  final disabilityCovered = FakeInsuranceData.disabilityCovered.obs;

  void setDeathBenefitHorizon(ProtectionHorizon horizon) {
    deathBenefitHorizon.value = horizon;
  }

  Future<void> loadExpenseContinuityCompletion() async {
    isExpenseContinuityCompleted.value = await database.protectionDao
        .hasContinuityShares();
  }

  StreamSubscription<FinancialDependency?>? _financialDependencySubscription;

  bool get isFinancialDependencyCompleted => financialDependency.value != null;

  Future<void> loadFinancialDependency() async {
    financialDependency.value = await database.protectionDao
        .getFinancialDependency();
  }

  StreamSubscription<List<ProtectionScenariosTableData>>?
  _protectionSubscription;

  bool get isProtectionHorizonCompleted => protectionScenarios.length == 3;

  @override
  void onInit() {
    super.onInit();

    _protectionSubscription = database.protectionDao
        .watchProtectionScenarios()
        .listen(
          protectionScenarios.assignAll,
          onError: (error, stackTrace) {
            // print('Protection scenarios stream error: $error');
            // print(stackTrace);
          },
        );
    _financialDependencySubscription = database.protectionDao
        .watchFinancialDependency()
        .listen(
          (dependency) {
            financialDependency.value = dependency;
          },
          onError: (error, stackTrace) {
            // handle error
          },
        );
    loadExpenseContinuityCompletion();

    _initializeInsurancePlanner();
    // calculateDeathBenefit();
  }

  Future<void> _initializeInsurancePlanner() async {
    await checkInsuranceQuestionnaireCompletion();
    await calculateDeathBenefit();
  }

  @override
  void onClose() async {
    _protectionSubscription?.cancel();
    _financialDependencySubscription?.cancel();
    super.onClose();
  }

  Future<void> calculateDeathBenefit() async {
    // 1. Load the saved death benefit horizon.
    final scenarios = await database.protectionDao.getProtectionScenarios();

    final deathScenario = scenarios.firstWhereOrNull(
      (scenario) => scenario.protectionType == ProtectionType.death.name,
    );

    if (deathScenario == null) return;

    final horizon = ProtectionHorizon.values.firstWhere(
      (value) => value.name == deathScenario.horizon,
    );

    // 2. Load the user's birthday.
    final profile = await database.userProfileDao.getProfile();
    final birthday = profile?.birthday;

    // Birthday is optional for now.
    // Skip calculation until the user provides one.
    if (birthday == null) {
      debugPrint('Death benefit calculation skipped: birthday not configured.');
      return;
    }

    final currentAge = calculateAge(birthday);

    // 3. Load saved expense plans and calculate monthly survivor expenses.
    final plans = await cashflowController.watchSavedBudgetPlans().first;

    final monthlyDependentExpenses = await database.protectionDao
        .calculateMonthlyDependentExpenses(plans);

    // 4. Calculate the death benefit.
    final calculator = DeathBenefitCalculator(
      expenseContinuityCalculator: ExpenseContinuityCalculator(),
    );

    final result = calculator.calculate(
      input: DeathBenefitInput(
        horizon: horizon,
        monthlyDependentExpenses: monthlyDependentExpenses,
        estateSettlementFund: 0,
        liabilities: 0,
        dependentsFutureNeeds: 0,
        finalExpenses: 0,
        eligibleExistingResources: 0,
        existingDeathCoverage: 0,
        currentAge: currentAge,
        retirementAge: 60,
      ),
      inflationRate: FakeDeathBenefitData.inflationRate,
      portfolioReturn: FakeDeathBenefitData.portfolioReturn,
      planValidityYears: FakeDeathBenefitData.planValidityYears,
    );

    deathBenefitResult.value = result;
    expenseContinuityResult.value = result.expenseContinuityResult;
    deathExpenseContinuityFund.value = result.dependentExpenseContinuity;
    deathBenefitNeed.value = result.totalDeathNeed;
    deathBenefitCovered.value = result.existingDeathCoverage;

    debugPrint('HORIZON: $horizon');
    debugPrint('MONTHLY DEPENDENT EXPENSES: $monthlyDependentExpenses');
    debugPrint('DEATH BENEFIT NEED: ${deathBenefitNeed.value}');
  }

  // Protection gap
  double get deathBenefitGap =>
      max(0, deathBenefitNeed.value - deathBenefitCovered.value);

  double get criticalIllnessGap =>
      max(0, criticalIllnessNeed.value - criticalIllnessCovered.value);

  double get disabilityGap =>
      max(0, disabilityNeed.value - disabilityCovered.value);

  final selectedDisabilityDetailsIndex = 0.obs;
  final selectedCriticalIllnessDetailsIndex = 0.obs;
  final selectedDeathDetailsIndex = 0.obs;

  final survivorShares = <int, double>{}.obs;

  double getSurvivorShare(int planId) {
    return survivorShares[planId] ?? 1.0;
  }

  void setSurvivorShare(int planId, double share) {
    survivorShares[planId] = share;
  }

  final CashflowController cashflowController = Get.find<CashflowController>();

  Stream<List<SavedCashflowPlanData>> watchSurvivorBudgetPlans() {
    return cashflowController.watchSavedBudgetPlans().map(
      (plans) => plans.where((plan) => plan.planType == 'expense').toList(),
    );
  }

  RxBool isUnderConstruction = true.obs;
  RxBool justStarted = false.obs;

  ProtectionGapSeverity get deathBenefitSeverity => getProtectionGapSeverity(
    amountCovered: deathBenefitCovered.value,
    amountNeed: deathBenefitNeed.value,
  );

  ProtectionGapSeverity get criticalIllnessSeverity => getProtectionGapSeverity(
    amountCovered: criticalIllnessCovered.value,
    amountNeed: criticalIllnessNeed.value,
  );

  ProtectionGapSeverity get disabilitySeverity => getProtectionGapSeverity(
    amountCovered: disabilityCovered.value,
    amountNeed: disabilityNeed.value,
  );

  ProtectionProfile get protectionProfile {
    return getProtectionProfile([
      deathBenefitSeverity,
      criticalIllnessSeverity,
      disabilitySeverity,
    ]);
  }

  int get unmetProtectionGoals {
    return [
      deathBenefitSeverity,
      criticalIllnessSeverity,
      disabilitySeverity,
    ].where((severity) => severity != ProtectionGapSeverity.covered).length;
  }
}
