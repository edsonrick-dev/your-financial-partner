import 'package:drift/drift.dart';

import 'insurance_products_table.dart';

class InsuranceBenefitsTable extends Table {
  // Local Drift primary key.
  IntColumn get id => integer().autoIncrement()();

  // Remote Supabase product_benefits.id.
  IntColumn get supabaseId => integer().nullable().unique()();

  // Local InsuranceProductsTable.id.
  IntColumn get productId =>
      integer().references(InsuranceProductsTable, #id)();

  // BenefitType enum serialized as text locally.
  TextColumn get benefitType => text()();

  TextColumn get name => text().nullable()();

  TextColumn get description => text().nullable()();

  BoolColumn get isRequired => boolean().withDefault(const Constant(false))();

  // Local sync status; not a Supabase catalog field.
  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
