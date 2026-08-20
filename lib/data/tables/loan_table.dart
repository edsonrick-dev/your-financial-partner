import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/tables/accounts_table.dart';

class Loans extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get loanType => text()();

  RealColumn get originalPrincipal => real()();

  RealColumn get outstandingBalance => real()();

  RealColumn get interestRate => real().nullable()();

  RealColumn get paymentAmount => real()();

  TextColumn get paymentFrequency => text()();

  DateTimeColumn get startDate => dateTime()();

  DateTimeColumn get maturityDate => dateTime().nullable()();

  IntColumn get defaultPaymentAccountId =>
      integer().nullable().references(AccountsTable, #id)();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();
}
