import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';

class Bill {
  final int id;
  final String name;
  final int categoryId;
  final double expectedAmount;
  final BillsFrequency frequency;

  final int? dayOfMonth;
  final int? monthMask;

  final bool reminderEnabled;
  final int? reminderDaysBefore;

  const Bill({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.expectedAmount,
    required this.frequency,
    this.dayOfMonth,
    this.monthMask,
    required this.reminderEnabled,
    this.reminderDaysBefore,
  });
}
