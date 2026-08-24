import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/widgets/cashflow_plan_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class PlannedIncomeList extends GetView<CashflowController> {
  const PlannedIncomeList({super.key});
  Future<void> _confirmDeletePlan(
    BuildContext context,
    SavedCashflowPlanData plan,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete plan?'),
          content: Text('Delete the ${plan.category} income plan?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
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

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return LayoutBuilder(
      builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: StreamBuilder<List<SavedCashflowPlanData>>(
              stream: controller.watchSavedCashflowPlans(
                transactionType: TransactionType.earn,
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const SizedBox.shrink();
                }

                final plans = snapshot.data ?? [];

                if (plans.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(32),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.construction_outlined,
                            size: 48,
                            color: colorScheme.textMuted,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No income plans yet',
                            style: AppTextStyle.titleL,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Add your first income plan to start planning your cash flow.',
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

                return AppSection(
                  child: Column(
                    spacing: 8,
                    children: [
                      for (final plan in plans)
                        CashflowPlanCard(
                          color: colorScheme.appInflow,
                          category: plan.category,
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
              },
            ),
          ),
        );
      },
    );
  }
}
