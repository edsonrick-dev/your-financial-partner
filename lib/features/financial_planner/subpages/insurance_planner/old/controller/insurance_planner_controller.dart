import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_result.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/enums/protection_gap_severity_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/enums/protection_profile_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/sections/protection_score_container_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/2_financial_dependency_questionnaire/financial_dependency_question.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/models/computation/death_benefit_result.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/2_critical_illness_benefit/models/critical_illness_benefit_result.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/3_disability_benefit/disability_benefit_result.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/extensions/insurance_questtionaire_completion_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/controller_extensions/calculate_death_benefit_controller_extension.dart';

/// Controller for the Insurance Planner feature.
///
/// This class keeps the planner's reactive state in one place: protection
/// calculation results, questionnaire completion, protection needs, existing
/// coverage, selected detail tabs, and survivor-budget helper data.
///
/// Product-specific calculations are intentionally kept in controller
/// extensions, such as `calculateDeathBenefit`, so this controller can stay
/// focused on shared state and UI coordination.
class InsurancePlannerController extends GetxController {
  final fakeDouble = 0.0.obs;

  /// Latest calculation result for each protection type.
  ///
  /// When a result is non-null, that protection type has enough data to show a
  /// calculated need, coverage gap, severity, and detail view.
  final deathBenefitResult = Rxn<DeathBenefitResult>();
  final criticalIllnessBenefitResult = Rxn<CriticalIllnessBenefitResult>();
  final disabilityBenefitResult = Rxn<DisabilityBenefitResult>();

  /// Whether each protection gap has already been calculated.
  Map<ProtectionType, bool> get protectionGapCompletion => {
    ProtectionType.death: deathBenefitResult.value != null,
    ProtectionType.criticalIllness: criticalIllnessBenefitResult.value != null,
    ProtectionType.disability: disabilityBenefitResult.value != null,
  };

  /// Whether all protection gaps have been calculated.
  bool get areAllProtectionGapsComplete =>
      protectionGapCompletion.values.every((isComplete) => isComplete);
  ProtectionAssessmentStatus get protectionAssessmentStatus {
    final completion = protectionGapCompletion;

    final completedCount = completion.values
        .where((isCompleted) => isCompleted)
        .length;

    if (completedCount == 0) {
      return ProtectionAssessmentStatus.notStarted;
    }

    if (completedCount == completion.length) {
      return ProtectionAssessmentStatus.completed;
    }

    return ProtectionAssessmentStatus.inProgress;
  }

  /// True once the required insurance questionnaires are complete.
  final isInsuranceQuestionnairesFinished = false.obs;

  /// Current in-memory death benefit horizon selection.
  ///
  /// Saved protection horizons come from `protectionScenarios`; this observable
  /// supports immediate UI updates while the user is editing.
  final deathBenefitHorizon = ProtectionHorizon.ten.obs;

  /// Controls whether the expense continuity projection details are expanded.
  final isExpenseProjectionExpanded = false.obs;

  /// Shared expense continuity result currently shown by the details UI.
  final expenseContinuityResult = Rxn<ExpenseContinuityResult>();

  /// Saved financial dependency answer from the dependency questionnaire.
  final financialDependency = Rxn<FinancialDependency>();

  /// True once lifestyle/expense continuity shares have been configured.
  final isExpenseContinuityCompleted = false.obs;

  /// Saved protection horizon/scenario rows for death, critical illness, and
  /// disability protection.
  final protectionScenarios = <ProtectionScenariosTableData>[].obs;

  /// Death benefit calculation loading and error state.
  final isCalculatingDeathBenefit = false.obs;
  final deathBenefitError = RxnString();

  /// Funds the family's living expenses after the insured person's death.
  final deathExpenseContinuityFund = 0.0.obs;

  /// Funds living expenses during a critical illness recovery period.
  final criticalIllnessExpenseContinuityFund = 0.0.obs;

  /// Funds living expenses during a disability income interruption.
  final disabilityExpenseContinuityFund = 0.0.obs;

  /// Estimated funeral and end-of-life expenses.
  final funeralAndFinalExpenseFund = 0.0.obs;

  /// Outstanding debts and obligations that should be settled.
  final debtsAndObligations = 0.0.obs;

  /// Estimated costs for settling the user's estate.
  final estateSettlementFund = 0.0.obs;

  /// Future education funding included in protection planning.
  final educationFunding = 0.0.obs;

