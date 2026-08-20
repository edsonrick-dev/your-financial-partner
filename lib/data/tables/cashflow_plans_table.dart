// import 'package:drift/drift.dart';
// import 'package:getx_drift_app/data/tables/cashflow_categories_table.dart';

// class CashflowPlansTable extends Table {
//   IntColumn get id => integer().autoIncrement()();

//   TextColumn get name => text()();

//   TextColumn get planType => text()();

//   TextColumn get expenseMode => text().nullable()();

//   IntColumn get categoryId =>
//       integer().nullable().references(CashflowCategoriesTable, #id)();

//   IntColumn get debtId => integer().nullable()();

//   RealColumn get amount => real().nullable()();

//   TextColumn get customAmountsJson => text().nullable()();

//   TextColumn get frequency => text()();

//   // IntColumn get monthMask => integer().nullable()();

//   // TextColumn get occurrenceDaysJson => text().nullable()();

//   DateTimeColumn get anchorDate => dateTime().nullable()();

//   // RealColumn get dependentSurvivalFactor =>
//   //     real().withDefault(const Constant(0))();

//   DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

//   DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
// }
