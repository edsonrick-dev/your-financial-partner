import 'package:drift/drift.dart';

class ProtectionScenariosTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get protectionType => text()();

  TextColumn get horizon => text().nullable()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {protectionType},
  ];
}
