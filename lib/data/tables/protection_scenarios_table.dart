import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/tables/user_profile_table.dart';

class ProtectionScenariosTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get protectionType => text()();

  TextColumn get horizon => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {protectionType},
  ];
}
