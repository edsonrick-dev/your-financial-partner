import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:getx_drift_app/data/enums/split_mode_enum.dart';

extension TransactionHydration on TransactionController {
  void resetForm() {
    editingTransaction.value = null;

    selectedDate.value = DateTime.now();

    selectedCategory.value = null;

    selectedAccount.value = null;
    selectedBill.value = null;
    selectedLinkedAccount.value = null;
    noteController.clear();
    amount.value = 0;
    selectedPerson.value = null;
    selectedPersonBalance.value = null;
    amountController.clear();
    isSharedExpense.value = false;
    isDebt.value = false;
    participants.clear();
  }

  void inferSplitMode() {
    if (participants.isEmpty) {
      splitMode.value = SplitMode.equal;

      return;
    }

    final firstAmount = participants.first.amount.value;

    final allEqual = participants.every(
      (participant) => participant.amount.value == firstAmount,
    );

    splitMode.value = allEqual ? SplitMode.equal : SplitMode.custom;
  }
}
