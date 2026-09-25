import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/earn_transaction/earn_transaction_card.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/give_money_transaction/give_money_transaction_card.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/receive_money_transaction_card.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/spend_transaction/spend_transaction_card.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transfer_transaction/transfer_transaction_card.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';

class RecentTransactionsSection extends StatelessWidget {
  const RecentTransactionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TransactionWithDetails>>(
      stream: database.transactionsDao.watchRecentTransactions(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final transactions = snapshot.data!;

        return Column(
          spacing: 12,
          children: transactions.map((item) {
            final transaction = item.transaction;
            final transactionType = transaction.transactionType;

            if (transactionType == TransactionType.earn.name) {
              return EarnTransactionCard(item: item);
            }
            if (transactionType == TransactionType.spend.name) {
              return SpendTransactionCard(item: item);
            }
            if (transactionType == TransactionType.transfer.name) {
              return TransferTransactionCard(item: item);
            }
            if (transactionType == TransactionType.give.name) {
              return GiveMoneyTransactionCard(item: item);
            }
            if (transactionType == TransactionType.receive.name) {
              return ReceiveMoneyTransactionCard(item: item);
            }

            return const SizedBox.shrink();
            // return Column(children: [Text(item.category.name)]);
          }).toList(),
        );
      },
    );
  }
}
