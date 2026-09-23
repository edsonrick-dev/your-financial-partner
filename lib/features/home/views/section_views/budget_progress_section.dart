import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sheets/create_cashflow_plan/create_expense_plan_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/home/widgets/budget_progress_indicator.dart';
import 'package:getx_drift_app/features/home/widgets/budget_tile.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BudgetProgressSection extends GetView<CashflowController> {
  const BudgetProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final hasAnyBudget = controller.hasExpensePlan;
      final hasBudgetForSelectedMonth = controller.hasBudgetForSelectedMonth;

      return AppSectionBody(
        child: !hasAnyBudget
            ? _EmptyView()
            : hasBudgetForSelectedMonth
            ? FilledView()
            : const Text('No Budget Set for this month'),
      );
    });
  }
}

// ignore: unused_element
class _EmptyView extends GetView<CashflowController> {
  // const _EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          Icon(Icons.toc_rounded, size: 60, color: colorScheme.appAccent),

          SizedBox(height: 8),

          Text(
            'You have no budget yet',
            style: AppTextStyle.headlineM,
            textAlign: TextAlign.center,
          ),

          Text(
            "Plan where your money goes",
            style: AppTextStyle.headlineS,
            textAlign: TextAlign.center,
          ),

          Text(
            "Create spending plans for categories like groceries, utilities, "
            "transportation, and dining so you know where your money "
            "should go each month.",
            style: AppTextStyle.bodyM.copyWith(color: colorScheme.appTextMuted),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 12),

          AppButton(
            type: ButtonType.outline,
            trailingIcon: PhosphorIconsRegular.arrowRight,
            text: 'Set budget in cashflow planner',
            onTap: () {
              Get.toNamed(Routes.CASHFLOWDETAILS);
              // Get.bottomSheet(
              //   CreateExpensePlanSheet(),
              //   backgroundColor: Colors.transparent,
              //   isScrollControlled: true,
              // ).whenComplete(() {
              //   controller.resetBudgetPlan();
              // });
            },
          ),
        ],
      ),
    );
  }
}

class FilledView extends GetView<CashflowController> {
  const FilledView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final items = controller.selectedMonthBudgetItem;

    final selectedMonth = controller.selectedMonth.value;

    final selectedMonthIndex = selectedMonth.month - 1;

    final daysInMonth = DateTime(
      selectedMonth.year,
      selectedMonth.month + 1,
      0,
    ).day;

    final now = DateTime.now();

    final isCurrentMonth =
        selectedMonth.year == now.year && selectedMonth.month == now.month;

    final daysLeft = isCurrentMonth
        ? daysInMonth - now.day
        : selectedMonth.isBefore(DateTime(now.year, now.month))
        ? 0
        : daysInMonth;
    final budgetAmount = items.fold<double>(
      0,
      (sum, item) => sum + item.budget,
    );

    final spentAmount = items.fold<double>(0, (sum, item) => sum + item.spent);

    final progress = budgetAmount <= 0 ? 0.0 : spentAmount / budgetAmount;

    final isOverBudget = spentAmount > budgetAmount;

    final expectedSpent = budgetAmount <= 0 || !isCurrentMonth
        ? 0.0
        : budgetAmount * (now.day / daysInMonth);

    final isOnTrack =
        isCurrentMonth && !isOverBudget && spentAmount <= expectedSpent;

    final statusText = isOverBudget
        ? 'Over Budget'
        : isCurrentMonth
        ? (isOnTrack ? 'On Track' : 'Over Pace')
        : '';
    final statusColor = isOverBudget
        ? colorScheme.appOutflow
        : isOnTrack
        ? colorScheme.appSuccess
        : colorScheme.appAccent;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        AdaptivePressable(
          onTap: () {
            controller.seletectedDetailsTabIndex.value = 1;
            Get.toNamed(Routes.CASHFLOWDETAILS);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 8, top: 8, right: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 12,
              children: [
                BudgetProgressIndicator(
                  size: 80,
                  progress: progress.clamp(0.0, 1.0),
                  progressColor: statusColor,
                  child: items.isNotEmpty
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${(progress * 100).round()}%',
                              style: AppTextStyle.amountM,
                            ),
                            Text('used', style: AppTextStyle.labelM),
                          ],
                        )
                      : Text(
                          'No\nBudget',
                          textAlign: TextAlign.center,
                          style: AppTextStyle.titleM,
                        ),
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        child: Text(
                          '${AppMonth.values[selectedMonthIndex].fullName} Progress',
                          style: AppTextStyle.headlineL,
                        ),
                      ),
                      SizedBox(height: 4),

