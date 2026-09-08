import 'package:getx_drift_app/data/app_database.dart';

class BillWithNextOccurrence {
  final BillsTableData bill;
  final BillOccurrencesTableData occurrence;
  final CashflowCategoriesTableData category;

  const BillWithNextOccurrence({
    required this.bill,
    required this.occurrence,
    required this.category,
  });
}
