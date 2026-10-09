import 'package:drift/drift.dart';

class ProtectionDependencyTable extends Table {
  IntColumn get id => integer()();

  TextColumn get dependencyType => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
