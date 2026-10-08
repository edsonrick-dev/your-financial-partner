class SurvivorBudget {
  final int planId;
  final double monthlyBudget;
  final double survivorShare;

  const SurvivorBudget({
    required this.planId,
    required this.monthlyBudget,
    required this.survivorShare,
  });

  double get monthlyDependentExpense => monthlyBudget * survivorShare;
}
