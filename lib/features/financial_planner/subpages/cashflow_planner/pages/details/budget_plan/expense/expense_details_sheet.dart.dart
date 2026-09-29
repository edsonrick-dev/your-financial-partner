import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/data/database/daos/cashflow_plan_dao/cashflow_plan_dao.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/details/income_plan/income_plan_details_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sheets/create_cashflow_plan/create_expense_plan_sheet.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/spend_transaction/spend_transaction_sheet.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/bills_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/details/budget_plan/budget/budget_bills_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/details/budget_plan/budget/cashflow_plan_summary_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/details/budget_plan/budget/cashflow_plan_transactions_view.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ExpenseDetailsSheet extends StatelessWidget {
  const ExpenseDetailsSheet({
    super.key,
    required this.plan,
    required this.selectedIndex,
  });
  final SavedCashflowPlanData plan;
  final RxInt selectedIndex;

  void _onTap(BuildContext context) {
    if (selectedIndex.value == 0) {
      _addTransaction();
    } else if (selectedIndex.value == 1) {
      _addBill();
    } else {
      _editBudgetPlan();
    }
  }

  void _addTransaction() {
    AppSheets.transaction.spend(categoryId: plan.categoryId);
  }

  void _addBill() {
    final transactionController = Get.find<TransactionController>();

    transactionController.selectCategoryById(plan.categoryId);

    Get.bottomSheet(
      const BillForm(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  Future<void> _editBudgetPlan() async {
    final savedPlan = await _loadPlan();

    if (savedPlan == null) {
      return;
    }

    final controller = Get.find<CashflowController>();

    await controller.loadCashflowPlanForEdit(savedPlan);

    Get.bottomSheet(
      const CreateExpensePlanSheet(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  Future<CashflowPlanWithCategory?> _loadPlan() async {
    final plans = await database.cashflowPlanDao
        .watchAllPlansWithDetails()
        .first;

    return plans.firstWhereOrNull((item) => item.plan.id == plan.planId);
  }

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      height: AppSheetHeight.full,
      title: '${plan.category.capitalize} Budget',
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

              // const SizedBox(height: 12),
              Obx(
                () => AppDetailsPageActionSection(
                  selectedIndex: selectedIndex,
                  icon: selectedIndex.value == 2
                      ? PhosphorIconsRegular.pencil
                      : PhosphorIconsRegular.plus,
                  actions: ['Transactions', 'Bills', 'Budget Details'],
                  onAdd: () {
                    _onTap(context);
                  },
                ),
              ),
              Expanded(
                child: Obx(
                  () => IndexedStack(
                    alignment: Alignment.topCenter,
                    index: selectedIndex.value,
                    children: [
                      CashflowPlanTransactionsView(plan: plan),

                      BillsByCategoryView(plan: plan),
                      _BudgetDetails(plan: plan),
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

class _BudgetDetails extends StatelessWidget {
  const _BudgetDetails({required this.plan});

  final SavedCashflowPlanData plan;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CashflowPlanWithCategory>>(
      stream: database.cashflowPlanDao.watchAllPlansWithDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Unable to load budget details.'));
        }

        final savedPlan = snapshot.data?.firstWhereOrNull(
          (item) => item.plan.id == plan.planId,
        );

        if (savedPlan == null) {
          return const Center(child: Text('Budget not found.'));
        }

        return PlanDetailsContent(savedPlan: savedPlan);
      },
    );
  }
}
