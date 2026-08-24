import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';

extension TransactionValidationExtension on TransactionController {
  bool get isSpendTransactionValid {
    final hasBasicFields =
        selectedCategory.value != null &&
        selectedAccount.value != null &&
        amount.value > 0;

    if (!hasBasicFields) {
      return false;
    }
    if (isSharedExpense.value) {
      return participants.length > 1 && isFullyAllocated;
    }

    return true;
  }

  bool get isEarnTransactionValid {
    return selectedCategory.value != null &&
        selectedAccount.value != null &&
        amount.value > 0;
  }

  bool get isTransferTransactionValid {
    final accountFrom = selectedAccount.value;
    final accountTo = selectedLinkedAccount.value;

    return accountFrom != null &&
        accountTo != null &&
        accountFrom.id != accountTo.id &&
        amount.value > 0;
  }

  bool get isReceiveMoneyTransactionValid {
    return selectedPerson.value != null &&
        selectedAccount.value != null &&
        amount.value > 0;
  }

  bool get isGiveMoneyTransactionValid {
    return selectedPerson.value != null &&
        selectedAccount.value != null &&
        amount.value > 0;
  }
}
