import 'package:get/get.dart' as c;
import 'package:drift/drift.dart' as d;
import 'package:get/route_manager.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/domain/enums/app_snack_type.dart';
import 'package:getx_drift_app/features/transactions/controllers/extensions/transaction_hydration_ext.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/core/num_extension.dart';

extension SaveCardPaymentTransaction on TransactionController {
  Future<void> saveCardPaymentTransaction() async {
    final isEditing = editingTransaction.value != null;

    final paymentAccount = selectedAccount.value;
    final creditCardAccount = selectedLinkedAccount.value;
    final amountValue = amount.value;

    // ============================================================
    // VALIDATION
    // ============================================================

    if (paymentAccount == null) {
      Get.snackbar(
        'Missing Account',
        'Select the account you are paying from.',
      );
      return;
    }

    if (creditCardAccount == null) {
      Get.snackbar(
        'Missing Credit Card',
        'Select the credit card you are paying.',
      );
      return;
    }

    if (paymentAccount.id == creditCardAccount.id) {
      Get.snackbar(
        'Invalid Payment',
        'The payment account and credit card must be different.',
      );
      return;
    }

    if (amountValue <= 0) {
      Get.snackbar('Invalid Amount', 'Enter a payment amount.');
      return;
    }

    await database.transaction(() async {
      final oldTransaction = editingTransaction.value?.transaction;

      int? transactionId = oldTransaction?.id;

      // ============================================================
      // AFFECTED ACCOUNTS
      // ============================================================

      final affectedAccountIds = <int>{paymentAccount.id, creditCardAccount.id};

      if (oldTransaction != null) {
        if (oldTransaction.accountId != null) {
          affectedAccountIds.add(oldTransaction.accountId!);
        }

        if (oldTransaction.linkedAccountId != null) {
          affectedAccountIds.add(oldTransaction.linkedAccountId!);
        }
      }

      // ============================================================
      // CREATE / UPDATE TRANSACTION
      // ============================================================

      if (transactionId != null) {
        await database.transactionsDao.updateTransaction(
          transactionId,
          TransactionsTableCompanion(
            amount: d.Value(amountValue),
            date: d.Value(selectedDate.value),
            accountId: d.Value(paymentAccount.id),
            linkedAccountId: d.Value(creditCardAccount.id),
            transactionType: d.Value(TransactionType.cardPayment.name),
            updatedAt: d.Value(DateTime.now()),
            note: d.Value(noteController.text.trim()),
          ),
        );
      } else {
        transactionId = await database.transactionsDao.insertTransaction(
          TransactionsTableCompanion.insert(
            amount: amountValue,
            date: selectedDate.value,
            transactionType: TransactionType.cardPayment.name,
            accountId: d.Value(paymentAccount.id),
            linkedAccountId: d.Value(creditCardAccount.id),
            createdAt: d.Value(DateTime.now()),
            updatedAt: d.Value(DateTime.now()),
            note: d.Value(noteController.text.trim()),
          ),
        );
      }

      // ============================================================
      // REBUILD BALANCES
      // ============================================================

      for (final accountId in affectedAccountIds) {
        await database.accountsDao.rebuildAccountBalance(accountId);
      }
    });

    // ============================================================
    // CLOSE SHEET
    // ============================================================

    resetForm();

    Get.back();

    AppSnackbar.show(
      title: isEditing ? 'Card Payment Updated' : 'Card Payment Saved',
      message: isEditing
          ? '${amountValue.toCurrency()} card payment updated'
          : '${amountValue.toCurrency()} paid to ${creditCardAccount.name}',
      type: AppSnackType.success,
    );
  }
}
