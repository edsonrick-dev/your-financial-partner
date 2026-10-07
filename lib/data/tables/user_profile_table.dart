import 'package:drift/drift.dart';

class UserProfileTable extends Table {
  IntColumn get id => integer()();

  TextColumn get name => text().nullable()();

  DateTimeColumn get birthday => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
