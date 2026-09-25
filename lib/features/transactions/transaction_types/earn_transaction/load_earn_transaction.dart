import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';

extension LoadEarnTransaction on TransactionController {
  void loadEarnTransaction(TransactionWithDetails item) {
    editingTransaction.value = item;
    selectedDate.value = item.transaction.date;
    selectedCategory.value = item.category;
    selectedAccount.value = item.account;
    amount.value = item.transaction.amount;
    amountController.text = item.transaction.amount.toCurrency();
  }
}
