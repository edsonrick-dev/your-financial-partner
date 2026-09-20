import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/home/views/section_views/bills_reminder_section.dart';
import 'package:getx_drift_app/features/home/views/section_views/budget_progress_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_segmented_selector.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FinanceHomeView extends GetView<CashflowController> {
  const FinanceHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final index = controller.selectedBudgetIndex.value;
      final selectedMonth = controller.selectedMonth.value;
      final now = DateTime.now();

      final isCurrentMonth =
          selectedMonth.year == now.year && selectedMonth.month == now.month;
      // final colorScheme = context.colors;
      return AppSection(
        sectionTitle: isCurrentMonth
            ? "This Month's Finances"
            : "${DateFormat("MMMM").format(selectedMonth)} '${DateFormat("yy").format(selectedMonth)} Finances",
        trailingType: SectionTrailingType.custom,
        trailingWidget: Row(
          children: [
            if (!isCurrentMonth)
              AdaptivePressable(
                onTap: controller.goToCurrentMonth,
                child: SizedBox(
                  height: 44,
                  child: Center(
                    child: Text(
                      'Today',
                      style: AppTextStyle.titleM.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
              ),
            AdaptivePressable(
              onTap: controller.previousMonth,
              child: SizedBox(
                height: 44,
                width: 44,
                child: Icon(PhosphorIconsRegular.caretLeft, size: 20),
              ),
            ),

            AdaptivePressable(
              onTap: controller.nextMonth,
              child: SizedBox(
                height: 44,
                width: 44,
                child: Icon(PhosphorIconsRegular.caretRight, size: 20),
              ),
            ),
          ],
        ),
        child: Column(
          children: [
            AppSegmentedSelector(
              items: const ['My Budget', 'My Bills'],
              selectedIndex: index,
              onChanged: controller.selectBudget,
            ),

            const SizedBox(height: 12),

            AnimatedSize(
              duration: const Duration(milliseconds: 160),
              curve: Curves.easeInOut,
              alignment: Alignment.topCenter,
              child: index == 0
                  ? const BudgetProgressSection(key: ValueKey('budget'))
                  : const BillsReminderSection(key: ValueKey('bills')),
            ),
          ],
        ),
      );
    });
  }
}
