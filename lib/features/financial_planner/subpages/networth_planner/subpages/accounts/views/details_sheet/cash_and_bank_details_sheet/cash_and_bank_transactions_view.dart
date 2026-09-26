import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/transaction_card_shell.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class CashAndBankTransactionsView extends StatelessWidget {
  final int accountId;

  const CashAndBankTransactionsView({super.key, required this.accountId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, List<TransactionWithDetails>>>(
      stream: database.transactionsDao.watchGroupedTransactionsForAccount(
        accountId,
      ),

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Unable to load transactions.'));
        }

        final groupedTransactions = snapshot.data ?? {};
        // Remove zero-amount transactions from every group.
        final visibleGroups = groupedTransactions.map((
          sectionTitle,
          transactions,
        ) {
          final visibleTransactions = transactions
              .where((item) => item.transaction.amount != 0)
              .toList();

          return MapEntry(sectionTitle, visibleTransactions);
        })..removeWhere((sectionTitle, transactions) => transactions.isEmpty);

        // No actual transactions for this account.
        if (visibleGroups.isEmpty) {
          return const _EmptyTransactionsView();
        }

        return ListView(
          // padding: const EdgeInsets.only(top: , bottom: 24),
          children: visibleGroups.entries.map((entry) {
            final sectionTitle = entry.key;
            final transactions = entry.value;

            return Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: AppSection(
                sectionTitle: sectionTitle,
                child: AppSectionBody(
                  child: Column(
                    spacing: 12,
                    children: transactions
                        .where((item) => item.transaction.amount != 0)
                        .map((item) => TransactionCard(item: item))
                        .toList(),
                  ),
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}

class _EmptyTransactionsView extends StatelessWidget {
  const _EmptyTransactionsView();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.receipt_long_outlined, size: 48),
          const SizedBox(height: 16),
          Text(
            'No transactions yet',
            style: AppTextStyle.titleL,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Transactions charged to this card will appear here.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
