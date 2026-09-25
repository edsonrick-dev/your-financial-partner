import 'package:getx_drift_app/features/transactions/transaction_types/earn_transaction/validate_earn_transaction.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/spend_transaction/validate_spend_transaction.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';

extension TransactionValidationExtension on TransactionController {
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

  bool get isDebtRepaymentTransactionValid {
    return selectedAccount.value != null &&
        selectedLinkedAccount.value != null &&
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

      case TransactionType.debtRepayment:
      case TransactionType.cardPayment:
        return isDebtRepaymentTransactionValid;

      case TransactionType.balanceUpdate:
        return false;
    }
  }
}
