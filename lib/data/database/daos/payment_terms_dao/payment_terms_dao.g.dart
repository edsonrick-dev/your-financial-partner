// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_terms_dao.dart';

// ignore_for_file: type=lint
mixin _$PaymentTermsDaoMixin on DatabaseAccessor<AppDatabase> {
  $PaymentTermsTableTable get paymentTermsTable =>
      attachedDatabase.paymentTermsTable;
  $EntitiesTableTable get entitiesTable => attachedDatabase.entitiesTable;
  $InsuranceProductsTableTable get insuranceProductsTable =>
      attachedDatabase.insuranceProductsTable;
  $InsuranceProductPaymentTermsTableTable
  get insuranceProductPaymentTermsTable =>
      attachedDatabase.insuranceProductPaymentTermsTable;
  PaymentTermsDaoManager get managers => PaymentTermsDaoManager(this);
}

class PaymentTermsDaoManager {
  final _$PaymentTermsDaoMixin _db;
  PaymentTermsDaoManager(this._db);
  $$PaymentTermsTableTableTableManager get paymentTermsTable =>
      $$PaymentTermsTableTableTableManager(
        _db.attachedDatabase,
        _db.paymentTermsTable,
      );
  $$EntitiesTableTableTableManager get entitiesTable =>
      $$EntitiesTableTableTableManager(_db.attachedDatabase, _db.entitiesTable);
  $$InsuranceProductsTableTableTableManager get insuranceProductsTable =>
      $$InsuranceProductsTableTableTableManager(
        _db.attachedDatabase,
        _db.insuranceProductsTable,
      );
  $$InsuranceProductPaymentTermsTableTableTableManager
  get insuranceProductPaymentTermsTable =>
      $$InsuranceProductPaymentTermsTableTableTableManager(
        _db.attachedDatabase,
        _db.insuranceProductPaymentTermsTable,
      );
}
