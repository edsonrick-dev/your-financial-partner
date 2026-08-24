import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/domain/app_calculator.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/home/widgets/budget_progress_indicator.dart';
import 'package:getx_drift_app/features/home/widgets/budget_tile.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/num_extension.dart';

class BudgetProgressSection extends GetView<CashflowController> {
  const BudgetProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSection(
      sectionTitle: 'Budget Progress',
      trailingText: 'View All',
      trailingType: SectionTrailingType.textButton,
      onTrailingPressed: () {
        Get.bottomSheet(AppCalculator());
      },
      child: StreamBuilder<List<CurrentMonthBudgetItem>>(
        stream: controller.watchCurrentMonthBudgetItems(),
        builder: (context, snapshot) {
          debugPrint(
            'BUDGET UI STREAM: '
            'hasData=${snapshot.hasData} '
            'items=${snapshot.data?.length} '
            'error=${snapshot.error}',
          );

          final items = snapshot.data ?? [];

          final now = DateTime.now();
          final currentMonthIndex = now.month - 1;

          final daysInMonth = DateTime(now.year, now.month + 1, 0).day;

          final daysLeft = daysInMonth - now.day;

          final budgetAmount = items.fold<double>(
            0,
            (sum, item) => sum + item.budget,
          );

          final spentAmount = items.fold<double>(
            0,
            (sum, item) => sum + item.spent,
          );

          final progress = budgetAmount <= 0 ? 0.0 : spentAmount / budgetAmount;

          final expectedSpent = budgetAmount <= 0
              ? 0.0
              : budgetAmount * (now.day / daysInMonth);

          final isOverBudget = spentAmount > budgetAmount;

          final isOnTrack = !isOverBudget && spentAmount <= expectedSpent;
          final statusText = isOverBudget
              ? 'Over Budget'
              : isOnTrack
              ? 'On Track'
              : 'Over Pace';

          final statusColor = isOverBudget
              ? colorScheme.appOutflow
              : isOnTrack
              ? colorScheme.appSuccess
              : colorScheme.appAccent;
          return Container(
            constraints: const BoxConstraints(minHeight: 44),
            width: double.infinity,
            decoration: BoxDecoration(
              color: colorScheme.bgLight,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                  child: Row(
                    spacing: 16,
                    children: [
                      BudgetProgressIndicator(
                        progress: progress.clamp(0.0, 1.0),
                        progressColor: statusColor,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${(progress * 100).round()}%',
                              style: AppTextStyle.amountM,
                            ),
                            Text('of budget', style: AppTextStyle.labelS),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${AppMonth.values[currentMonthIndex].fullName} Progress',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                height: 24 / 20,
                              ),
                            ),

                            Row(
                              children: [
                                Text(
                                  spentAmount.toCompactCurrency(
                                    kThreshold: 1000000,
                                  ),
                                  style: AppTextStyle.amountM,
                                ),
                                const Text(' spent of '),
                                Text(
                                  budgetAmount.toCompactCurrency(
                                    kThreshold: 1000000,
                                  ),
                                  style: const TextStyle(
                                    fontFeatures: [
                                      FontFeature.tabularFigures(),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            Row(
                              children: [
                                Row(
                                  spacing: 4,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: statusColor,
                                      ),
                                    ),
                                    Text(statusText),
                                  ],
                                ),
                                const Spacer(),
                                Text('$daysLeft days left'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 4),

                Divider(
                  indent: 16,
                  endIndent: 16,
                  color: colorScheme.appBorderMuted,
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                  child: Column(
                    spacing: 8,
                    children: [
                      for (final item in items)
                        BudgetTile(
                          categoryId: item.categoryId,
                          budgetName: item.plan.category,
                          iconKey: item.plan.iconKey,
                          consumption: item.spent,
                          budget: item.budget,
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class CurrentMonthBudgetItem {
  final SavedCashflowPlanData plan;
  final int categoryId;
  final double budget;
  final double spent;

  const CurrentMonthBudgetItem({
    required this.plan,
    required this.categoryId,
    required this.budget,
    required this.spent,
  });
}
