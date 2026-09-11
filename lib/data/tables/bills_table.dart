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

  /// Anchor day used to calculate recurring occurrences.
  ///
  /// For example, a bill created for the 31st remains anchored
  /// to the 31st even when an intermediate month has fewer days.
  IntColumn get dayOfMonth => integer().nullable()();

  BoolColumn get reminderEnabled =>
      boolean().withDefault(const Constant(false))();

  IntColumn get reminderDaysBefore => integer().nullable()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
