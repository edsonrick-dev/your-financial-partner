import 'package:get/get.dart' as c;
import 'package:drift/drift.dart' as d;
import 'package:get/route_manager.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/domain/enums/app_snack_type.dart';
import 'package:getx_drift_app/domain/enums/debt_management_type.dart';
import 'package:getx_drift_app/features/transactions/controllers/extensions/transaction_hydration_ext.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/core/num_extension.dart';

extension SaveGiveMoneyTransaction on TransactionController {
  Future<void> saveGiveMoneyTransaction() async {
    final existing = editingTransaction.value;
    final isEditing = existing != null;

    final person = selectedPerson.value;
    final account = selectedAccount.value;
    final amountValue = amount.value;

    if (person == null) {
      Get.snackbar('Missing Person', 'Select a person.');
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
      int transactionId;

      // ============================================================
      // 1. REVERSE OLD TRANSACTION EFFECTS
      // ============================================================

      if (existing != null) {
        final oldTransaction = existing.transaction;

        // Give Money originally reduced the account.
        // Reverse that reduction.
        if (oldTransaction.accountId != null) {
          await database.accountsDao.adjustAccountBalance(
            oldTransaction.accountId!,
            oldTransaction.amount,
          );
        }

        // Remove the old participant.
        await database.transactionsDao.deleteParticipantsByTransaction(
          oldTransaction.id,
        );

        // Remove the old debt obligation, if one existed.
        await database.transactionsDao.deleteFinancialObligationsByTransaction(
          oldTransaction.id,
        );
      }

      // ============================================================
      // 2. CREATE / UPDATE TRANSACTION
      // ============================================================

      if (existing != null) {
        transactionId = existing.transaction.id;

        await database.transactionsDao.updateTransaction(
          transactionId,
          TransactionsTableCompanion(
            amount: d.Value(amountValue),
            date: d.Value(selectedDate.value),
            accountId: d.Value(account.id),
            updatedAt: d.Value(DateTime.now()),
            note: d.Value(noteController.text.trim()),
          ),
        );
      } else {
        transactionId = await database.transactionsDao.insertTransaction(
          TransactionsTableCompanion.insert(
            amount: amountValue,
            date: selectedDate.value,
            transactionType: TransactionType.give.name,
            accountId: d.Value(account.id),
            createdAt: d.Value(DateTime.now()),
            updatedAt: d.Value(DateTime.now()),
            note: d.Value(noteController.text.trim()),
          ),
        );
      }

      // ============================================================
      // 3. APPLY NEW ACCOUNT EFFECT
      // ============================================================

      await database.accountsDao.adjustAccountBalance(account.id, -amountValue);

      // ============================================================
      // 4. RECREATE PARTICIPANT
      // ============================================================

      await database.transactionsDao.insertTransactionParticipant(
        TransactionParticipantsTableCompanion.insert(
          transactionId: transactionId,
          entityId: person.id,
          displayNameSnapshot: d.Value(person.name),
          allocatedAmount: amountValue,
        ),
      );

      // ============================================================
      // 5. RECREATE OBLIGATION IF TRACKING DEBT
      // ============================================================

      if (isDebt.value) {
        final me = await database.entitiesDao.getCurrentUserEntity();

        if (me == null) {
          throw Exception('Current user not found');
        }

        await database.transactionsDao.insertFinancialObligation(
          FinancialObligationsTableCompanion.insert(
            transactionId: transactionId,
            debtorEntityId: person.id,
            creditorEntityId: me.id,
            amount: amountValue,
            type: DebtManagementType.giveMoney.name,
          ),
        );
      }
    });

    resetForm();

    Get.back();

    AppSnackbar.show(
      title: isEditing ? 'Transaction Updated' : 'Transaction Saved',
      message: isEditing
          ? '${amountValue.toCurrency()} transaction updated'
          : '${amountValue.toCurrency()} deducted from ${account.name}',
      type: AppSnackType.success,
    );
  }
}
