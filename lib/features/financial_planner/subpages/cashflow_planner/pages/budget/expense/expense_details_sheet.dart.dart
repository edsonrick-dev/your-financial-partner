import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/bills_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/budget_bills_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/cashflow_plan_summary_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/cashflow_plan_transactions_view.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';

class ExpenseDetailsSheet extends StatelessWidget {
  const ExpenseDetailsSheet({
    super.key,
    required this.plan,
    required this.selectedIndex,
  });

  final SavedCashflowPlanData plan;
  final RxInt selectedIndex;

  void _selectPlanCategory() {
    final transactionController = Get.find<TransactionController>();

    transactionController.selectCategoryById(plan.categoryId);
  }

  void _onAdd(BuildContext context) {
    if (selectedIndex.value == 0) {
      _addTransaction();
    } else {
      _addBill();
    }
  }

  void _addTransaction() {
    AppSheets.transaction.spend(categoryId: plan.categoryId);
    // Open your existing transaction form here,
    // with `plan.category` already selected.
  }

  void _addBill() {
    _selectPlanCategory();

    Get.bottomSheet(
      const BillForm(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      height: AppSheetHeight.full,
      title: '${plan.category} Budget',
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

          final spent = transactions
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
                transactionType: TransactionType.spend,
                plan: plan,
                transactionAmount: spent, // temporary
                planned: plan.amount,
              ),

              const SizedBox(height: 12),

              AppDetailsPageActionSection(
                selectedIndex: selectedIndex,
                actions: ['Transactions', 'Bills'],
                onAdd: () {
                  _onAdd(context);
                },
              ),
              Expanded(
                child: Obx(
                  () => IndexedStack(
                    alignment: Alignment.topCenter,
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
          );
        },
      ),
    );
  }
}
