import 'package:get/get.dart' as c;
import 'package:drift/drift.dart' as d;
import 'package:get/route_manager.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/data/enums/split_mode_enum.dart';
import 'package:getx_drift_app/data/models/participant_model.dart';
import 'package:getx_drift_app/domain/enums/app_snack_type.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/transaction_hydration_ext.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/core/num_extension.dart';

enum DebtManagementType { splitExpense, receiveMoney, giveMoney }

extension SaveTransactionFunctions on TransactionController {
  Future<void> saveSpendTransaction() async {
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
        // Remove data derived from the old version of this transaction.
        await database.deleteParticipantsByTransaction(transactionId);
        await database.deleteFinancialObligationsByTransaction(transactionId);
        await database.transactionsDao.updateTransaction(
          transactionId,
          TransactionsTableCompanion(
            amount: d.Value(amountValue),
            date: d.Value(selectedDate.value),
            categoryId: d.Value(category.id),
            accountId: d.Value(account.id),
            updatedAt: d.Value(DateTime.now()),
            note: d.Value(noteController.text.trim()),
          ),
        );
      } else {
        transactionId = await database.transactionsDao.insertTransaction(
          TransactionsTableCompanion.insert(
            transactionType: TransactionType.spend.name,
            amount: amountValue,
            date: selectedDate.value,
            categoryId: d.Value<int?>(category.id),
            accountId: account.id,
            createdAt: d.Value(DateTime.now()),
            updatedAt: d.Value(DateTime.now()),
            note: d.Value(noteController.text.trim()),
          ),
        );
      }

      ///SPLIT EXPENSE LOGIC
      if (isSharedExpense.value) {
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
      // if (isSharedExpense.value) {
      //   // final hasCurrentUser = participants.any(
      //   //   (participant) => participant.entityId == currentUserEntityId.value,
      //   // );
      //   final participantList = [...participants];

      //   if (!participantList.any(
      //     (p) => p.entityId == currentUserEntityId.value,
      //   )) {
      //     participantList.insert(
      //       0,
      //       ParticipantModel(
      //         entityId: currentUserEntityId.value!,
      //         name: 'Me',
      //         amount: 0,
      //         percentage: 0,
      //       ),
      //     );
      //   }
      //   // if (!hasCurrentUser) {
      //   //   participants.insert(
      //   //     0,
      //   //     ParticipantModel(
      //   //       entityId: currentUserEntityId.value!,
      //   //       name: 'Me',
      //   //       amount: 0,
      //   //       percentage: 0,
      //   //     ),
      //   //   );
      //   // }
      //   if (splitMode.value == SplitMode.equal) {
      //     recalculateEqualSplit();
      //   }
      //   for (final participant in participantList) {
      //     await database.transactionsDao.insertTransactionParticipant(
      //       TransactionParticipantsTableCompanion.insert(
      //         transactionId: transactionId,
      //         entityId: participant.entityId,
      //         allocatedAmount: participant.amount.value,
      //         allocationPercentage: d.Value(participant.percentage.value),
      //         isPayer: d.Value(
      //           participant.entityId == currentUserEntityId.value,
      //         ),
      //         displayNameSnapshot: d.Value(participant.name),
      //       ),
      //     );
      //     if (participant.entityId != currentUserEntityId.value) {
      //       await database.transactionsDao.insertFinancialObligation(
      //         FinancialObligationsTableCompanion.insert(
      //           transactionId: transactionId,
      //           debtorEntityId: participant.entityId,
      //           creditorEntityId: currentUserEntityId.value!,
      //           amount: participant.amount.value,
      //           type: DebtManagementType.splitExpense.name,
      //         ),
      //       );
      //     }
      //   }
      // }
    });

    await database.accountsDao.rebuildAccountBalance(account.id);

    /// CLOSE SHEET
    ///

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
            accountId: account.id,
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
        affectedAccountIds.add(oldTransaction.accountId);

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
            accountId: accountFrom.id,
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

  Future<void> saveReceiveMoneyTransaction() async {
    final isEditing = editingTransaction.value != null;
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
      int? transactionId = editingTransaction.value?.transaction.id;

      if (transactionId != null) {
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
            transactionType: TransactionType.receive.name,
            accountId: account.id,
            createdAt: d.Value(DateTime.now()),
            updatedAt: d.Value(DateTime.now()),
            note: d.Value(noteController.text.trim()),
          ),
        );
      }

      await database.accountsDao.adjustAccountBalance(account.id, amountValue);

      await database.transactionsDao.insertTransactionParticipant(
        TransactionParticipantsTableCompanion.insert(
          transactionId: transactionId,
          entityId: person.id,
          displayNameSnapshot: d.Value(person.name),
          allocatedAmount: amountValue,
        ),
      );

      if (isDebt.value) {
        final me = await database.entitiesDao.getCurrentUserEntity();

        if (me == null) {
          throw Exception('Current user not found');
        }

        await database.transactionsDao.insertFinancialObligation(
          FinancialObligationsTableCompanion.insert(
            transactionId: transactionId,

            /// I received money from this person
            /// therefore I owe them
            debtorEntityId: me.id,

            creditorEntityId: person.id,

            amount: amountValue,

            type: DebtManagementType.receiveMoney.name,
          ),
        );
      }
    });

    // });

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

  Future<void> saveGiveMoneyTransaction() async {
    final isEditing = editingTransaction.value != null;
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
      int? transactionId = editingTransaction.value?.transaction.id;

      if (transactionId != null) {
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
            accountId: account.id,
            createdAt: d.Value(DateTime.now()),
            updatedAt: d.Value(DateTime.now()),
            note: d.Value(noteController.text.trim()),
          ),
        );
      }

      await database.accountsDao.adjustAccountBalance(account.id, -amountValue);

      await database.transactionsDao.insertTransactionParticipant(
        TransactionParticipantsTableCompanion.insert(
          transactionId: transactionId,
          entityId: person.id,
          displayNameSnapshot: d.Value(person.name),
          allocatedAmount: amountValue,
        ),
      );
      if (isDebt.value) {
        final me = await database.entitiesDao.getCurrentUserEntity();

        if (me == null) {
          throw Exception('Current user not found');
        }

        await database.transactionsDao.insertFinancialObligation(
          FinancialObligationsTableCompanion.insert(
            transactionId: transactionId,

            /// I received money from this person
            /// therefore I owe them
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
