import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/data/tables/transactions_table.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/transaction_card_shell.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});
  double calculateGroupTotal(List<TransactionWithDetails> transactions) {
    return transactions.fold<double>(0, (total, item) {
      switch (item.transaction.type) {
        case TransactionType.earn:
        case TransactionType.receive:
          return total + item.transaction.amount;

        case TransactionType.spend:
        case TransactionType.give:
          return total - item.transaction.amount;

        case TransactionType.balanceUpdate:
        case TransactionType.transfer:
          // Transfers are between your own accounts,
          // so they have no effect on net cash flow.
          return total;
      }
    });
  }

  String formatGroupTotal(double total) {
    if (total == 0) return '';

    final amount = total.abs().toCurrency();

    // if (total > 0) {
    //   return '+$amount';
    // }

    return amount;
  }

  @override
  Widget build(BuildContext context) {
    final cardsSpacing = 12.0;
    return Scaffold(
      // backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text('Transactions', style: AppTextStyle.headlineL),
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
      ),
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

          final groupedTransactions = <String, List<TransactionWithDetails>>{};

          for (final entry in snapshot.data!.entries) {
            final filtered = entry.value
                .where(
                  (item) =>
                      item.transaction.type != TransactionType.balanceUpdate,
                )
                .toList();

            if (filtered.isNotEmpty) {
              groupedTransactions[entry.key] = filtered;
            }
          }
          if (groupedTransactions.isEmpty) {
            return const Center(child: Text('No transactions yet.'));
          }

          return ListView(
            padding: const EdgeInsets.only(bottom: 24),
            children: groupedTransactions.entries.map((entry) {
              final sectionTitle = entry.key;
              final transactions = entry.value;
              final groupTotal = calculateGroupTotal(transactions);
              return Column(
                spacing: cardsSpacing,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppSection(
                    sectionTitle: sectionTitle,
                    trailingType: SectionTrailingType.custom,
                    trailingWidget: groupTotal == 0
                        ? const SizedBox.shrink()
                        : Text(
                            formatGroupTotal(groupTotal),
                            style: AppTextStyle.amountM.copyWith(
                              color: groupTotal > 0 ? Colors.green : Colors.red,
                            ),
                          ),
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
