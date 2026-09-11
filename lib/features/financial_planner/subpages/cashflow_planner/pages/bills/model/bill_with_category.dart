import 'package:getx_drift_app/data/app_database.dart';

class BillWithCategory {
  final BillsTableData bill;
  final CashflowCategoriesTableData? category;
  final AccountsTableData? loanAccount;

  const BillWithCategory({
    required this.bill,
    required this.category,
    required this.loanAccount,
  });

  bool get isLoanPayment => loanAccount != null;
}
