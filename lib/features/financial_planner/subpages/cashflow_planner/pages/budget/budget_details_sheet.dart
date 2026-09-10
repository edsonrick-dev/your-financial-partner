import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/budget_bills_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/cashflow_plan_summary_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/cashflow_plan_transactions_view.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';

class BudgetDetailsSheet extends StatelessWidget {
  const BudgetDetailsSheet({
    super.key,
    required this.plan,
    required this.selectedIndex,
  });

  final SavedCashflowPlanData plan;
  final RxInt selectedIndex;

  @override
  Widget build(BuildContext context) {
    return AppSheet(
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
            // onAdd: () {},
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: selectedIndex.value,
                children: [
                  CashflowPlanTransactionsView(plan: plan),

                  // Bills — implement later
                  BillsByCategoryView(plan: plan),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
