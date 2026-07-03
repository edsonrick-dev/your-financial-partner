import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/transaction_card_shell.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';

import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    final cardsSpacing = 12.0;
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

          /// EMPTY STATE
          final groupedTransactions = snapshot.data!;
          if (groupedTransactions.isEmpty) {
            return const Center(child: Text('No transactions yet.'));
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: groupedTransactions.entries.map((entry) {
              final sectionTitle = entry.key;
              final transactions = entry.value;

              return Column(
                spacing: cardsSpacing,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSection(
                    sectionTitle: sectionTitle,
                    child: Column(
                      spacing: cardsSpacing,
                      children: transactions
                          .map((item) => TransactionCard(item: item))
                          .toList(),
                    ),
                  ),
                ],
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
