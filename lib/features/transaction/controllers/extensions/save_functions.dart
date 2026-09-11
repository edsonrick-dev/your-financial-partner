import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' as c;
import 'package:drift/drift.dart' as d;
import 'package:get/route_manager.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/data/enums/split_mode_enum.dart';
import 'package:getx_drift_app/data/models/participant_model.dart';
import 'package:getx_drift_app/domain/enums/app_snack_type.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/forms/spend_transaction_form.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/transaction_hydration_ext.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/transaction_validation_extension.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/core/num_extension.dart';

enum DebtManagementType {
  splitExpense,
  expensePaidByOthers,
  receiveMoney,
  giveMoney,
}

extension SaveTransactionFunctions on TransactionController {
  Future<void> saveTransaction(TransactionType type) async {
    switch (type) {
      case TransactionType.earn:
        if (!isEarnTransactionValid) return;
        await saveEarnTransaction();

      case TransactionType.spend:
        if (!isSpendTransactionValid) return;
        await saveSpendTransaction(TransactionType.spend);

      case TransactionType.transfer:
        if (!isTransferTransactionValid) return;
        await saveTransferTransaction();

      case TransactionType.receive:
        if (!isReceiveMoneyTransactionValid) return;
        await saveReceiveMoneyTransaction();

      case TransactionType.give:
        if (!isGiveMoneyTransactionValid) return;
        await saveGiveMoneyTransaction();

      case TransactionType.debtRepayment:
        debugPrint('>>> debtRepayment CASE');

        debugPrint('>>> amount: ${amount.value}');
        debugPrint('>>> selectedAccount: ${selectedAccount.value?.id}');
        debugPrint(
          '>>> selectedLinkedAccount: ${selectedLinkedAccount.value?.id}',
        );
        debugPrint('>>> paidBy: ${paidBy.value}');

        debugPrint(
          '>>> isDebtRepaymentTransactionValid: '
          '$isDebtRepaymentTransactionValid',
        );

        if (!isDebtRepaymentTransactionValid) {
          debugPrint('>>> DEBT REPAYMENT VALIDATION FAILED');
          return;
        }

        debugPrint('>>> calling saveSpendTransaction');

        await saveSpendTransaction(TransactionType.debtRepayment);

      case TransactionType.balanceUpdate:
        return;
    }
  }

  Future<void> saveSpendTransaction(TransactionType type) async {
    debugPrint('========== VERSION TEST 123 ==========');
    debugPrint('>>> saveSpendTransaction START: ${type.name}');
    final isEditing = editingTransaction.value != null;

    final category = selectedCategory.value;
    final account = selectedAccount.value;
    final payer = selectedPerson.value;
    final amountValue = amount.value;
    final bill = selectedBill.value;
    final isPaidByOthers = paidBy.value == PaidBy.others;

    debugPrint('>>> amount: $amountValue');
    debugPrint('>>> categoryId: ${category?.id}');
    debugPrint('>>> accountId: ${account?.id}');
    debugPrint('>>> linkedAccountId: ${selectedLinkedAccount.value?.id}');
    debugPrint('>>> billId: ${bill?.bill.id}');
    debugPrint('>>> billOccurrenceId: ${bill?.occurrence.id}');
    debugPrint('>>> isPaidByOthers: $isPaidByOthers');

    if (type == TransactionType.debtRepayment) {
      if (!isDebtRepaymentTransactionValid) {
        debugPrint('>>> DEBT REPAYMENT VALIDATION FAILED');
        return;
      }
    } else {
      if (!isSpendTransactionValid) {
        debugPrint('>>> SPEND VALIDATION FAILED');
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
    debugPrint('>>> BEFORE DATABASE TRANSACTION');
    debugPrint(
      '>>> editingTransaction NOW: '
      '${editingTransaction.value?.transaction.id}',
    );

    try {
      await database.transaction(() async {
        debugPrint('>>> DATABASE TRANSACTION STARTED');

        int? transactionId = editingTransaction.value?.transaction.id;

        debugPrint('>>> transactionId NOW: $transactionId');

        if (transactionId != null) {
          debugPrint('>>> ENTERED UPDATE BRANCH');

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
          debugPrint('>>> ENTERED INSERT BRANCH');

          transactionId = await database.transactionsDao.insertTransaction(
            TransactionsTableCompanion.insert(
              transactionType: type.name,
              amount: amountValue,
              date: selectedDate.value,
              categoryId: d.Value<int?>(category?.id),
              accountId: d.Value<int?>(newAccountId),
              linkedAccountId: d.Value<int?>(
                type == TransactionType.debtRepayment
                    ? linkedAccount?.id
                    : null,
              ),
              createdAt: d.Value(DateTime.now()),
              updatedAt: d.Value(DateTime.now()),
              note: d.Value(noteController.text.trim()),
            ),
          );
          debugPrint('>>> INSERT SUCCESS');
          debugPrint('>>> NEW TRANSACTION ID: $transactionId');
        }
        debugPrint('>>> AFTER TRANSACTION INSERT/UPDATE');

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
          if (!participants.any(
            (p) => p.entityId == currentUserEntityId.value,
          )) {
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
      debugPrint('>>> DATABASE TRANSACTION COMPLETED');
    } catch (e, stackTrace) {
      debugPrint('!!! SAVE TRANSACTION ERROR !!!');
      debugPrint('!!! $e');
      debugPrint('$stackTrace');
      rethrow;
    }
    debugPrint('>>> DATABASE SAVE SUCCESSFUL');
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
            accountId: d.Value(account.id),
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
            accountId: d.Value(account.id),
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
