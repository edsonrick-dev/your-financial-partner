import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/enums/protection_gap_severity_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/enums/protection_profile_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/questionnaires/death_benefit_questionnaire/financial_dependency_question.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/questionnaires/protection_horizon/models/protection_horizon.dart';

enum DeathBenefitPage {
  financialDependency,
  protectionHorizon,
  survivorBudget,
  finalExpenses,
  obligations,
  existingProtection,
}

class InsurancePlannerController extends GetxController {
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
  final financialDependency = Rxn<FinancialDependency>();

  void setFinancialDependency(FinancialDependency value) {
    financialDependency.value = value;
  }

  bool get hasFinancialDependents {
    return financialDependency.value != null &&
        financialDependency.value != FinancialDependency.none;
  }

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
        if (financialDependency.value == FinancialDependency.none) {
          nextPage = DeathBenefitPage.finalExpenses;
        } else {
          nextPage = DeathBenefitPage.protectionHorizon;
        }
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
    deathBenefitPage.value = nextPage;
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
  // Protection amounts
  final deathBenefitCovered = 1000000.0.obs;
  final deathBenefitNeed = 2000000.0.obs;

  final criticalIllnessCovered = 500000.0.obs;
  final criticalIllnessNeed = 1000000.0.obs;

  final disabilityCovered = 1500000.0.obs;
  final disabilityNeed = 1500000.0.obs;
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

  final selectedDisabilityDetailsIndex = 0.obs;
  final selectedCriticalIllnessDetailsIndex = 0.obs;
  final selectedDeathDetailsIndex = 0.obs;
}
