import 'package:getx_drift_app/data/app_database.dart';

class BillWithNextOccurrence {
  final BillsTableData bill;
  final BillOccurrencesTableData occurrence;
  final CashflowCategoriesTableData? category;
  final AccountsTableData? loanAccount;

  const BillWithNextOccurrence({
    required this.bill,
    required this.occurrence,
    required this.category,
    required this.loanAccount,
  });

  bool get isLoanPayment => loanAccount != null;
}
