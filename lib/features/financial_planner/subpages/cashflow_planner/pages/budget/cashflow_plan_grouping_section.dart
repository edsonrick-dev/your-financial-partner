import 'package:getx_drift_app/data/models/transaction_with_details.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';

class CashflowPlanTransactionGrouping {
  static Map<String, List<TransactionWithDetails>> group({
    required List<TransactionWithDetails> transactions,
    required BudgetPeriod period,
  }) {
    final groups = <String, List<TransactionWithDetails>>{};

    for (final transaction in transactions) {
      final date = transaction.transaction.date;

      final key = switch (period) {
        BudgetPeriod.weekly => _weeklyLabel(date),
        BudgetPeriod.fortnightly => _fortnightlyLabel(date),
        BudgetPeriod.monthly => _monthlyLabel(date),
        BudgetPeriod.yearly => _yearlyLabel(date),
      };

      groups.putIfAbsent(key, () => []).add(transaction);
    }

    return groups;
  }

  // ============================================================
  // WEEKLY
  // Monday → Sunday
  // ============================================================

  static String _weeklyLabel(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);

    final weekStart = normalized.subtract(
      Duration(days: normalized.weekday - DateTime.monday),
    );

    final weekEnd = weekStart.add(const Duration(days: 6));

    final weekNumber = _isoWeekNumber(normalized);

    return 'Week $weekNumber • '
        '${_formatDate(weekStart)} – ${_formatDate(weekEnd)}';
  }

  // ============================================================
  // FORTNIGHTLY
  //
  // Calendar anchored:
  //
  // Jan 1  → Jan 14
  // Jan 15 → Jan 28
  // Jan 29 → Feb 11
  // ...
  // ============================================================

  static String _fortnightlyLabel(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);

    final yearStart = DateTime(normalized.year, 1, 1);

    final daysSinceYearStart = normalized.difference(yearStart).inDays;

    final fortnightIndex = daysSinceYearStart ~/ 14;

    final start = yearStart.add(Duration(days: fortnightIndex * 14));

    final end = start.add(const Duration(days: 13));

    return '${_formatDate(start)} – ${_formatDate(end)}';
  }

  // ============================================================
  // MONTHLY
  // ============================================================

  static String _monthlyLabel(DateTime date) {
    final month = date.appMonth;

    return '${month.fullName} ${date.year}';
  }

  // ============================================================
  // YEARLY
  // ============================================================

  static String _yearlyLabel(DateTime date) {
    return '${date.year}';
  }

  // ============================================================
  // ISO WEEK NUMBER
  // ============================================================

  static int _isoWeekNumber(DateTime date) {
    final normalized = DateTime(date.year, date.month, date.day);

    // ISO week belongs to the year containing Thursday.
    final thursday = normalized.add(
      Duration(days: DateTime.thursday - normalized.weekday),
    );

    final firstThursday = DateTime(thursday.year, 1, 4);

    final firstThursdayNormalized = firstThursday.add(
      Duration(days: DateTime.thursday - firstThursday.weekday),
    );

    return 1 + (thursday.difference(firstThursdayNormalized).inDays ~/ 7);
  }

  // ============================================================
  // DATE FORMAT
  // ============================================================

  static String _formatDate(DateTime date) {
    final month = date.appMonth;

    return '${month.shortName} ${date.day}';
  }
}
