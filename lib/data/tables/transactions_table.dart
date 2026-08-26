import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/tables/accounts_table.dart';
import 'package:getx_drift_app/data/tables/cashflow_categories_table.dart';

class TransactionsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  RealColumn get amount => real()();

  DateTimeColumn get date => dateTime()(); //When the transaction happened

  TextColumn get note => text().nullable()();

  TextColumn get transactionType => text()();

  IntColumn get categoryId =>
      integer().nullable().references(CashflowCategoriesTable, #id)();

  IntColumn get accountId =>
      integer().nullable().references(AccountsTable, #id)();
  IntColumn get linkedAccountId =>
      integer().nullable().references(AccountsTable, #id)();

  DateTimeColumn get createdAt => dateTime().withDefault(
    currentDateAndTime,
  )(); //When the record was created
  DateTimeColumn get updatedAt => dateTime().withDefault(
    currentDateAndTime,
  )(); //Last modification timestamp
}

extension TransactionDataX on TransactionsTableData {
  TransactionType get type => TransactionType.fromName(transactionType);
}
