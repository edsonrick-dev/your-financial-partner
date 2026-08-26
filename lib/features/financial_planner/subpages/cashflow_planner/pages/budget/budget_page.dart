import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/cashflow_plan_summary_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/cashflow_plan_transactions_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/widgets/cashflow_plan_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';

class BudgetPage extends GetView<CashflowController> {
  const BudgetPage({super.key});

  Future<void> _confirmDeletePlan(
    BuildContext context,
    SavedCashflowPlanData plan,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete plan?'),
          content: Text(
            'Delete the ${plan.category} ${_planTypeLabel(plan.planType).toLowerCase()} plan?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }

    await controller.deleteSavedPlan(plan.planId);
  }

  String _planTypeLabel(String planType) {
    switch (planType) {
      case 'expense':
        return 'Expenses';

      case 'debtRepayment':
        return 'Debt Repayment';

      default:
        return planType;
    }
  }

  double _annualTotal(List<SavedCashflowPlanData> plans) {
    return plans.fold<double>(0, (total, plan) {
      return total + plan.budgetPeriod.toAnnual(plan.amount);
    });
  }

  Widget _buildPlanSection(
    BuildContext context, {
    required String title,
    required String planType,
    required List<SavedCashflowPlanData> plans,
  }) {
    if (plans.isEmpty) {
      return const SizedBox.shrink();
    }
    final expensePlans = plans
        .where((plan) => plan.planType == 'expense')
        .toList();

    final debtRepaymentPlans = plans
        .where((plan) => plan.planType == 'debtRepayment')
        .toList();

    debugPrint('TOTAL BUDGET PLANS: ${plans.length}');
    debugPrint('EXPENSE PLANS: ${expensePlans.length}');
    debugPrint('DEBT PLANS: ${debtRepaymentPlans.length}');

    final colorScheme = context.colors;

    final color = switch (planType) {
      'expense' => colorScheme.appOutflow,
      'debtRepayment' => colorScheme.appOutflow,
      _ => colorScheme.appText,
    };
    final RxInt selectedIndex = 0.obs;
    return AppSection(
      sectionTitle: title,
      trailingType: SectionTrailingType.custom,
      trailingWidget: Text(
        _annualTotal(plans).toCurrency(),
        style: AppTextStyle.amountM.copyWith(color: color),
      ),
      child: Column(
        spacing: 8,
        children: [
          for (final plan in plans)
            CashflowPlanCard(
              onTap: () {
                Get.bottomSheet(
                  AppSheet(
                    height: AppSheetHeight.full,
                    title: '${plan.category} Budget ',
                    child: Column(
                      children: [
                        CashflowPlanSummarySection(
                          plan: plan,
                          spent: 0, // temporary
                          planned: plan.amount,
                        ),

                        const SizedBox(height: 12),

                        AppDetailsPageActionSection(
                          selectedIndex: selectedIndex,
                          actions: ['Transactions', 'Bills'],
                          onAdd: () {},
                        ),
                        Expanded(
                          child: Obx(
                            () => IndexedStack(
                              index: selectedIndex.value,
                              children: [
                                CashflowPlanTransactionsView(plan: plan),

                                // Bills — implement later
                                const SizedBox(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  isDismissible: true,
                  isScrollControlled: true,
                );
              },
              category: plan.category,
              color: colorScheme.appOutflow,
              amount: plan.amount,
              budgetPeriod: plan.budgetPeriod,
              iconKey: plan.iconKey,
              isCustom: plan.isCustom,
              onLongPress: () {
                _confirmDeletePlan(context, plan);
              },
              customSummary: plan.customSummary,
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: StreamBuilder<List<SavedCashflowPlanData>>(
              stream: controller.watchSavedBudgetPlans(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                }

                final plans = snapshot.data ?? [];

                final expensePlans = plans
                    .where((plan) => plan.planType == 'expense')
                    .toList();

                final debtRepaymentPlans = plans
                    .where((plan) => plan.planType == 'debtRepayment')
                    .toList();

                if (plans.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.account_balance_wallet_outlined,
                            size: 48,
                            color: colorScheme.textMuted,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No budget plans yet',
                            style: AppTextStyle.titleL,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add your first budget plan to start planning your cash flow.',
                            style: AppTextStyle.bodyM.copyWith(
                              color: colorScheme.textMuted,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Column(
                  spacing: 16,
                  children: [
                    _buildPlanSection(
                      context,
                      title: 'Expenses',
                      planType: 'expense',
                      plans: expensePlans,
                    ),

                    _buildPlanSection(
                      context,
                      title: 'Debt Repayment',
                      planType: 'debtRepayment',
                      plans: debtRepaymentPlans,
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
