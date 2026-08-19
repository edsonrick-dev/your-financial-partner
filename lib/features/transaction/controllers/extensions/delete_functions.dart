import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/tables/transactions_table.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';

extension DeleteFunctions on TransactionController {
  Future<void> deleteTransaction(TransactionWithDetails item) async {
    await database.transaction(() async {
      final transactionData = item.transaction;
      final linkedAccount = item.linkedAccount;

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
          if (linkedAccount == null) {
            throw Exception('Transfer transaction missing linked account.');
          }
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

      await database.deleteTransaction(transactionData.id);
      await database.accountsDao.rebuildAccountBalance(
        transactionData.accountId,
      );
    });
  }
}
