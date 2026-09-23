import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/tables/credit_card_billings_table.dart';

class CreditCardStatementsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get billingPeriodId => integer().references(
    CreditCardBillingPeriodsTable,
    #id,
    onDelete: KeyAction.cascade,
  )();

  RealColumn get statementBalance => real()();

  DateTimeColumn get paymentDueDate => dateTime()();

  DateTimeColumn get generatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  TextColumn get status => text()();
}

enum CreditCardStatementStatus { unpaid, partiallyPaid, paid, carriedForward }
