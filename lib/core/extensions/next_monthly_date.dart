DateTime nextMonthlyDate({
  required DateTime selectedDate,
  required DateTime fromDate,
}) {
  var year = fromDate.year;
  var month = fromDate.month;

  if (selectedDate.day <= fromDate.day) {
    month++;
  }

  if (month > 12) {
    month = 1;
    year++;
  }

  final lastDay = DateTime(year, month + 1, 0).day;

  final day = selectedDate.day > lastDay ? lastDay : selectedDate.day;

  return DateTime(year, month, day);
}

DateTime monthlyOccurrence({
  required int year,
  required int month,
  required int day,
}) {
  final lastDayOfMonth = DateTime(year, month + 1, 0).day;

  return DateTime(year, month, day > lastDayOfMonth ? lastDayOfMonth : day);
}

DateTime calculateNextStatementDate({
  required DateTime selectedDate,
  required DateTime today,
}) {
  final anchorDay = selectedDate.day;

  var year = today.year;
  var month = today.month;

  var candidate = monthlyOccurrence(year: year, month: month, day: anchorDay);

  if (!candidate.isAfter(today)) {
    month++;

    if (month > 12) {
      month = 1;
      year++;
    }

    candidate = monthlyOccurrence(year: year, month: month, day: anchorDay);
  }

  return candidate;
}

DateTime calculatePaymentDueDate({
  required DateTime statementDate,
  required DateTime selectedDueDate,
}) {
  final dueDay = selectedDueDate.day;

  var year = statementDate.year;
  var month = statementDate.month + 1;

  if (month > 12) {
    month = 1;
    year++;
  }

  return monthlyOccurrence(year: year, month: month, day: dueDay);
}
