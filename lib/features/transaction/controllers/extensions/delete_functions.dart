import 'package:flutter/rendering.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';

extension DeleteFunctions on TransactionController {
  Future<void> reverseTransactionEffects(TransactionWithDetails item) async {
    await database.transaction(() async {
      final transactionData = item.transaction;
      final account = item.account;
      final linkedAccount = item.linkedAccount;

      final type = TransactionType.values.firstWhere(
        (e) => e.name == transactionData.transactionType,
      );
      switch (type) {
        case TransactionType.earn:
          await database.accountsDao.updateAccountBalance(
            account.id,
            account.currentValue - transactionData.amount,
          );
          break;

        case TransactionType.spend:
          await database.accountsDao.updateAccountBalance(
            account.id,
            account.currentValue + transactionData.amount,
          );

          await database.deleteFinancialObligationsByTransaction(
            transactionData.id,
          );

          await database.deleteParticipantsByTransaction(transactionData.id);
          break;

        case TransactionType.transfer:
          if (linkedAccount == null) {
            throw Exception('Transfer transaction missing linked account.');
          }

          await database.accountsDao.updateAccountBalance(
            account.id,
            account.currentValue + transactionData.amount,
          );

          await database.accountsDao.updateAccountBalance(
            linkedAccount.id,
            linkedAccount.currentValue - transactionData.amount,
          );
          break;

        case TransactionType.receive:
          await database.accountsDao.updateAccountBalance(
            account.id,
            account.currentValue - transactionData.amount,
          );

          await database.deleteFinancialObligationsByTransaction(
            transactionData.id,
          );

          await database.deleteParticipantsByTransaction(transactionData.id);
          break;
        case TransactionType.give:
          break;
      }
    });
  }

  Future<void> deleteTransactionWithBalanceUpdate(
    TransactionWithDetails item,
  ) async {
    await database.transaction(() async {
      final transactionData = item.transaction;
      final account = item.account;
      final linkedAccount = item.linkedAccount;

      if (transactionData.transactionType == TransactionType.earn.name) {
        await database.accountsDao.updateAccountBalance(
          account.id,
          account.currentValue - transactionData.amount,
        );
      }

      if (transactionData.transactionType == TransactionType.spend.name) {
        await database.accountsDao.updateAccountBalance(
          account.id,
          account.currentValue + transactionData.amount,
        );

        final deleted = await database.deleteFinancialObligationsByTransaction(
          transactionData.id,
        );

        debugPrint('Deleted obligations: $deleted');

        // await database.deleteParticipantsByTransaction(
        //   transactionData.id,
        // );

        final obligations = await (database.select(
          database.financialObligationsTable,
        )..where((tbl) => tbl.transactionId.equals(transactionData.id))).get();

        debugPrint('Remaining obligations: ${obligations.length}');
      }

      if (transactionData.transactionType == TransactionType.transfer.name) {
        if (linkedAccount == null) {
          throw Exception('Transfer transaction missing linked account.');
        }

        await database.accountsDao.updateAccountBalance(
          account.id,
          account.currentValue + transactionData.amount,
        );

        await database.accountsDao.updateAccountBalance(
          linkedAccount.id,
          linkedAccount.currentValue - transactionData.amount,
        );
      }

      if (transactionData.transactionType == TransactionType.receive.name) {
        await database.accountsDao.updateAccountBalance(
          account.id,
          account.currentValue - transactionData.amount,
        );
        await database.deleteFinancialObligationsByTransaction(
          transactionData.id,
        );

        await database.deleteParticipantsByTransaction(transactionData.id);
      }
      if (transactionData.transactionType == TransactionType.give.name) {
        await database.accountsDao.updateAccountBalance(
          account.id,
          account.currentValue + transactionData.amount,
        );
        await database.deleteFinancialObligationsByTransaction(
          transactionData.id,
        );

        await database.deleteParticipantsByTransaction(transactionData.id);
      }

      await database.deleteTransaction(transactionData.id);
    });
  }
}
