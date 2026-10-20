// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_product_payment_terms_dao.dart';

// ignore_for_file: type=lint
mixin _$InsuranceProductPaymentTermsDaoMixin on DatabaseAccessor<AppDatabase> {
  $EntitiesTableTable get entitiesTable => attachedDatabase.entitiesTable;
  $InsuranceProductsTableTable get insuranceProductsTable =>
      attachedDatabase.insuranceProductsTable;
  $PaymentTermsTableTable get paymentTermsTable =>
      attachedDatabase.paymentTermsTable;
  $InsuranceProductPaymentTermsTableTable
  get insuranceProductPaymentTermsTable =>
      attachedDatabase.insuranceProductPaymentTermsTable;
  InsuranceProductPaymentTermsDaoManager get managers =>
      InsuranceProductPaymentTermsDaoManager(this);
}

class InsuranceProductPaymentTermsDaoManager {
  final _$InsuranceProductPaymentTermsDaoMixin _db;
  InsuranceProductPaymentTermsDaoManager(this._db);
  $$EntitiesTableTableTableManager get entitiesTable =>
      $$EntitiesTableTableTableManager(_db.attachedDatabase, _db.entitiesTable);
  $$InsuranceProductsTableTableTableManager get insuranceProductsTable =>
      $$InsuranceProductsTableTableTableManager(
        _db.attachedDatabase,
        _db.insuranceProductsTable,
      );
  $$PaymentTermsTableTableTableManager get paymentTermsTable =>
      $$PaymentTermsTableTableTableManager(
        _db.attachedDatabase,
        _db.paymentTermsTable,
      );
  $$InsuranceProductPaymentTermsTableTableTableManager
  get insuranceProductPaymentTermsTable =>
      $$InsuranceProductPaymentTermsTableTableTableManager(
        _db.attachedDatabase,
        _db.insuranceProductPaymentTermsTable,
      );
}
