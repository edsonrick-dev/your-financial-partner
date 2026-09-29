import 'package:get/get.dart';
import 'package:drift/drift.dart' as d;
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/split_mode_enum.dart';
import 'package:getx_drift_app/data/models/participant_model.dart';
import 'package:getx_drift_app/domain/enums/app_snack_type.dart';
import 'package:getx_drift_app/domain/enums/debt_management_type.dart';
import 'package:getx_drift_app/domain/enums/paid_by.dart';
import 'package:getx_drift_app/features/transactions/controllers/extensions/transaction_hydration_ext.dart';
import 'package:getx_drift_app/features/transactions/controllers/extensions/transaction_validation_extension.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/spend_transaction/validate_spend_transaction.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';

extension SaveSpendTransaction on TransactionController {
  Future<void> saveSpendTransaction(TransactionType type) async {
    final isEditing = editingTransaction.value != null;

    final category = selectedCategory.value;
    final account = selectedAccount.value;
    final payer = selectedPerson.value;
    final amountValue = amount.value;
    final bill = selectedBill.value;
    final isPaidByOthers = paidBy.value == PaidBy.others;

    if (type == TransactionType.debtRepayment) {
      if (!isDebtRepaymentTransactionValid) {
        return;
      }
    } else {
      if (!isSpendTransactionValid) {
        return;
      }
    }

    // Capture the old account before updating.
    final oldAccountId = editingTransaction.value?.transaction.accountId;
    final oldLinkedAccountId =
        editingTransaction.value?.transaction.linkedAccountId;
    // The account associated with this spend, if any.
    final newAccountId = isPaidByOthers ? null : account!.id;
    final linkedAccount = selectedLinkedAccount.value;

    await database.transaction(() async {
      int? transactionId = editingTransaction.value?.transaction.id;

      if (transactionId != null) {
        await database.deleteParticipantsByTransaction(transactionId);
        await database.deleteFinancialObligationsByTransaction(transactionId);

        await database.transactionsDao.updateTransaction(
          transactionId,
          TransactionsTableCompanion(
            amount: d.Value(amountValue),
            date: d.Value(selectedDate.value),
            categoryId: d.Value<int?>(category?.id),
            accountId: d.Value<int?>(newAccountId),
            linkedAccountId: d.Value<int?>(
              type == TransactionType.debtRepayment
                  ? selectedLinkedAccount.value?.id
                  : null,
            ),
            transactionType: d.Value(type.name),
            updatedAt: d.Value(DateTime.now()),
            note: d.Value(noteController.text.trim()),
          ),
        );
      } else {
        transactionId = await database.transactionsDao.insertTransaction(
          TransactionsTableCompanion.insert(
            transactionType: type.name,
            amount: amountValue,
            date: selectedDate.value,
            categoryId: d.Value<int?>(category?.id),
            accountId: d.Value<int?>(newAccountId),
            linkedAccountId: d.Value<int?>(
              type == TransactionType.debtRepayment ? linkedAccount?.id : null,
            ),
            createdAt: d.Value(DateTime.now()),
            updatedAt: d.Value(DateTime.now()),
            note: d.Value(noteController.text.trim()),
          ),
        );
      }

      // ----------------------------------------------------------
      // PAID BY SOMEONE ELSE
      // ----------------------------------------------------------

      if (isPaidByOthers) {
        final me = await database.entitiesDao.getCurrentUserEntity();

        if (me == null || payer == null) {
          throw Exception('Missing current user or payer.');
        }

        await database.transactionsDao.insertTransactionParticipant(
          TransactionParticipantsTableCompanion.insert(
            transactionId: transactionId,
            entityId: payer.id,
            allocatedAmount: amountValue,
            allocationPercentage: d.Value(1.0),
            isPayer: const d.Value(true),
            displayNameSnapshot: d.Value(payer.name),
          ),
        );

        await database.transactionsDao.insertFinancialObligation(
          FinancialObligationsTableCompanion.insert(
            transactionId: transactionId,
            debtorEntityId: me.id,
            creditorEntityId: payer.id,
            amount: amountValue,
            type: DebtManagementType.expensePaidByOthers.name,
          ),
        );
      }
      // ----------------------------------------------------------
      // PAID BY ME + SHARED EXPENSE
      // ----------------------------------------------------------
      else if (isSharedExpense.value) {
        if (!participants.any((p) => p.entityId == currentUserEntityId.value)) {
          participants.insert(
            0,
            ParticipantModel(
              entityId: currentUserEntityId.value!,
              name: 'Me',
              amount: 0,
              percentage: 0,
            ),
          );
        }

        if (splitMode.value == SplitMode.equal) {
          recalculateEqualSplit();
        }

        for (final participant in participants) {
          await database.transactionsDao.insertTransactionParticipant(
            TransactionParticipantsTableCompanion.insert(
              transactionId: transactionId,
              entityId: participant.entityId,
              allocatedAmount: participant.amount.value,
              allocationPercentage: d.Value(participant.percentage.value),
              isPayer: d.Value(
                participant.entityId == currentUserEntityId.value,
              ),
              displayNameSnapshot: d.Value(participant.name),
            ),
          );

          if (participant.entityId != currentUserEntityId.value) {
            await database.transactionsDao.insertFinancialObligation(
              FinancialObligationsTableCompanion.insert(
                transactionId: transactionId,
                debtorEntityId: participant.entityId,
                creditorEntityId: currentUserEntityId.value!,
                amount: participant.amount.value,
                type: DebtManagementType.splitExpense.name,
              ),
            );
          }
        }
      }
      // ----------------------------------------------------------
      // LINK BILL OCCURRENCE
      // ----------------------------------------------------------

      if (bill != null) {
        await database.billsDao.markOccurrenceAsPaid(
          occurrenceId: bill.occurrence.id,
          transactionId: transactionId,
          actualAmount: amountValue,
        );

        await database.billsDao.ensureFutureOccurrence(bill.bill.id);
      }
      // ----------------------------------------------------------
      // REBUILD AFFECTED ACCOUNTS
      // ----------------------------------------------------------

      final newLinkedAccountId = type == TransactionType.debtRepayment
          ? selectedLinkedAccount.value?.id
          : null;

      final affectedAccountIds = <int>{
        ?oldAccountId,
        ?newAccountId,
        ?oldLinkedAccountId,
        ?newLinkedAccountId,
      };
      for (final accountId in affectedAccountIds) {
        await database.accountsDao.rebuildAccountBalance(accountId);
      }
    });

    resetForm();

    Get.back();

    AppSnackbar.show(
      title: isEditing ? 'Transaction Updated' : 'Transaction Saved',
      message: isEditing
          ? '${amountValue.toCurrency()} transaction updated'
          : isPaidByOthers
          ? '${amountValue.toCurrency()} paid by ${payer!.name}'
          : '${amountValue.toCurrency()} deducted from ${account!.name}',
      type: AppSnackType.success,
    );
  }
}
