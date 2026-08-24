import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/transaction_card_shell.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/update_balance_transaction_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class CreditCardTransactionsView extends StatelessWidget {
  final int accountId;

  const CreditCardTransactionsView({super.key, required this.accountId});

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
          debugPrint(snapshot.error.toString());

          return const Center(child: Text('Unable to load transactions.'));
        }

        final groupedTransactions = snapshot.data ?? {};

        if (groupedTransactions.isEmpty) {
          return const _EmptyTransactionsView();
        }

        return ListView(
          padding: const EdgeInsets.only(top: 12, bottom: 24),
          children: groupedTransactions.entries.map((entry) {
            final sectionTitle = entry.key;
            final transactions = entry.value;

            return AppSection(
              sectionTitle: sectionTitle,
              child: Column(
                spacing: 12,
                children: transactions.map((item) {
                  if (item.transaction.transactionType ==
                      TransactionType.balanceUpdate.name) {
                    return UpdateBalanceTransactionCard(
                      item: item,
                      isCreditCard: true,
                    );
                  }

                  return TransactionCard(item: item);
                }).toList(),
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
    return Center(
      child: Padding(
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
      ),
    );
  }
}
