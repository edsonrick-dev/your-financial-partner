import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/tables/credit_card_statements_table.dart';

import 'accounts_table.dart';
import 'cashflow_categories_table.dart';

class BillsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  /// Expense category associated with this bill.
  ///
  /// Null when the bill is associated with a financial account
  /// rather than an expense category.
  IntColumn get categoryId =>
      integer().nullable().references(CashflowCategoriesTable, #id)();

  /// Financial account associated with this bill.
  ///
  /// Used for account-linked bills such as loan repayments
  /// and credit-card statements.
  ///
  /// Null when this is a normal expense bill.
  IntColumn get accountId => integer().nullable().references(
    AccountsTable,
    #id,
    onDelete: KeyAction.cascade,
  )();

  /// The amount the user normally expects to pay.
  RealColumn get expectedAmount => real().nullable()();

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

  IntColumn get statementId => integer().nullable().unique().references(
    CreditCardStatementsTable,
    #id,
    onDelete: KeyAction.cascade,
  )();
}
