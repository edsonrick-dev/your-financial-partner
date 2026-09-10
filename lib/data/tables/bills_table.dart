import 'package:drift/drift.dart';

import 'accounts_table.dart';
import 'cashflow_categories_table.dart';

class BillsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  /// Category paid by this bill.
  ///
  /// Null when this is a loan repayment.
  IntColumn get categoryId =>
      integer().nullable().references(CashflowCategoriesTable, #id)();

  /// Loan account paid by this bill.
  ///
  /// Null when this is a normal expense bill.
  IntColumn get loanAccountId =>
      integer().nullable().references(AccountsTable, #id)();

  /// The amount the user normally expects to pay.
  RealColumn get expectedAmount => real()();

  /// Recurrence frequency.
  TextColumn get frequency => text()();

  /// Day of month for monthly / quarterly / semi-annual / annual bills.
  IntColumn get dayOfMonth => integer().nullable()();

  /// Bitmask representing the selected MonthPattern.
  IntColumn get monthMask => integer().nullable()();

  BoolColumn get reminderEnabled =>
      boolean().withDefault(const Constant(false))();

  IntColumn get reminderDaysBefore => integer().nullable()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
