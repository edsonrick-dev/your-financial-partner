import 'package:drift/drift.dart';
import 'protection_needs_table.dart';

class ExpenseContinuityTable extends Table {
  IntColumn get protectionNeedId => integer().references(
    ProtectionNeedsTable,
    #id,
    onDelete: KeyAction.cascade,
  )();

  IntColumn get protectionHorizon => integer()();

  RealColumn get monthlyExpense => real()();

  IntColumn get planValidityYears => integer()();

  RealColumn get investedNeed => real()();

  RealColumn get uninvestedNeed => real()();

  IntColumn get calculationVersion => integer()();

  DateTimeColumn get calculatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {protectionNeedId};
}
