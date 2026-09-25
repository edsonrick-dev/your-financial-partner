import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';

extension ValidateEarnTransaction on TransactionController {
  bool get isEarnTransactionValid {
    return selectedCategory.value != null &&
        selectedAccount.value != null &&
        amount.value > 0;
  }
}
