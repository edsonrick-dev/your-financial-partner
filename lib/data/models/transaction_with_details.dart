import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/models/split_expense_summary.dart';
import 'package:getx_drift_app/data/models/transaction_participant_with_entity.dart';

class TransactionWithDetails {
  final TransactionsTableData transaction;

  final CashflowCategoriesTableData? category;

  final AccountsTableData? linkedAccount;
  final AccountsTableData account;
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

  //  bool get hasDebtImpact => obligationType != null;
  bool get hasDebtImpact => obligations.isNotEmpty;
}
