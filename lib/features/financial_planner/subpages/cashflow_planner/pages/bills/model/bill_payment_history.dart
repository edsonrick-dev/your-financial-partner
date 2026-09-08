import 'package:getx_drift_app/data/app_database.dart';

class BillPaymentHistory {
  final BillOccurrencesTableData occurrence;
  final TransactionsTableData transaction;

  const BillPaymentHistory({
    required this.occurrence,
    required this.transaction,
  });
}
