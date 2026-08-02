import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:intl/intl.dart';

class BillsCard extends StatelessWidget {
  final String billName;
  final String billType;
  final DateTime dueDate;
  final double amountDue;
  final String iconKey;
  const BillsCard({
    super.key,
    required this.billName,
    required this.billType,
    required this.dueDate,
    required this.amountDue,
    required this.iconKey,
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

    Color getDueDateColor(DateTime dueDate, BuildContext context) {
      final now = DateTime.now();

      final today = DateTime(now.year, now.month, now.day);
      final due = DateTime(dueDate.year, dueDate.month, dueDate.day);

      final days = due.difference(today).inDays;
      final colors = context.colors;
      if (days <= 2) {
        return colors.appError;
      }

      if (days <= 7) {
        return colors.appText;
      }

      return colors.appText;
    }

    final dueText = getDueText(dueDate);
    Color iconColor = colorScheme.appInfo;
    return AdaptivePressable(
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(24),
          // border: Border.all(color: colorScheme.appBorder, width: 0.5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  AppIcons.categories.resolve(iconKey),
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
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                spacing: 12,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(billName, style: AppTextStyle.bodyM),

                          RichText(
                            text: TextSpan(
                              text: billType,
                              style: AppTextStyle.labelS.copyWith(
                                color: colorScheme.appTextMuted,
                                fontWeight: FontWeight.w400,
                              ),
                              children: [
                                TextSpan(
                                  text: ' • ',
                                  style: AppTextStyle.labelS.copyWith(
                                    color: colorScheme.appTextMuted,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                TextSpan(
                                  text: DateFormat(
                                    'MMM d, yyyy',
                                  ).format(dueDate),
                                  style: AppTextStyle.labelS.copyWith(
                                    color: colorScheme.appTextMuted,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        // spacing: 2,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: amountDue.toCurrency(),
                              style: AppTextStyle.amountM.copyWith(
                                color: colorScheme.appText,
                              ),
                              children: [],
                            ),
                          ),
                          Text(
                            dueText,
                            style: AppTextStyle.labelS.copyWith(
                              color: colorScheme.appTextMuted,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
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
