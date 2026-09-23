class CreditCardDates {
  CreditCardDates._();

  /// Returns the next statement date based on the configured
  /// statement day of the month.
  ///
  /// Rules:
  /// - If the statement day has not passed, use the current month.
  /// - If today IS the statement day, use the current month.
  /// - If the statement day has already passed, use the next month.
  static DateTime nextStatementDate({
    required DateTime fromDate,
    required int statementDay,
  }) {
    if (statementDay < 1 || statementDay > 31) {
      throw ArgumentError('statementDay must be between 1 and 31.');
    }

    final year = fromDate.year;
    final month = fromDate.month;

    if (fromDate.day <= statementDay) {
      return _safeDate(year, month, statementDay);
    }

    return _safeDate(year, month + 1, statementDay);
  }

  /// Returns the payment due date based on the statement date
  /// and configured payment due day.
  ///
  /// Rules:
  /// - If the due day is after the statement day, use the same month.
  /// - If the due day IS the statement day, use the same month.
  /// - If the due day is before the statement day, use the next month.
  static DateTime paymentDueDate({
    required DateTime statementDate,
    required int paymentDueDay,
  }) {
    if (paymentDueDay < 1 || paymentDueDay > 31) {
      throw ArgumentError('paymentDueDay must be between 1 and 31.');
    }

    final year = statementDate.year;
    final month = statementDate.month;

    if (paymentDueDay >= statementDate.day) {
      return _safeDate(year, month, paymentDueDay);
    }

    return _safeDate(year, month + 1, paymentDueDay);
  }

  /// Creates a valid date even when the configured day does not exist
  /// in the target month.
  ///
  /// Example:
  /// February 31 -> February 28/29
  /// April 31 -> April 30
  static DateTime _safeDate(int year, int month, int day) {
    final lastDayOfMonth = DateTime(year, month + 1, 0).day;

    return DateTime(year, month, day > lastDayOfMonth ? lastDayOfMonth : day);
  }

  /// Advances from an existing statement date to the next
  /// statement occurrence while preserving the recurring day.
  static DateTime advanceStatementDate({
    required DateTime currentStatementDate,
    required int statementDay,
  }) {
    final nextMonth = DateTime(
      currentStatementDate.year,
      currentStatementDate.month + 1,
      1,
    );

    return _dateForDay(nextMonth.year, nextMonth.month, statementDay);
  }

  /// Calculates the payment due date for an already-calculated
  /// statement date.
  static DateTime advancePaymentDueDate({
    required DateTime nextStatementDate,
    required int paymentDueDay,
  }) {
    return paymentDueDate(
      statementDate: nextStatementDate,
      paymentDueDay: paymentDueDay,
    );
  }

  /// Creates a date using the requested day, clamping it to
  /// the last valid day of the month.
  static DateTime _dateForDay(int year, int month, int requestedDay) {
    final lastDayOfMonth = DateTime(year, month + 1, 0).day;

    final day = requestedDay.clamp(1, lastDayOfMonth);

    return DateTime(year, month, day);
  }

  static DateTime previousStatementDate({
    required DateTime statementDate,
    required int statementDay,
  }) {
    if (statementDay < 1 || statementDay > 31) {
      throw ArgumentError('statementDay must be between 1 and 31.');
    }

    final previousMonth = DateTime(
      statementDate.year,
      statementDate.month - 1,
      1,
    );

    return _dateForDay(previousMonth.year, previousMonth.month, statementDay);
  }
}
