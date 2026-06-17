import 'package:drift/drift.dart';

class EntitiesTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  TextColumn get displayName => text().nullable()();

  TextColumn get shortCode => text().nullable()();

  TextColumn get entityType => text()();

  TextColumn get organizationType => text().nullable()();

  BoolColumn get isSystem => boolean().withDefault(const Constant(false))();

  TextColumn get iconKey => text().nullable()();

  TextColumn get contactNumber => text().nullable()();

  TextColumn get emailAddress => text().nullable()();

  TextColumn get metadata => text().nullable()();
}
