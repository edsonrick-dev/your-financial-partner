import 'package:drift/drift.dart';

import 'accounts_table.dart';

class CreditCardBillingPeriodsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get accountId =>
      integer().references(AccountsTable, #id, onDelete: KeyAction.cascade)();

  DateTimeColumn get startDate => dateTime()();

  DateTimeColumn get endDate => dateTime()();

  TextColumn get status => text()();
}

enum CreditCardBillingPeriodStatus { open, closed }
