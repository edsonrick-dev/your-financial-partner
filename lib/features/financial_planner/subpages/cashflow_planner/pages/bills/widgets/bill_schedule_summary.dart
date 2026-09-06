import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/controller/bill_controller.dart';

class BillScheduleSummary extends GetView<BillController> {
  const BillScheduleSummary({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Obx(() {
      final nextDueDate = controller.nextDueDate.value;

      if (nextDueDate == null) {
        return const SizedBox.shrink();
      }

      final reminderDays = controller.reminderDaysBefore.value;

      final reminderDate =
          controller.reminderEnabled.value && reminderDays != null
          ? nextDueDate.subtract(Duration(days: reminderDays))
          : null;

      return Container(
        // height: 44,
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.appBorderMuted),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Text('Bill Summary', style: AppTextStyle.titleM),

            Text(
              'Your next bill is due on '
              '${_formatDate(nextDueDate)}.',
              style: AppTextStyle.bodyM,
            ),

            if (reminderDate != null)
              Text(
                'You\'ll be reminded on '
                '${_formatDate(reminderDate)}.',
                style: AppTextStyle.bodyM.copyWith(
                  color: colorScheme.appTextMuted,
                ),
              ),
          ],
        ),
      );
    });
  }

  String _formatDate(DateTime date) {
    final month = AppMonth.values[date.month - 1];

    return '${month.fullName} ${date.day}, ${date.year}';
  }
}
