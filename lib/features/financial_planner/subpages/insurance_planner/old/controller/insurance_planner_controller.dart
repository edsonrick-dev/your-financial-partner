import 'dart:async';
import 'dart:math';

import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/fake_data/fake_death_benefit_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/fake_data/fake_insurance_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/enums/protection_gap_severity_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/enums/protection_profile_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/2_financial_dependency_questionnaire/financial_dependency_question.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/death_benefit_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/death_benefit_input.dart';

enum DeathBenefitPage {
  financialDependency,
  protectionHorizon,
  survivorBudget,
  finalExpenses,
  obligations,
  existingProtection,
}

class InsurancePlannerController extends GetxController {
  final financialDependency = Rxn<FinancialDependency>();
  final isExpenseContinuityCompleted = false.obs;
  StreamSubscription<FinancialDependency?>? _financialDependencySubscription;

  bool get isFinancialDependencyCompleted => financialDependency.value != null;

  Future<void> loadFinancialDependency() async {
    financialDependency.value = await database.protectionDao
        .getFinancialDependency();
  }

  final protectionScenarios = <ProtectionScenariosTableData>[].obs;

  StreamSubscription<List<ProtectionScenariosTableData>>?
  _protectionSubscription;

  bool get isProtectionHorizonCompleted => protectionScenarios.length == 3;

  final isInsuranceQuestionnairesFinished = false.obs;
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

    calculateDeathBenefit();
  }

  @override
  void onClose() async {
    _protectionSubscription?.cancel();
    _financialDependencySubscription?.cancel();
    super.onClose();
  }

  void calculateDeathBenefit() {
    final calculator = DeathBenefitCalculator(
      expenseContinuityCalculator: ExpenseContinuityCalculator(),
    );

    final result = calculator.calculate(
      input: DeathBenefitInput(
        horizon: ProtectionHorizon.ten,
        monthlyDependentExpenses: FakeDeathBenefitData.monthlyDependentExpenses,

        // Temporary zeros — we'll replace these later.
        estateSettlementFund: 0,
        liabilities: 0,
        dependentsFutureNeeds: 0,
        finalExpenses: 0,
        eligibleExistingResources: 0,
        existingDeathCoverage: 0,

        // Temporary values for resolving the horizon.
        currentAge: 28,
        retirementAge: 60,
      ),

      inflationRate: FakeDeathBenefitData.inflationRate,

      portfolioReturn: FakeDeathBenefitData.portfolioReturn,

      planValidityYears: FakeDeathBenefitData.planValidityYears,
    );

    // print(
    //   'Expense Continuity: '
    //   '${result.dependentExpenseContinuity}',
    // );

    // print(
    //   'Total Death Need: '
    //   '${result.totalDeathNeed}',
    // );

    // print(
    //   'Protection Gap: '
    //   '${result.protectionGap}',
    // );

    deathBenefitNeed.value = result.totalDeathNeed;

    deathBenefitCovered.value = result.existingDeathCoverage;
  }

  // Protection needs
  final deathBenefitNeed = FakeInsuranceData.deathBenefitNeed.obs;
  final criticalIllnessNeed = FakeInsuranceData.criticalIllnessNeed.obs;
  final disabilityNeed = FakeInsuranceData.disabilityNeed.obs;

  // Existing protection
  final deathBenefitCovered = FakeInsuranceData.deathBenefitCovered.obs;
  final criticalIllnessCovered = FakeInsuranceData.criticalIllnessCovered.obs;
  final disabilityCovered = FakeInsuranceData.disabilityCovered.obs;

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

  bool get canGoBackDeathBenefit => _deathBenefitPageHistory.isNotEmpty;

  ///FINANCIAL DEPENDENCY QUESTION
  // final financialDependency = FinancialDependency.none.obs;

  // bool get hasFinancialDependents {
  //   return financialDependency.value != null &&
  //       financialDependency.value != FinancialDependency.none;
  // }

  ///
  final deathBenefitPage = DeathBenefitPage.financialDependency.obs;
  // final deathBenefitPage = DeathBenefitPage.financialDependency.obs;

  final List<DeathBenefitPage> _deathBenefitPageHistory = [];
  void previousDeathBenefitPage() {
    if (_deathBenefitPageHistory.isEmpty) {
      return;
    }

    deathBenefitPage.value = _deathBenefitPageHistory.removeLast();
  }

  void nextDeathBenefitPage() {
    final currentPage = deathBenefitPage.value;

    DeathBenefitPage? nextPage;

    switch (currentPage) {
      case DeathBenefitPage.financialDependency:
        // if (financialDependency.value == FinancialDependency.none) {
        //   nextPage = DeathBenefitPage.finalExpenses;
        // } else {
        //   nextPage = DeathBenefitPage.protectionHorizon;
        // }
        break;

      case DeathBenefitPage.protectionHorizon:
        if (deathBenefitHorizon.value == ProtectionHorizon.zero) {
          nextPage = DeathBenefitPage.finalExpenses;
        } else {
          nextPage = DeathBenefitPage.survivorBudget;
        }
        break;

      case DeathBenefitPage.survivorBudget:
        nextPage = DeathBenefitPage.finalExpenses;
        break;

      case DeathBenefitPage.finalExpenses:
        nextPage = DeathBenefitPage.obligations;
        break;

      case DeathBenefitPage.obligations:
        nextPage = DeathBenefitPage.existingProtection;
        break;

      case DeathBenefitPage.existingProtection:
        // calculateDeathBenefit();
        return;
    }

    _deathBenefitPageHistory.add(currentPage);
    // deathBenefitPage.value = nextPage;
  }

  // void nextDeathBenefitPage() {
  //   switch (deathBenefitPage.value) {
  //     case DeathBenefitPage.financialDependency:
  //       if (hasFinancialDependents == true) {
  //         deathBenefitPage.value = DeathBenefitPage.protectionHorizon;
  //       } else {
  //         deathBenefitPage.value = DeathBenefitPage.finalExpenses;
  //       }
  //       break;

  //     case DeathBenefitPage.protectionHorizon:
  //       if (deathBenefitHorizon.value == ProtectionHorizon.zero) {
  //         deathBenefitPage.value = DeathBenefitPage.finalExpenses;
  //       } else {
  //         deathBenefitPage.value = DeathBenefitPage.survivorBudget;
  //       }
  //       break;

  //     case DeathBenefitPage.survivorBudget:
  //       deathBenefitPage.value = DeathBenefitPage.finalExpenses;
  //       break;

  //     case DeathBenefitPage.finalExpenses:
  //       deathBenefitPage.value = DeathBenefitPage.obligations;
  //       break;

  //     case DeathBenefitPage.obligations:
  //       deathBenefitPage.value = DeathBenefitPage.existingProtection;
  //       break;

  //     case DeathBenefitPage.existingProtection:
  //       // calculateDeathBenefit();
  //       break;
  //   }
  // }

  final deathBenefitHorizon = ProtectionHorizon.ten.obs;
  void setDeathBenefitHorizon(ProtectionHorizon horizon) {
    deathBenefitHorizon.value = horizon;
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
  // Recommendations
  // policies, filtering, selected policy, etc.

  // Protection score
  // calculations and severity classification
}
