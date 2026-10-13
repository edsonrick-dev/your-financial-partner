import 'dart:math' as math;

import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_fund_details_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/models/protection_benefit_input.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';

class ProtectionBenefitCalculator {
  final ExpenseContinuityCalculator expenseContinuityCalculator;

  const ProtectionBenefitCalculator({
    required this.expenseContinuityCalculator,
  });

  ProtectionBenefitResult calculate({
    required ProtectionBenefitInput input,
    required double inflationRate,
    required double portfolioReturn,
    required int planValidityYears,
  }) {
    // // This calculator handles critical illness and disability.
    // // Death benefits continue to use DeathBenefitCalculator.
    // if (input.protectionType == ProtectionType.death) {
    //   throw ArgumentError(
    //     'Use DeathBenefitCalculator for death benefit calculations.',
    //   );
    // }

    // if (input.horizon == ProtectionHorizon.untilRetirement &&
    //     (input.currentAge == null || input.retirementAge == null)) {
    //   throw ArgumentError(
    //     'Current age and retirement age are required '
    //     'for an until-retirement horizon.',
    //   );
    // }

    final supportYears = input.horizon.resolveYears(
      currentAge: input.currentAge ?? 0,
      retirementAge: input.retirementAge ?? 0,
    );

    // Calculate expense continuity.
    final expenseContinuityResult = expenseContinuityCalculator.calculate(
      monthlyExpense: input.monthlyContinuityExpenses,
      planValidityYears: planValidityYears,
      supportYears: supportYears,
      inflationRate: inflationRate,
      portfolioReturn: portfolioReturn,
    );

    final expenseContinuityFund = expenseContinuityResult.investedNeed;

    // Critical illness and disability-specific calculations.
    final medicalAndRecoveryFund =
        input.protectionType == ProtectionType.criticalIllness ||
            input.protectionType == ProtectionType.disability
        ? input.medicalAndRecoveryFund
        : 0.0;

    // Gross funding requirement before deductions.
    final totalProtectionNeed =
        expenseContinuityFund + medicalAndRecoveryFund + input.liabilities;

    // Deduct eligible financial resources and existing insurance.
    final protectionGap = math.max(
      0.0,
      totalProtectionNeed -
          input.eligibleExistingResources -
          input.existingCoverage,
    );

    final expenseContinuityDetails = ExpenseContinuityFundDetailsData(
      planDate: DateTime.now(),
      monthlyExpense: input.monthlyContinuityExpenses,
      planValidityYears: planValidityYears,
      supportYears: supportYears,
      inflationRate: inflationRate,
      portfolioReturn: portfolioReturn,
      result: expenseContinuityResult,
    );

    return ProtectionBenefitResult(
      protectionType: input.protectionType,
      horizon: input.horizon,
      expenseContinuityFund: expenseContinuityFund,
      medicalAndRecoveryFund: medicalAndRecoveryFund,
      liabilities: input.liabilities,
      eligibleExistingResources: input.eligibleExistingResources,
      existingCoverage: input.existingCoverage,
      totalProtectionNeed: totalProtectionNeed,
      protectionGap: protectionGap,
      expenseContinuityResult: expenseContinuityResult,
      expenseContinuityDetails: expenseContinuityDetails,
    );
  }
}