                      FittedBox(
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: colorScheme.appText),
                            children: [
                              TextSpan(
                                text: spentAmount.toCompactCurrency(
                                  kThreshold: 1000000,
                                ),
                                style: AppTextStyle.amountM,
                              ),
                              const TextSpan(text: ' spent of '),
                              TextSpan(
                                text: budgetAmount.toCompactCurrency(
                                  kThreshold: 1000000,
                                ),
                                style: AppTextStyle.amountS,
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 4),

                      if (items.isNotEmpty)
                        Row(
                          children: [
                            Row(
                              spacing: 4,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: statusColor,
                                  ),
                                ),
                                Text(statusText, style: AppTextStyle.labelM),
                              ],
                            ),
                            const Spacer(),
                            if (isCurrentMonth)
                              Text(
                                '$daysLeft days left',
                                style: AppTextStyle.labelM,
                              ),
                          ],
                        ),
                      if (items.isEmpty)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Text('No budget yet', style: AppTextStyle.titleS),
                            Text(
                              'Plan your cash flow to start tracking spending.',
                              style: AppTextStyle.bodyS,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        const SizedBox(height: 4),

        if (items.isNotEmpty)
          Divider(indent: 16, endIndent: 16, color: colorScheme.appBorderMuted),
        // _EmptyView(),
        if (items.length >= 3)
          Obx(
            () => DisplayModeToggle(
              value: controller.budgetDisplayMode.value,
              onChanged: controller.setBudgetDisplayMode,
            ),
          ),
        Obx(() {
          // final mode = controller.budgetDisplayMode.value;
          final mode = items.length < 3
              ? DisplayMode.list
              : controller.budgetDisplayMode.value;
          final isExpanded = controller.isBudgetExpanded.value;

          final previewLimit = mode == DisplayMode.grid ? 6 : 4;

          final visibleItems = isExpanded
              ? items
              : items.take(previewLimit).toList();

          final hasMore = items.length > previewLimit;

          return Column(
            children: [
              // GRID ↔ LIST
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                switchInCurve: Curves.easeOut,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: Tween<double>(
                        begin: 0.98,
                        end: 1.0,
                      ).animate(animation),
                      child: child,
                    ),
                  );
                },
                child: mode == DisplayMode.grid
                    ? _BudgetGrid(
                        key: const ValueKey('budget-grid'),
                        items: visibleItems,
                      )
                    : _BudgetList(
                        key: const ValueKey('budget-list'),
                        items: visibleItems,
                      ),
              ),

              // SEE MORE ↔ SEE LESS
              if (hasMore) ...[
                AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  alignment: Alignment.topCenter,
                  child: AdaptivePressable(
                    onTap: controller.toggleBudgetExpanded,
                    child: Text(isExpanded ? 'See less' : 'See more'),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ],
          );
        }),
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: AppButton(
              type: ButtonType.outline,
              leadingIcon: PhosphorIconsRegular.plus,
              text: 'Add expense budget',
              onTap: () {
                Get.bottomSheet(
                  CreateExpensePlanSheet(),
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                ).whenComplete(() {
                  controller.resetBudgetPlan();
                });
              },
              borderRadius: 12,
            ),
          ),
      ],
    );
  }
}

class BudgetItem {
  final SavedCashflowPlanData plan;
  final int categoryId;
  final double budget;
  final double spent;

  const BudgetItem({
    required this.plan,
    required this.categoryId,
    required this.budget,
    required this.spent,
  });
}

class _BudgetGrid extends StatelessWidget {
  const _BudgetGrid({super.key, required this.items});

  final List<BudgetItem> items;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        mainAxisExtent: 140,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];

        return BudgetGridView(
          categoryId: item.categoryId,
          budgetName: item.plan.category,
          iconKey: item.plan.iconKey,
          consumption: item.spent,
          budget: item.budget,
        );
      },
    );
  }
}

class _BudgetList extends StatelessWidget {
  const _BudgetList({super.key, required this.items});

  final List<BudgetItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        for (final item in items)
          BudgetListView(
            categoryId: item.categoryId,
            budgetName: item.plan.category,
            iconKey: item.plan.iconKey,
            consumption: item.spent,
            budget: item.budget,
          ),
        // SizedBox(height: 4),
      ],
    );
  }
}
