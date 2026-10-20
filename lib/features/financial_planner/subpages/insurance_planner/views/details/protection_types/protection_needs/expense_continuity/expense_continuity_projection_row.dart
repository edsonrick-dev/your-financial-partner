import 'dart:math' as math;

class ExpenseContinuityProjectionRow {
  const ExpenseContinuityProjectionRow({
    required this.year,
    required this.fromNow,
    required this.yearCount,
    required this.amount,
  });

  final int year;
  final int fromNow;
  final int yearCount;
  final double amount;
}

List<ExpenseContinuityProjectionRow> buildProjectionRows({
  required double currentAnnualExpenses,
  required double inflationRate,
  required int planValidityYears,
  required int supportYears,
  required DateTime planDate,
}) {
  final rows = <ExpenseContinuityProjectionRow>[];

  final supportStartYear = planDate.year + planValidityYears;

  for (var index = 0; index < supportYears; index++) {
    final fromNow = planValidityYears + index;

    final projectedExpenses =
        currentAnnualExpenses * math.pow(1 + inflationRate, fromNow);

    rows.add(
      ExpenseContinuityProjectionRow(
        year: supportStartYear + index,
        fromNow: fromNow,
        yearCount: index + 1,
        amount: projectedExpenses,
      ),
    );
  }

  return rows;
}
