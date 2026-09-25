import 'package:getx_drift_app/domain/enums/paid_by.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';

extension TransactionValidationExtension on TransactionController {
  bool get isSpendTransactionValid {
    if (selectedCategory.value == null || amount.value <= 0) {
      return false;
    }

    // I paid.
    if (paidBy.value == PaidBy.self) {
      if (selectedAccount.value == null) {
        return false;
      }

      // Shared expenses are only possible when I paid.
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
