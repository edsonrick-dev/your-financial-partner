import 'package:getx_drift_app/features/transactions/controllers/extensions/transaction_validation_extension.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/card_payment_transaction/save_card_payment_transaction.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/earn_transaction/save_earn_transaction.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/earn_transaction/validate_earn_transaction.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/give_money_transaction/save_give_money_transaction.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/receive_money_transaction/save_receive_money_transaction.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/spend_transaction/save_spend_transaction.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/spend_transaction/validate_spend_transaction.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transfer_transaction/save_transfer_transaction.dart';

extension SaveTransactionFunctions on TransactionController {
  Future<void> saveTransaction(TransactionType type) async {
    switch (type) {
      case TransactionType.earn:
        if (!isEarnTransactionValid) return;
        await saveEarnTransaction();

      case TransactionType.spend:
        if (!isSpendTransactionValid) return;
        await saveSpendTransaction(TransactionType.spend);

      case TransactionType.transfer:
        if (!isTransferTransactionValid) return;
        await saveTransferTransaction();

      case TransactionType.receive:
        if (!isReceiveMoneyTransactionValid) return;
        await saveReceiveMoneyTransaction();

      case TransactionType.give:
        if (!isGiveMoneyTransactionValid) return;
        await saveGiveMoneyTransaction();

      case TransactionType.cardPayment:
        await saveCardPaymentTransaction();

      case TransactionType.debtRepayment:
        await saveSpendTransaction(TransactionType.debtRepayment);

      case TransactionType.balanceUpdate:
        return;
    }
  }
}
