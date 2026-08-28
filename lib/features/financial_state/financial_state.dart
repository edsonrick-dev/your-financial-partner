import 'package:getx_drift_app/features/profile/enum/financial_stability_level.dart';

class FinancialState {
  // Foundation
  final int accountCount;
  final bool hasAssets;
  final bool hasLiabilities;

  final bool hasIncomePlan;
  final bool hasBudgetPlan;
  final bool hasDebtPlan;

  final int transactionCount;

  // Cash Flow
  final double plannedIncome;
  final double plannedAllocation;

  final double actualIncome;
  final double actualSpending;

  final double budgetConfidence;

  // Net Worth
  final double totalAssets;
  final double totalLiabilities;
  final double netWorth;

  // Financial Ratios
  final double savingsRate;
  final double emergencyFundRatio;
  final double debtToIncomeRatio;
  final double lifestyleCoverageRatio;

  // Stability
  final FinancialStabilityLevel stabilityLevel;

  const FinancialState({
    required this.accountCount,
    required this.hasAssets,
    required this.hasLiabilities,
    required this.hasIncomePlan,
    required this.hasBudgetPlan,
    required this.hasDebtPlan,
    required this.transactionCount,
    required this.plannedIncome,
    required this.plannedAllocation,
    required this.actualIncome,
    required this.actualSpending,
    required this.budgetConfidence,
    required this.totalAssets,
    required this.totalLiabilities,
    required this.netWorth,
    required this.savingsRate,
    required this.emergencyFundRatio,
    required this.debtToIncomeRatio,
    required this.lifestyleCoverageRatio,
    required this.stabilityLevel,
  });

  bool get hasAssetsOrLiabilities => hasAssets || hasLiabilities;

  bool get hasFinancialFoundation =>
      hasAssetsOrLiabilities && hasIncomePlan && hasBudgetPlan;
}
