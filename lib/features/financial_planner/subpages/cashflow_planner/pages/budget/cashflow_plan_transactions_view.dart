import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/cashflow_plan_grouping_section.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/transaction_card_shell.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class CashflowPlanTransactionsView extends StatelessWidget {
  final SavedCashflowPlanData plan;

  const CashflowPlanTransactionsView({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TransactionWithDetails>>(
      stream: database.transactionsDao.watchTransactionsForCashflowPlan(plan),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          debugPrint(
            'Cashflow plan transactions error: '
            '${snapshot.error}',
          );

          return const Center(child: Text('Unable to load transactions.'));
        }

        final transactions = snapshot.data ?? [];

        if (transactions.isEmpty) {
          return const _EmptyCashflowPlanTransactionsView();
        }

        // GROUP TRANSACTIONS BASED ON THE PLAN'S PERIOD
        final grouped = CashflowPlanTransactionGrouping.group(
          transactions: transactions,
          period: plan.budgetPeriod,
        );

        return ListView(
          padding: const EdgeInsets.only(top: 12, bottom: 24),
          children: grouped.entries.map((entry) {
            return AppSection(
              sectionTitle: entry.key,
              child: Column(
                spacing: 12,
                children: entry.value.map((transaction) {
                  return TransactionCard(item: transaction);
                }).toList(),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _EmptyCashflowPlanTransactionsView extends StatelessWidget {
  const _EmptyCashflowPlanTransactionsView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.receipt_long_outlined, size: 48),
            const SizedBox(height: 16),
            const Text(
              'No transactions yet',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            const Text(
              'Transactions for this cash flow plan will appear here.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
