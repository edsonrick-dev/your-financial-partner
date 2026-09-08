import 'package:drift/drift.dart';

import 'cashflow_categories_table.dart';

class BillsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  IntColumn get categoryId =>
      integer().references(CashflowCategoriesTable, #id)();

  /// The amount the user normally expects to pay.
  RealColumn get expectedAmount => real()();

  /// BillsFrequency.name
  TextColumn get frequency => text()();

  /// Day of month for monthly / quarterly / semi-annual / annual bills.
  IntColumn get dayOfMonth => integer().nullable()();

  /// Bitmask representing the selected MonthPattern.
  ///
  /// Example:
  /// Jan + Jul = bits 1 and 7.
  IntColumn get monthMask => integer().nullable()();

  BoolColumn get reminderEnabled =>
      boolean().withDefault(const Constant(false))();

  IntColumn get reminderDaysBefore => integer().nullable()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
