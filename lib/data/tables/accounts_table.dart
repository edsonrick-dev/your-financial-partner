import 'package:drift/drift.dart';

class AccountsTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get icon => text()();
  TextColumn get accountGroup => text()();
  TextColumn get accountType => text()();
  RealColumn get currentValue => real().withDefault(const Constant(0))();
  BoolColumn get isSystem => boolean().withDefault(const Constant(false))();
}
