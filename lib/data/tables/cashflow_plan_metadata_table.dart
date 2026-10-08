import 'package:drift/drift.dart';

class CashflowPlanMetadata extends Table {
  IntColumn get id => integer()();

  IntColumn get revision =>
      integer().withDefault(const Constant(0))();

  DateTimeColumn get updatedAt =>
      dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {id};
}