  /// Total protection need for each protection type.
  final deathBenefitNeed = 0.0.obs;
  final criticalIllnessNeed = 0.0.obs;
  final disabilityNeed = 0.0.obs;

  /// Existing coverage or available sources for each protection type.
  final deathBenefitCovered = 0.0.obs;
  final criticalIllnessCovered = 0.0.obs;
  final disabilityCovered = 0.0.obs;

  /// Updates the death benefit horizon used by the UI.
  ///
  /// Persisting the answer happens in the protection questionnaire flow.
  void setDeathBenefitHorizon(ProtectionHorizon horizon) {
    deathBenefitHorizon.value = horizon;
  }

  /// Loads whether the user has configured continuity shares.
  Future<void> loadExpenseContinuityCompletion() async {
    isExpenseContinuityCompleted.value = await database.protectionDao
        .hasContinuityShares();
  }

  StreamSubscription<FinancialDependency?>? _financialDependencySubscription;

  /// Whether the financial dependency questionnaire has a saved answer.
  bool get isFinancialDependencyCompleted => financialDependency.value != null;

  /// Loads the saved financial dependency answer once.
  Future<void> loadFinancialDependency() async {
    financialDependency.value = await database.protectionDao
        .getFinancialDependency();
  }

  StreamSubscription<List<ProtectionScenariosTableData>>?
  _protectionSubscription;

  /// Whether all protection types have saved scenario/horizon rows.
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

  /// Performs initial completion checks and runs the first death benefit
  /// calculation for the current saved data.
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

  /// Uncovered death benefit amount after existing death coverage.
  double get deathBenefitGap =>
      max(0, deathBenefitNeed.value - deathBenefitCovered.value);

  /// Uncovered critical illness amount after existing critical illness coverage.
  double get criticalIllnessGap =>
      max(0, criticalIllnessNeed.value - criticalIllnessCovered.value);

  /// Uncovered disability amount after existing disability coverage.
  double get disabilityGap =>
      max(0, disabilityNeed.value - disabilityCovered.value);

  /// Selected tab indexes for each protection detail page.
  final selectedDisabilityDetailsIndex = 0.obs;
  final selectedCriticalIllnessDetailsIndex = 0.obs;
  final selectedDeathDetailsIndex = 0.obs;

  /// Survivor share by saved cashflow plan ID.
  ///
  /// A missing entry means 100% of that plan is included for survivor budgeting.
  final survivorShares = <int, double>{}.obs;

  /// Returns the survivor share for a plan, defaulting to 100%.
  double getSurvivorShare(int planId) {
    return survivorShares[planId] ?? 1.0;
  }

  /// Updates the survivor share for a saved cashflow plan.
  void setSurvivorShare(int planId, double share) {
    survivorShares[planId] = share;
  }

  /// Cashflow controller used to source saved expense plans.
  final CashflowController cashflowController = Get.find<CashflowController>();

  /// Watches saved expense plans that can be used as survivor budgets.
  Stream<List<SavedCashflowPlanData>> watchSurvivorBudgetPlans() {
    return cashflowController.watchSavedBudgetPlans().map(
      (plans) => plans.where((plan) => plan.planType == 'expense').toList(),
    );
  }

  RxBool isUnderConstruction = true.obs;
  RxBool justStarted = false.obs;

  /// Severity of the death benefit gap.
  ProtectionGapSeverity get deathBenefitSeverity => getProtectionGapSeverity(
    amountCovered: deathBenefitCovered.value,
    amountNeed: deathBenefitNeed.value,
  );

  /// Severity of the critical illness protection gap.
  ProtectionGapSeverity get criticalIllnessSeverity => getProtectionGapSeverity(
    amountCovered: criticalIllnessCovered.value,
    amountNeed: criticalIllnessNeed.value,
  );

  /// Severity of the disability protection gap.
  ProtectionGapSeverity get disabilitySeverity => getProtectionGapSeverity(
    amountCovered: disabilityCovered.value,
    amountNeed: disabilityNeed.value,
  );

  /// Overall protection profile derived from all gap severities.
  ProtectionProfile get protectionProfile {
    return getProtectionProfile([
      deathBenefitSeverity,
      criticalIllnessSeverity,
      disabilitySeverity,
    ]);
  }

  /// Number of protection types that are not fully covered.
  int get unmetProtectionGoals {
    return [
      deathBenefitSeverity,
      criticalIllnessSeverity,
      disabilitySeverity,
    ].where((severity) => severity != ProtectionGapSeverity.covered).length;
  }
}
