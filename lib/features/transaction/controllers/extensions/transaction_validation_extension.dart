import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/forms/spend_transaction_form.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';

extension TransactionValidationExtension on TransactionController {
  // bool get isSpendTransactionValid {
  //   final hasBasicFields =
  //       selectedCategory.value != null &&
  //       selectedAccount.value != null &&
  //       amount.value > 0;

  //   if (!hasBasicFields) {
  //     return false;
  //   }
  //   if (isSharedExpense.value) {
  //     return participants.length > 1 && isFullyAllocated;
  //   }

  //   return true;
  // }
  // bool get isSpendTransactionValid {
  //   final hasBasicFields = selectedCategory.value != null && amount.value > 0;

  //   if (!hasBasicFields) {
  //     return false;
  //   }

  //   if (paidBy.value == PaidBy.self && selectedAccount.value == null) {
  //     return false;
  //   }

  //   if (paidBy.value == PaidBy.others && selectedPerson.value == null) {
  //     return false;
  //   }

  //   if (isSharedExpense.value) {
  //     if (paidBy.value != PaidBy.self) {
  //       return false;
  //     }

  //     return participants.length > 1 && isFullyAllocated;
  //   }

  //   return true;
  // }
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

  bool isTransactionValid(TransactionType type) {
    switch (type) {
      case TransactionType.earn:
        return isEarnTransactionValid;

      case TransactionType.spend:
        return isSpendTransactionValid;

      case TransactionType.transfer:
        return isTransferTransactionValid;

      case TransactionType.receive:
        return isReceiveMoneyTransactionValid;

      case TransactionType.give:
        return isGiveMoneyTransactionValid;

      case TransactionType.balanceUpdate:
        return false;
    }
  }
}
