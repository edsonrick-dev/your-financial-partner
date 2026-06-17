import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/earn_transaction_card.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/give_money_transaction_card.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/receive_money_transaction_card.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/spend_transaction_card.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/transfer_transaction_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('Transactions'), centerTitle: false),

      body: StreamBuilder<Map<String, List<TransactionWithDetails>>>(
        stream: database.transactionsDao.watchGroupedTransactions(),

        builder: (context, snapshot) {
          /// ERROR

          if (snapshot.hasError) {
            debugPrint(snapshot.error.toString());

            if (snapshot.stackTrace != null) {
              debugPrint(snapshot.stackTrace.toString());
            }

            return Center(child: Text('Error: ${snapshot.error}'));
          }

          /// LOADING

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final groupedTransactions = snapshot.data!;

          /// EMPTY STATE

          if (groupedTransactions.isEmpty) {
            return const Center(child: Text('No transactions yet.'));
          }

          return ListView(
            padding: const EdgeInsets.only(top: 12, bottom: 24),

            children: groupedTransactions.entries.map((entry) {
              final sectionTitle = entry.key;

              final transactions = entry.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  /// SECTION HEADER
                  AppSection(
                    sectionTitle: sectionTitle,
                    child: Column(
                      spacing: 12,
                      children: transactions.map((item) {
                        final transactionType =
                            item.transaction.transactionType;

                        if (transactionType == TransactionType.earn.name) {
                          return EarnTransactionCard(item: item);
                        }

                        if (transactionType == TransactionType.spend.name) {
                          return SpendTransactionCard(item: item);
                        }
                        if (transactionType == TransactionType.give.name) {
                          return GiveMoneyTransactionCard(item: item);
                        }
                        if (transactionType == TransactionType.receive.name) {
                          return ReceiveMoneyTransactionCard(item: item);
                        }
                        return TransferTransactionCard(item: item);
                      }).toList(),
                    ),
                  ),
                  SizedBox(height: 12),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
