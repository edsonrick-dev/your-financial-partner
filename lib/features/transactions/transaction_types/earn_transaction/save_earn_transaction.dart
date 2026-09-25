import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/domain/enums/app_snack_type.dart';
import 'package:getx_drift_app/features/transactions/controllers/extensions/transaction_hydration_ext.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:drift/drift.dart' as d;

extension SaveEarnTransaction on TransactionController {
  Future<void> saveEarnTransaction() async {
    final isEditing = editingTransaction.value != null;
    final category = selectedCategory.value;
    final account = selectedAccount.value;
    final amountValue = amount.value;

    /// VALIDATION

    if (category == null) {
      Get.snackbar('Missing Category', 'Select a category.');
      return;
    }

    if (account == null) {
      Get.snackbar('Missing Account', 'Select an account.');
      return;
    }

    if (amountValue <= 0) {
      Get.snackbar('Invalid Amount', 'Enter an amount.');
      return;
    }
    await database.transaction(() async {
      int? transactionId = editingTransaction.value?.transaction.id;

      if (transactionId != null) {
        await database.transactionsDao.updateTransaction(
          transactionId,
          TransactionsTableCompanion(
            amount: d.Value(amountValue),
            date: d.Value(selectedDate.value),
            note: d.Value(noteController.text.trim()),
            categoryId: d.Value(category.id),
            accountId: d.Value(account.id),
            updatedAt: d.Value(DateTime.now()),
          ),
        );
      } else {
        transactionId = await database.transactionsDao.insertTransaction(
          TransactionsTableCompanion.insert(
            amount: amountValue,
            date: selectedDate.value,
            transactionType: TransactionType.earn.name,
            categoryId: d.Value<int?>(category.id),
            accountId: d.Value(account.id),
            createdAt: d.Value(DateTime.now()),
            updatedAt: d.Value(DateTime.now()),
            note: d.Value(noteController.text.trim()),
          ),
        );
      }
      await database.accountsDao.rebuildAccountBalance(account.id);
    });

    resetForm();

    Get.back();
    AppSnackbar.show(
      title: isEditing ? 'Transaction Updated' : 'Transaction Saved',
      message: isEditing
          ? '${amountValue.toCurrency()} transaction updated'
          : '${amountValue.toCurrency()} added to ${account.name}',
      type: AppSnackType.success,
    );
  }
}
