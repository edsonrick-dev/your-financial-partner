class SplitExpenseSummary {
  final double totalPaid;

  final double myShare;

  final double receivableAmount;

  final bool isSharedExpense;

  SplitExpenseSummary({
    required this.totalPaid,
    required this.myShare,
    required this.receivableAmount,
    required this.isSharedExpense,
  });
}
