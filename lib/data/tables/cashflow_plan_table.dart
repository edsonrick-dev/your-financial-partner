import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/tables/cashflow_categories_table.dart';
import 'package:getx_drift_app/data/tables/loan_table.dart';

class CashFlowPlans extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get categoryId =>
      integer().nullable().references(CashflowCategoriesTable, #id)();

  IntColumn get loanId => integer().nullable().references(Loans, #id)();

  TextColumn get planType => text()();

  RealColumn get amount => real()();

  TextColumn get period => text()();

  TextColumn get distributionType => text()();

  DateTimeColumn get startDate => dateTime()();

  DateTimeColumn get endDate => dateTime().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();
}
