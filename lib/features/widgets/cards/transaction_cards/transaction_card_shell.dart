import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';
import 'package:getx_drift_app/data/tables/transactions_table.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/card_payment_transaction/card_payment_card.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/loan_payment_transaction/loan_payment_card.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/earn_transaction/earn_transaction_card.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/give_money_transaction/give_money_transaction_card.dart';
import 'package:getx_drift_app/features/widgets/cards/transaction_cards/receive_money_transaction_card.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/spend_transaction/spend_transaction_card.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transfer_transaction/transfer_transaction_card.dart';
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
      case TransactionType.cardPayment:
        return CardPaymentCard(item: item);
      case TransactionType.debtRepayment:
        return LoanPaymentCard(item: item);
    }
  }
}
