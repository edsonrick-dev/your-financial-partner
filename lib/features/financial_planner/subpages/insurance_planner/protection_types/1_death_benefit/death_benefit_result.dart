class DeathBenefitResult {
  final double dependentExpenseContinuity;
  final double estateSettlementFund;
  final double liabilities;
  final double dependentsFutureNeeds;
  final double finalExpenses;
  final double eligibleExistingResources;

  final double totalDeathNeed;
  final double existingDeathCoverage;
  final double protectionGap;

  const DeathBenefitResult({
    required this.dependentExpenseContinuity,
    required this.estateSettlementFund,
    required this.liabilities,
    required this.dependentsFutureNeeds,
    required this.finalExpenses,
    required this.eligibleExistingResources,
    required this.totalDeathNeed,
    required this.existingDeathCoverage,
    required this.protectionGap,
  });
}
