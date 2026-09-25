import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';

extension LoadTransferTransaction on TransactionController {
  void loadTransferTransaction(TransactionWithDetails item) {
    editingTransaction.value = item;
    selectedDate.value = item.transaction.date;
    selectedAccount.value = item.account;
    selectedLinkedAccount.value = item.linkedAccount;
    amount.value = item.transaction.amount;
    amountController.text = item.transaction.amount.toCurrency();
  }
}
