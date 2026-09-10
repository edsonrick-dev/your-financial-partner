import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/transactions_table.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';

extension DeleteFunctions on TransactionController {
  Future<void> deleteTransactionById(int transactionId) async {
    final transaction = await database.transactionsDao
        .getTransactionWithDetailsById(transactionId);

    if (transaction == null) {
      return;
    }

    await deleteTransaction(transaction);
  }

  Future<void> deleteTransaction(TransactionWithDetails item) async {
    await database.transaction(() async {
      final transactionData = item.transaction;

      /// KEEP TRACK OF ALL ACCOUNTS AFFECTED
      final affectedAccountIds = <int>{};

      if (transactionData.accountId != null) {
        affectedAccountIds.add(transactionData.accountId!);
      }

      /// TRANSFERS AFFECT TWO ACCOUNTS
      // if (transactionData.type == TransactionType.transfer) {
      //   final linkedAccountId = transactionData.linkedAccountId;

      //   if (linkedAccountId == null) {
      //     throw Exception('Transfer transaction missing linked account.');
      //   }

      //   affectedAccountIds.add(linkedAccountId);
      // }
      if (transactionData.type == TransactionType.transfer ||
          transactionData.type == TransactionType.debtRepayment) {
        final linkedAccountId = transactionData.linkedAccountId;

        if (linkedAccountId == null) {
          throw Exception(
            '${transactionData.type.name} transaction missing linked account.',
          );
        }

        affectedAccountIds.add(linkedAccountId);
      }

      BillOccurrencesTableData? billOccurrence;

      if (transactionData.type == TransactionType.spend) {
        billOccurrence = await database.billsDao.getOccurrenceByTransactionId(
          transactionData.id,
        );
      }

      /// DELETE RELATED DATA
      switch (transactionData.type) {
        case TransactionType.earn:
          break;

        case TransactionType.spend:
          await database.deleteFinancialObligationsByTransaction(
            transactionData.id,
          );

          await database.deleteParticipantsByTransaction(transactionData.id);
          break;

        case TransactionType.transfer:
          break;
        case TransactionType.debtRepayment:
          break;
        case TransactionType.receive:
          await database.deleteFinancialObligationsByTransaction(
            transactionData.id,
          );

          await database.deleteParticipantsByTransaction(transactionData.id);
          break;

        case TransactionType.give:
          await database.deleteFinancialObligationsByTransaction(
            transactionData.id,
          );

          await database.deleteParticipantsByTransaction(transactionData.id);
          break;

        case TransactionType.balanceUpdate:
          break;
      }

      /// DELETE TRANSACTION
      await database.deleteTransaction(transactionData.id);
      if (billOccurrence != null) {
        await database.billsDao.unmarkOccurrenceAsPaid(billOccurrence.id);
      }

      /// REBUILD EVERY AFFECTED ACCOUNT
      for (final accountId in affectedAccountIds) {
        await database.accountsDao.rebuildAccountBalance(accountId);
      }
    });
  }
}
