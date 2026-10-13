import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/utils/age_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/models/computation/death_benefit_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/models/computation/death_benefit_input.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';

extension CalculateDeathBenefitControllerExtension
    on InsurancePlannerController {
  Future<void> calculateDeathBenefit() async {
    // 1. Load the saved death benefit horizon.
    final protectionType = ProtectionType.death;
    final scenarios = await database.protectionDao.getProtectionScenarios();

    final scenario = scenarios.firstWhereOrNull(
      (scenario) => scenario.protectionType == protectionType.name,
    );

    if (scenario == null) return;

    final horizon = ProtectionHorizon.values.firstWhere(
      (value) => value.name == scenario.horizon,
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
        .calculateMonthlyDependentExpenses(
          plans,
          protectionType: protectionType,
        );

    // 4. Calculate the death benefit.
    final calculator = DeathBenefitCalculator(
      expenseContinuityCalculator: ExpenseContinuityCalculator(),
    );
    debugPrint('$monthlyDependentExpenses');

    final result = calculator.calculate(
      input: DeathBenefitInput(
        horizon: horizon,
        monthlyDependentExpenses: monthlyDependentExpenses,
        estateSettlementFund: estateSettlementFund.value,
        liabilities: debtsAndObligations.value,
        dependentsFutureNeeds: educationFunding.value,
        finalExpenses: funeralAndFinalExpenseFund.value,
        eligibleExistingResources: 0,
        existingDeathCoverage: 0,
        currentAge: currentAge,
        retirementAge: 60,
      ),
      inflationRate: 0.03,
      portfolioReturn: 0.06,
      planValidityYears: 5,
    );

    deathBenefitResult.value = result;
    expenseContinuityResult.value = result.expenseContinuityResult;
    deathExpenseContinuityFund.value = result.dependentExpenseContinuity;
    deathBenefitNeed.value = result.totalDeathNeed;
    deathBenefitCovered.value = result.existingDeathCoverage;
  }
}
