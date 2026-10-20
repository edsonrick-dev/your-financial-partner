import 'package:drift/drift.dart';

import 'entities_table.dart';

class InsuranceProductsTable extends Table {
  // Local Drift primary key.
  IntColumn get id => integer().autoIncrement()();

  // Remote Supabase insurance_policies.id.
  IntColumn get supabaseId => integer().nullable().unique()();

  // Local EntitiesTable.id.
  IntColumn get insurerId => integer().references(EntitiesTable, #id)();

  TextColumn get name => text()();

  TextColumn get shortName => text().nullable()();

  TextColumn get description => text().nullable()();

  BoolColumn get isUserGenerated =>
      boolean().withDefault(const Constant(false))();

  IntColumn get minAge => integer().nullable()();

  IntColumn get maxAge => integer().nullable()();

  TextColumn get note => text().nullable()();

  // Supabase auth.users UUID; null before sign-in/sync.
  TextColumn get createdByUserId => text().nullable()();

  // Local sync status, not a Supabase catalog field.
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
