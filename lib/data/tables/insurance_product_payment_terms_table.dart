import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/tables/payment_terms_table.dart';
import 'insurance_products_table.dart';

@DataClassName('InsuranceProductPaymentTermRow')
class InsuranceProductPaymentTermsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get supabaseId => integer().nullable().unique()();

  IntColumn get productId => integer().references(
    InsuranceProductsTable,
    #id,
    onDelete: KeyAction.cascade,
  )();

  IntColumn get paymentTermId => integer().references(
    PaymentTermsTable,
    #id,
    onDelete: KeyAction.restrict,
  )();

  DateTimeColumn get createdAt => dateTime().nullable()();

  BoolColumn get isSynced => boolean().withDefault(const Constant(false))();

  @override
  List<Set<Column>> get uniqueKeys => [
    {productId, paymentTermId},
  ];
}
