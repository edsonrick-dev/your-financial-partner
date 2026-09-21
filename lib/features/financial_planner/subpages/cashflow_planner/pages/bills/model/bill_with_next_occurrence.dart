import 'package:getx_drift_app/data/app_database.dart';

class BillWithNextOccurrence {
  final BillsTableData bill;
  final BillOccurrencesTableData occurrence;
  final CashflowCategoriesTableData? category;
  final AccountsTableData? loanAccount;
  final TransactionsTableData? paymentTransaction;

  // final bool isPaid;

  const BillWithNextOccurrence({
    required this.bill,
    required this.occurrence,
    required this.category,
    required this.loanAccount,
    this.paymentTransaction,
    // required this.isPaid,
  });
  bool get isPaid => occurrence.isPaid;
  bool get isLoanPayment => loanAccount != null;
  DateTime? get paidDate => paymentTransaction?.date;
}
