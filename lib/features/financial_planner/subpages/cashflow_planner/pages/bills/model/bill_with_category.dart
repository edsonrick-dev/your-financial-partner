import 'package:getx_drift_app/data/app_database.dart';

class BillWithCategory {
  final BillsTableData bill;
  final CashflowCategoriesTableData? category;
  final AccountsTableData? loanAccount;
  final DateTime? nextDueDate;
  final bool isInsurancePremium;

  const BillWithCategory({
    required this.bill,
    required this.category,
    required this.loanAccount,
    this.nextDueDate,
    this.isInsurancePremium = false,
  });

  bool get isLoanPayment => loanAccount != null;
}
