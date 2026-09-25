import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';

extension LoadLoanPaymentTransaction on TransactionController {
  Future<void> loadLoanPaymentTransaction(TransactionWithDetails item) async {
    editingTransaction.value = item;

    selectedDate.value = item.transaction.date;
    selectedCategory.value = item.category;
    selectedAccount.value = item.account;
    selectedLinkedAccount.value = item.linkedAccount;

    amount.value = item.transaction.amount;
    amountController.text = item.transaction.amount.toCurrency();

    selectedBill.value = await database.billsDao
        .getBillWithOccurrenceByTransactionId(item.transaction.id);
  }
}
