import 'package:getx_drift_app/data/app_database.dart';

class PersonDebtActivity {
  final FinancialObligationsTableData obligation;

  final TransactionsTableData transaction;

  final bool isReceivable;

  final double runningBalance;

  const PersonDebtActivity({
    required this.obligation,
    required this.transaction,
    required this.isReceivable,
    required this.runningBalance,
  });
}
