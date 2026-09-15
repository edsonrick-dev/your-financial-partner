import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
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
      trailingWidget: AdaptivePressable(
        onTap: () {
          if (controller.currentMonthBudgetItems.isEmpty) {
            controller.seletectedDetailsTabIndex(1);
            Get.toNamed(Routes.CASHFLOWDETAILS);
          }
          if (controller.currentMonthBudgetItems.isEmpty) {
            controller.seletectedDetailsTabIndex(1);
            Get.toNamed(Routes.CASHFLOWDETAILS);
          }
        },
        child: Obx(
          () => controller.currentMonthBudgetItems.isEmpty
              ? SizedBox.shrink()
              // (
              // height: 44,
              // child: Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
              //   child: Center(
              //     child: Text(
              //       'Set Budget',
              //       style: AppTextStyle.titleM.copyWith(
              //         color: colorScheme.appText,
              //       ),
              //     ),
              //   ),
              // ),
              // )
              : SizedBox(
                  height: 44,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Center(
                      child: Text('View budgets', style: AppTextStyle.titleM),
                    ),
                  ),
                ),
        ),
      ),
      trailingType: SectionTrailingType.custom,

      child: Obx(() {
        final items = controller.currentMonthBudgetItems;

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
          child: _FilledView(
            progress: progress,
            statusColor: statusColor,
            currentMonthIndex: currentMonthIndex,
            spentAmount: spentAmount,
            budgetAmount: budgetAmount,
            statusText: statusText,
            daysLeft: daysLeft,
            colorScheme: colorScheme,
            items: items,
            controller: controller,
          ),
        );
      }),
    );
  }
}

// ignore: unused_element
class _EmptyView extends GetView<CashflowController> {
  // const _EmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          // Text(
          //   'Set your budget with Casfhlow Planner',
          //   style: AppTextStyle.titleM,
          //   textAlign: TextAlign.center,
          // ),
          // SizedBox(height: 8),
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 16.0),
          //   child: Text(
          //     textAlign: TextAlign.center,
          //     'You can see your budget per category here once your setup your cashflow plan',
          //     style: AppTextStyle.bodyS.copyWith(color: colorScheme.appText),
          //   ),
          // ),
          // SizedBox(height: 16),
          AppButton(
            // type: ButtonType.outline,
            text: 'Go to Cashflow Planner',
            onTap: () {
              controller.seletectedDetailsTabIndex(1);
              Get.toNamed(Routes.CASHFLOWDETAILS, arguments: 1);
            },
          ),
        ],
      ),
    );
  }
}

class _FilledView extends StatelessWidget {
  const _FilledView({
    required this.progress,
    required this.statusColor,
    required this.currentMonthIndex,
    required this.spentAmount,
    required this.budgetAmount,
    required this.statusText,
    required this.daysLeft,
    required this.colorScheme,
    required this.items,
    required this.controller,
  });

  final double progress;
  final Color statusColor;
  final int currentMonthIndex;
  final double spentAmount;
  final double budgetAmount;
  final String statusText;
  final int daysLeft;
  final ColorScheme colorScheme;
  final List<CurrentMonthBudgetItem> items;
  final CashflowController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 12,
            children: [
              BudgetProgressIndicator(
                size: 90,
                progress: progress.clamp(0.0, 1.0),
                progressColor: statusColor,
                child: items.isNotEmpty
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${(progress * 100).round()}%',
                            style: AppTextStyle.amountL,
                          ),
                          Text('of budget', style: AppTextStyle.labelXS),
                        ],
                      )
                    : Text(
                        'No\nBudget',
                        textAlign: TextAlign.center,
                        style: AppTextStyle.cardTitle,
                      ),
              ),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: Text(
                        '${AppMonth.values[currentMonthIndex].fullName} Progress',
                        style: AppTextStyle.headlineM,
                      ),
                    ),
                    SizedBox(height: 4),
                    // if (items.isNotEmpty)
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
                            'Create a cashflow plan to start tracking your spending.',
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
              if (hasMore)
                AnimatedSize(
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOutCubic,
                  alignment: Alignment.topCenter,
                  child: AdaptivePressable(
                    onTap: controller.toggleBudgetExpanded,
                    child: Text(isExpanded ? 'See less' : 'See more'),
                  ),
                ),
            ],
          );
        }),
        if (items.isEmpty)
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: AppButton(
              text: 'Set up your budget',
              onTap: () {},
              borderRadius: 12,
            ),
          ),
      ],
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

class _BudgetGrid extends StatelessWidget {
  const _BudgetGrid({super.key, required this.items});

  final List<CurrentMonthBudgetItem> items;

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

  final List<CurrentMonthBudgetItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 8,
      children: [
        for (final item in items)
          BudgetListView(
            categoryId: item.categoryId,
            budgetName: item.plan.category,
            iconKey: item.plan.iconKey,
            consumption: item.spent,
            budget: item.budget,
          ),
        SizedBox(height: 4),
      ],
    );
  }
}
