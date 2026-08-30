import 'package:flutter/material.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/forms/earn_transaction_form.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/forms/give_money_transaction_form.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/forms/spend_transaction_form.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/forms/receive_money_transaction_form.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/transfer_transaction_form.dart';

class TransactionFormRegistry {
  static Widget form(TransactionType type) {
    switch (type) {
      case TransactionType.earn:
        return EarnTransactionForm();
      case TransactionType.spend:
        return SpendTransactionForm();

      case TransactionType.transfer:
        return TransferTransactionForm();

      case TransactionType.give:
        return GiveMoneyTransactionForm();
      case TransactionType.receive:
        return ReceiveMoneyTransactionForm();

      default:
        return const SizedBox.shrink();
    }
  }
}
