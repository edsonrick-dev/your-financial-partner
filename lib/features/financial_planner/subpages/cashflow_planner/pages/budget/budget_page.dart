import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_next_occurrence.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/expense/expense_details_sheet.dart.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/debt_repayment/debt_repayment_list.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/select_budget_type_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/widgets/cashflow_plan_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

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
                  ExpenseDetailsSheet(plan: plan, selectedIndex: selectedIndex),
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
              builder: (context, budgetSnapshot) {
                if (budgetSnapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                }

                final plans = budgetSnapshot.data ?? [];

                final expensePlans = plans
                    .where((plan) => plan.planType == 'expense')
                    .toList();

                return StreamBuilder<List<BillWithNextOccurrence>>(
                  stream: controller.watchDebtRepaymentBills(),
                  builder: (context, debtSnapshot) {
                    if (debtSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const SizedBox.shrink();
                    }

                    final debtRepaymentBills = debtSnapshot.data ?? [];

                    if (expensePlans.isEmpty && debtRepaymentBills.isEmpty) {
                      return Center(
                        child: Padding(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.account_balance_wallet_outlined,
                                size: 48,
                                color: colorScheme.appTextMuted,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No budget set yet',
                                style: AppTextStyle.headlineM,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Add your first budget to start planning your cash flow.',
                                style: AppTextStyle.bodyM.copyWith(
                                  color: colorScheme.appTextMuted,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 16),
                              AppButton(
                                text: 'Set up your first budget',
                                onTap: () {
                                  Get.bottomSheet(
                                    const SelectBudgetTypeSheet(),
                                    backgroundColor: Colors.transparent,
                                    isScrollControlled: true,
                                  );
                                },
                              ),
                              const SizedBox(height: 8),
                              AppButton(
                                type: ButtonType.outline,
                                text: 'Watch how to set up a budget',
                                onTap: () {},
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return Column(
                      children: [
                        if (expensePlans.isNotEmpty)
                          _buildPlanSection(
                            context,
                            title: 'Expenses',
                            planType: 'expense',
                            plans: expensePlans,
                          ),
                        if (debtRepaymentBills.isNotEmpty)
                          DebtRepaymentList(bills: debtRepaymentBills),
                        SizedBox(height: context.bottomPaddingSub),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
