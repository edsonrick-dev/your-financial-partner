import 'package:drift/drift.dart';

class CashflowCategoriesTable extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get icon => text()();
  TextColumn get type => text()();
  BoolColumn get isDefault => boolean().withDefault(const Constant(false))();
}
