import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';
import 'package:getx_drift_app/data/tables/transactions_table.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/earn_transaction_card.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/give_money_transaction_card.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/receive_money_transaction_card.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/spend_transaction_card.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/transfer_transaction_card.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/update_balance_transaction_card.dart';

class TransactionCard extends StatelessWidget {
  final TransactionWithDetails item;
  const TransactionCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    switch (item.transaction.type) {
      case TransactionType.earn:
        return EarnTransactionCard(item: item);
      case TransactionType.spend:
        return SpendTransactionCard(item: item);
      case TransactionType.transfer:
        return TransferTransactionCard(item: item);
      case TransactionType.receive:
        return ReceiveMoneyTransactionCard(item: item);
      case TransactionType.give:
        return GiveMoneyTransactionCard(item: item);
      case TransactionType.balanceUpdate:
        return UpdateBalanceTransactionCard(item: item);
    }
  }
}
