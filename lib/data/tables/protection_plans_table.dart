import 'package:drift/drift.dart';

class ProtectionPlansTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  DateTimeColumn get startDate => dateTime()();

  DateTimeColumn get endDate => dateTime()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();
}
