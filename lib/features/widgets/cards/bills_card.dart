import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_category.dart';

class BillsCard extends StatelessWidget {
  final BillWithCategory bill;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  const BillsCard({
    super.key,
    required this.bill,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    String getDueText(DateTime dueDate) {
      final now = DateTime.now();

      final today = DateTime(now.year, now.month, now.day);
      final due = DateTime(dueDate.year, dueDate.month, dueDate.day);

      final days = due.difference(today).inDays;

      if (days == 0) {
        return 'Due today';
      }

      if (days == 1) {
        return 'Due tomorrow';
      }

      if (days == -1) {
        return 'Overdue by 1 day';
      }

      if (days < -1) {
        return 'Overdue by ${days.abs()} days';
      }

      if (days <= 7) {
        return 'Due in $days days';
      }

      return '';
    }

    // Color getDueDateColor(DateTime dueDate, BuildContext context) {
    //   final now = DateTime.now();

    //   final today = DateTime(now.year, now.month, now.day);
    //   final due = DateTime(dueDate.year, dueDate.month, dueDate.day);

    //   final days = due.difference(today).inDays;
    //   final colors = context.colors;
    //   if (days <= 2) {
    //     return colors.appError;
    //   }

    //   if (days <= 7) {
    //     return colors.appText;
    //   }

    //   return colors.appText;
    // }

    // final dueText = getDueText(bill.occurrence.dueDate);
    // final dueDate = bill.occurrence.dueDate;
    final amountDue = bill.bill.expectedAmount;
    final frequency = BillsFrequency.values.firstWhere(
      (e) => e.name == bill.bill.frequency,
    );

    String getScheduleText() {
      final day = bill.bill.dayOfMonth;

      if (day == null) {
        return '';
      }

      if (frequency == BillsFrequency.monthly) {
        return 'Every $day${_ordinalSuffix(day)} of the month';
      }

      final monthMask = bill.bill.monthMask ?? 0;

      final months = AppMonth.values.where((month) {
        return monthMask & (1 << (month.number - 1)) != 0;
      }).toList();

      return months.map((month) => '${month.shortName} $day').join(' | ');
    }

    final scheduleText = getScheduleText();

    Color iconColor = colorScheme.appInfo;
    return AdaptivePressable(
      onLongPress: onLongPress,
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(24),
          // border: Border.all(color: colorScheme.appBorder, width: 0.5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  AppIcons.categories.resolve(bill.category.icon),
                  size: 20,
                  color: iconColor,
                ),
                Opacity(
                  opacity: 0.1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: iconColor,
                    ),
                    height: 44,
                    width: 44,
                  ),
                ),
              ],
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,

                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(bill.bill.name, style: AppTextStyle.bodyM),
                      ),
                      SizedBox(width: 16),
                      Text(
                        amountDue.toCurrency(),
                        style: AppTextStyle.amountM.copyWith(
                          color: colorScheme.appText,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          scheduleText,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyle.labelS.copyWith(
                            color: colorScheme.appTextMuted,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        frequency.label,
                        style: AppTextStyle.labelS.copyWith(
                          color: colorScheme.appText,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}

String _ordinalSuffix(int day) {
  if (day >= 11 && day <= 13) {
    return 'th';
  }

  switch (day % 10) {
    case 1:
      return 'st';
    case 2:
      return 'nd';
    case 3:
      return 'rd';
    default:
      return 'th';
  }
}
