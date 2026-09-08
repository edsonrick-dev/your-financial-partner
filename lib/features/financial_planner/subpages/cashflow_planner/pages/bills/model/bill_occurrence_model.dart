class BillOccurrence {
  final int id;
  final int billId;
  final DateTime dueDate;
  final double expectedAmount;

  const BillOccurrence({
    required this.id,
    required this.billId,
    required this.dueDate,
    required this.expectedAmount,
  });
}
