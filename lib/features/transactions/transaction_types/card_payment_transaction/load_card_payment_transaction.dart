import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';

extension LoadCardPaymentTransaction on TransactionController {
  void loadCardPaymentTransaction(TransactionWithDetails item) {
    editingTransaction.value = item;

    selectedDate.value = item.transaction.date;

    // Account paying FROM
    selectedAccount.value = item.account;

    // Credit card being paid
    selectedLinkedAccount.value = item.linkedAccount;

    selectedCategory.value = item.category;

    amount.value = item.transaction.amount;
    amountController.text = item.transaction.amount.toCurrency();

    noteController.text = item.transaction.note ?? '';
  }
}
