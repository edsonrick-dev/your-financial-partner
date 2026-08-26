import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/models/split_expense_summary.dart';
import 'package:getx_drift_app/data/models/transaction_participant_with_entity.dart';
import 'package:getx_drift_app/data/tables/transactions_table.dart';

class TransactionWithDetails {
  final TransactionsTableData transaction;

  final CashflowCategoriesTableData? category;

  final AccountsTableData? account;
  final AccountsTableData? linkedAccount;

  final List<TransactionParticipantWithEntity> participants;

  final String? obligationType;

  final SplitExpenseSummary? splitSummary;

  final List<FinancialObligationsTableData> obligations;

  TransactionWithDetails({
    required this.transaction,
    required this.category,
    required this.account,
    required this.obligations,
    this.participants = const [],
    this.splitSummary,
    this.linkedAccount,
    this.obligationType,
  });

  bool get isSharedExpense {
    return participants.length > 1;
  }

  bool get hasDebtImpact {
    return obligations.isNotEmpty;
  }

  bool get requiresAccount {
    switch (transaction.type) {
      case TransactionType.earn:
      case TransactionType.give:
      case TransactionType.receive:
      case TransactionType.transfer:
        return true;

      default:
        return false;
    }
  }
}
