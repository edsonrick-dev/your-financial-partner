import 'package:drift/drift.dart';
import 'protection_plans_table.dart';

class ProtectionPlanContinuitySharesTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get protectionPlanId => integer().references(
    ProtectionPlansTable,
    #id,
    onDelete: KeyAction.cascade,
  )();

  TextColumn get protectionType => text()();

  RealColumn get continuityShare => real()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {protectionPlanId, protectionType},
  ];
}
