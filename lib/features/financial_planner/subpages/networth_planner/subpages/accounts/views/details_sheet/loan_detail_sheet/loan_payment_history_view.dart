import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';

import 'package:getx_drift_app/data/models/transaction_with_details.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/transaction_card_shell.dart';

class LoanPaymentHistoryView extends StatelessWidget {
  final int accountId;

  const LoanPaymentHistoryView({super.key, required this.accountId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TransactionWithDetails>>(
      stream: database.transactionsDao.watchDebtRepaymentsForAccount(accountId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Unable to load payment history.'));
        }

        final transactions = snapshot.data ?? [];

        if (transactions.isEmpty) {
          return const Center(child: Text('No payments yet.'));
        }

        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: transactions.length,
          separatorBuilder: (_, _) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            return TransactionCard(item: transactions[index]);
          },
        );
      },
    );
  }
}
