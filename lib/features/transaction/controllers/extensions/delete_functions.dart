import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/tables/transactions_table.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';

extension DeleteFunctions on TransactionController {
  Future<void> deleteTransaction(TransactionWithDetails item) async {
    await database.transaction(() async {
      final transactionData = item.transaction;

      /// KEEP TRACK OF ALL ACCOUNTS AFFECTED
      final affectedAccountIds = <int>{transactionData.accountId};

      /// TRANSFERS AFFECT TWO ACCOUNTS
      if (transactionData.type == TransactionType.transfer) {
        final linkedAccountId = transactionData.linkedAccountId;

        if (linkedAccountId == null) {
          throw Exception('Transfer transaction missing linked account.');
        }

        affectedAccountIds.add(linkedAccountId);
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

      /// REBUILD EVERY AFFECTED ACCOUNT
      for (final accountId in affectedAccountIds) {
        await database.accountsDao.rebuildAccountBalance(accountId);
      }
    });
  }
}
