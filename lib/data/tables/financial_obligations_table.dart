import 'package:drift/drift.dart';
import 'transactions_table.dart';
import 'entities_table.dart';

class FinancialObligationsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get transactionId => integer().references(
    TransactionsTable,
    #id,
    onDelete: KeyAction.cascade,
  )();

  IntColumn get debtorEntityId =>
      integer().references(EntitiesTable, #id, onDelete: KeyAction.cascade)();

  IntColumn get creditorEntityId =>
      integer().references(EntitiesTable, #id, onDelete: KeyAction.cascade)();
  RealColumn get amount => real()();

  TextColumn get type => text()();

  TextColumn get note => text().nullable()();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
