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

extension SaveTransferTransaction on TransactionController {
  Future<void> saveTransferTransaction() async {
    final isEditing = editingTransaction.value != null;
    final accountFrom = selectedAccount.value;
    final accountTo = selectedLinkedAccount.value;
    final amountValue = amount.value;

    /// VALIDATION

    if (accountFrom == null) {
      Get.snackbar('Missing Account', 'Select an account.');
      return;
    }

    if (accountTo == null) {
      Get.snackbar('Missing Account', 'Select an account.');
      return;
    }

    if (accountFrom.id == accountTo.id) {
      Get.snackbar(
        'Invalid Transfer',
        'The source and destination accounts must be different.',
      );
      return;
    }

    if (amountValue <= 0) {
      Get.snackbar('Invalid Amount', 'Enter an amount.');
      return;
    }

    await database.transaction(() async {
      final oldTransaction = editingTransaction.value?.transaction;

      int? transactionId = oldTransaction?.id;

      /// ACCOUNTS AFFECTED BY THIS OPERATION
      ///
      /// For a new transfer:
      ///   accountFrom + accountTo
      ///
      /// For an edited transfer:
      ///   old source + old destination
      ///   new source + new destination
      ///
      /// Using a Set prevents duplicate rebuilds when
      /// the old/new accounts are the same.
      final affectedAccountIds = <int>{accountFrom.id, accountTo.id};

      if (oldTransaction != null) {
        if (oldTransaction.accountId != null) {
          affectedAccountIds.add(oldTransaction.accountId!);
        }

        if (oldTransaction.linkedAccountId != null) {
          affectedAccountIds.add(oldTransaction.linkedAccountId!);
        }
      }

      /// SAVE / UPDATE TRANSACTION

      if (transactionId != null) {
        await database.transactionsDao.updateTransaction(
          transactionId,
          TransactionsTableCompanion(
            amount: d.Value(amountValue),
            date: d.Value(selectedDate.value),
            accountId: d.Value(accountFrom.id),
            linkedAccountId: d.Value(accountTo.id),
            updatedAt: d.Value(DateTime.now()),
            note: d.Value(noteController.text.trim()),
          ),
        );
      } else {
        transactionId = await database.transactionsDao.insertTransaction(
          TransactionsTableCompanion.insert(
            amount: amountValue,
            date: selectedDate.value,
            transactionType: TransactionType.transfer.name,
            accountId: d.Value(accountFrom.id),
            linkedAccountId: d.Value(accountTo.id),
            createdAt: d.Value(DateTime.now()),
            updatedAt: d.Value(DateTime.now()),
            note: d.Value(noteController.text.trim()),
          ),
        );
      }

      /// REBUILD BALANCES
      ///
      /// Do NOT manually add/subtract the transfer amount.
      /// The transaction is already stored, so _calculateBalance()
      /// will calculate the correct result.

      for (final accountId in affectedAccountIds) {
        await database.accountsDao.rebuildAccountBalance(accountId);
      }
    });

    /// CLOSE SHEET

    resetForm();

    Get.back();

    AppSnackbar.show(
      title: isEditing ? 'Transaction Updated' : 'Transaction Saved',
      message: isEditing
          ? '${amountValue.toCurrency()} transaction updated'
          : '${amountValue.toCurrency()} transferred from ${accountFrom.name} to ${accountTo.name}',
      type: AppSnackType.success,
    );
  }
}
