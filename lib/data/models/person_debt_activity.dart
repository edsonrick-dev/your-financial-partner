import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';

class PersonDebtActivity {
  final FinancialObligationsTableData obligation;
  final TransactionsTableData transaction;
  final TransactionWithDetails? transactionDetails;
  final bool isReceivable;
  final double runningBalance;

  const PersonDebtActivity({
    required this.obligation,
    required this.transaction,
    this.transactionDetails,
    required this.isReceivable,
    required this.runningBalance,
  });

  TransactionType? get transactionType {
    return TransactionType.values.cast<TransactionType?>().firstWhere(
      (e) => e?.name == transaction.transactionType,
      orElse: () => null,
    );
  }

  String get title {
    return switch (transactionType) {
      TransactionType.give => 'Give Money',
      TransactionType.receive => 'Receive Money',
      _ => 'Debt Activity',
    };
  }

  String get iconKey {
    return switch (transactionType) {
      TransactionType.give => 'handDeposit',
      TransactionType.receive => 'handCoins',
      _ => 'usersThree',
    };
  }
}
