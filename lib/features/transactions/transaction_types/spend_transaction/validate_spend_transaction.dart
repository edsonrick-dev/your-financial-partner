import 'package:getx_drift_app/domain/enums/paid_by.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';

extension TransactionValidationExtension on TransactionController {
  bool get isSpendTransactionValid {
    final hasCategory = selectedCategory.value != null;
    final hasBill = selectedBill.value != null;

    // Must have either a category OR a bill.
    if ((!hasCategory && !hasBill) || amount.value <= 0) {
      return false;
    }

    // I paid.
    if (paidBy.value == PaidBy.self) {
      if (selectedAccount.value == null) {
        return false;
      }

      if (isSharedExpense.value) {
        return participants.length > 1 && isFullyAllocated;
      }

      return true;
    }

    // Someone else paid.
    if (paidBy.value == PaidBy.others) {
      return selectedPerson.value != null;
    }

    return false;
  }
}
