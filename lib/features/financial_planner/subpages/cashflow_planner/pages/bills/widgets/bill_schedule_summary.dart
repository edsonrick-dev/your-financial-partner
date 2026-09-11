import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/controller/bill_controller.dart';
import 'package:intl/intl.dart';

class BillScheduleSummary extends GetView<BillController> {
  const BillScheduleSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Obx(() {
      final startDate = controller.nextPaymentDate.value;
      final frequency = controller.selectedPeriod.value;

      if (startDate == null || frequency == null) {
        return const SizedBox.shrink();
      }

      final dates = _generateNext12Months(
        startDate: startDate,
        frequency: frequency,
      );

      if (dates.isEmpty) {
        return const SizedBox.shrink();
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Payment Schedule', style: AppTextStyle.bodyM),
          const SizedBox(height: 8),

          ...dates.map(
            (date) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      DateFormat('MMMM d, yyyy').format(date),
                      style: AppTextStyle.bodyM.copyWith(
                        color: colorScheme.appText,
                      ),
                    ),
                  ),

                  Text(
                    '₱${controller.billAmount.value.toStringAsFixed(2)}',
                    style: AppTextStyle.bodyM.copyWith(
                      color: colorScheme.appText,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }

  List<DateTime> _generateNext12Months({
    required DateTime startDate,
    required BillsFrequency frequency,
  }) {
    final dates = <DateTime>[];

    final endDate = DateTime(
      startDate.year + 1,
      startDate.month,
      startDate.day,
    );

    final anchorDay = startDate.day;

    var currentDate = startDate;

    while (currentDate.isBefore(endDate)) {
      dates.add(currentDate);

      currentDate = _getNextOccurrence(
        currentDate,
        frequency,
        anchorDay: anchorDay,
      );
    }

    return dates;
  }

  DateTime _getNextOccurrence(
    DateTime date,
    BillsFrequency frequency, {
    required int anchorDay,
  }) {
    switch (frequency) {
      case BillsFrequency.monthly:
        return _addMonthsClamped(date, 1, anchorDay: anchorDay);

      case BillsFrequency.quarterly:
        return _addMonthsClamped(date, 3, anchorDay: anchorDay);

      case BillsFrequency.semiAnnual:
        return _addMonthsClamped(date, 6, anchorDay: anchorDay);

      case BillsFrequency.annual:
        return _addMonthsClamped(date, 12, anchorDay: anchorDay);

      case BillsFrequency.weekly:
        return date.add(const Duration(days: 7));

      case BillsFrequency.biWeekly:
      case BillsFrequency.fortnightly:
        return date.add(const Duration(days: 14));
    }
  }

  DateTime _addMonthsClamped(
    DateTime date,
    int months, {
    required int anchorDay,
  }) {
    final target = DateTime(date.year, date.month + months, 1);

    final lastDay = DateTime(target.year, target.month + 1, 0).day;

    return DateTime(target.year, target.month, anchorDay.clamp(1, lastDay));
  }
}
