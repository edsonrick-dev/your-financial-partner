import 'package:drift/drift.dart';

import 'bills_table.dart';
import 'transactions_table.dart';

class BillOccurrencesTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get billId => integer().references(BillsTable, #id)();

  DateTimeColumn get dueDate => dateTime()();

  /// Snapshot of the expected amount when this occurrence was created.
  RealColumn get expectedAmount => real()();

  /// Actual amount paid.
  ///
  /// Null until the bill is paid.
  RealColumn get actualAmount => real().nullable()();

  BoolColumn get isPaid => boolean().withDefault(const Constant(false))();

  /// Set when the occurrence is converted into a transaction.
  IntColumn get transactionId =>
      integer().nullable().references(TransactionsTable, #id)();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
