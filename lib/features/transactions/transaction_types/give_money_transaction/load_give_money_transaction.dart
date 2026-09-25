import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';

extension LoadGiveMoneyTransaction on TransactionController {
  void loadGiveMoneyTransaction(TransactionWithDetails item) {
    editingTransaction.value = item;

    selectedDate.value = item.transaction.date;
    selectedAccount.value = item.account;
    amount.value = item.transaction.amount;
    if (item.participants.isNotEmpty) {
      selectedPerson.value = item.participants.first.entity;
    }

    isDebt.value = item.hasDebtImpact;
    amountController.text = item.transaction.amount.toCurrency();
  }
}
