import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/tables/accounts_table.dart';

class CreditCardDetailsTable extends Table {
  IntColumn get accountId =>
      integer().references(AccountsTable, #id, onDelete: KeyAction.cascade)();

  /// Recurring statement closing day.
  ///
  /// 1–31. If the month does not contain this day,
  /// the last valid day of the month is used.
  IntColumn get statementDay => integer()();

  /// Recurring payment due day.
  ///
  /// 1–31. If the month does not contain this day,
  /// the last valid day of the month is used.
  IntColumn get paymentDueDay => integer()();

  /// Next concrete statement closing date.
  DateTimeColumn get nextStatementDate => dateTime()();

  /// Next concrete payment due date associated with
  /// the next statement.
  DateTimeColumn get nextPaymentDueDate => dateTime()();

  RealColumn get creditLimit => real()();

  @override
  Set<Column> get primaryKey => {accountId};
}
