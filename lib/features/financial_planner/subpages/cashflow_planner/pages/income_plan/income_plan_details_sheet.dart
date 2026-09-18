import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/budget_bills_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/cashflow_plan_summary_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/cashflow_plan_transactions_view.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';

class IncomePlanDetailsSheet extends StatelessWidget {
  const IncomePlanDetailsSheet({
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
      title: '${plan.category} Income Plan',
      child: StreamBuilder<List<TransactionWithDetails>>(
        stream: database.transactionsDao.watchTransactionsForCashflowPlan(plan),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Unable to load transactions.'));
          }

          final transactions = snapshot.data ?? [];

          final now = DateTime.now();

          final monthStart = DateTime(now.year, now.month, 1);
          final nextMonth = DateTime(now.year, now.month + 1, 1);

          final transactedAmount = transactions
              .where(
                (item) =>
                    !item.transaction.date.isBefore(monthStart) &&
                    item.transaction.date.isBefore(nextMonth),
              )
              .fold<double>(
                0,
                (total, item) => total + item.transaction.amount,
              );

          return Column(
            children: [
              CashflowPlanSummarySection(
                transactionType: TransactionType.earn,
                plan: plan,
                transactionAmount: transactedAmount, // temporary
                planned: plan.amount,
              ),

              const SizedBox(height: 12),

              AppDetailsPageActionSection(
                selectedIndex: selectedIndex,
                actions: ['Transactions'],
                onAdd: () {},
              ),
              Expanded(
                child: Obx(
                  () => IndexedStack(
                    index: selectedIndex.value,
                    children: [
                      CashflowPlanTransactionsView(plan: plan),

                      // Bills — implement later
                      // BillsByCategoryView(plan: plan),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
