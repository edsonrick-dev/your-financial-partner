import 'dart:math' as math;

import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/death_benefit_input.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/death_benefit_result.dart';

class DeathBenefitCalculator {
  final ExpenseContinuityCalculator expenseContinuityCalculator;

  const DeathBenefitCalculator({required this.expenseContinuityCalculator});

  DeathBenefitResult calculate({
    required DeathBenefitInput input,
    required double inflationRate,
    required double portfolioReturn,
    required int planValidityYears,
  }) {
    final supportYears = input.horizon.resolveYears(
      currentAge: input.currentAge,
      retirementAge: input.retirementAge,
    );

    final expenseContinuityResult = expenseContinuityCalculator.calculate(
      monthlyExpense: input.monthlyDependentExpenses,
      planValidityYears: planValidityYears,
      supportYears: supportYears,
      inflationRate: inflationRate,
      portfolioReturn: portfolioReturn,
    );

    final dependentExpenseContinuity = expenseContinuityResult.investedNeed;

    final totalDeathNeed =
        dependentExpenseContinuity +
        input.estateSettlementFund +
        input.liabilities +
        input.dependentsFutureNeeds +
        input.finalExpenses;

    final protectionGap = math
        .max(
          0,
          totalDeathNeed -
              input.existingDeathCoverage -
              input.eligibleExistingResources,
        )
        .toDouble();

    return DeathBenefitResult(
      dependentExpenseContinuity: dependentExpenseContinuity,
      estateSettlementFund: input.estateSettlementFund,
      liabilities: input.liabilities,
      dependentsFutureNeeds: input.dependentsFutureNeeds,
      finalExpenses: input.finalExpenses,
      eligibleExistingResources: input.eligibleExistingResources,
      totalDeathNeed: totalDeathNeed,
      existingDeathCoverage: input.existingDeathCoverage,
      protectionGap: protectionGap,
    );
  }
}
