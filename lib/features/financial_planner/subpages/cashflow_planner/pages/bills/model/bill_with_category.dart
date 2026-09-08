import 'package:getx_drift_app/data/app_database.dart';

class BillWithCategory {
  final BillsTableData bill;
  final CashflowCategoriesTableData category;

  const BillWithCategory({required this.bill, required this.category});
}
