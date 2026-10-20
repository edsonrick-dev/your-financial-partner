// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_policies_dao.dart';

// ignore_for_file: type=lint
mixin _$InsurancePoliciesDaoMixin on DatabaseAccessor<AppDatabase> {
  $EntitiesTableTable get entitiesTable => attachedDatabase.entitiesTable;
  $InsuranceProductsTableTable get insuranceProductsTable =>
      attachedDatabase.insuranceProductsTable;
  $InsuranceBenefitsTableTable get insuranceBenefitsTable =>
      attachedDatabase.insuranceBenefitsTable;
  InsurancePoliciesDaoManager get managers => InsurancePoliciesDaoManager(this);
}

class InsurancePoliciesDaoManager {
  final _$InsurancePoliciesDaoMixin _db;
  InsurancePoliciesDaoManager(this._db);
  $$EntitiesTableTableTableManager get entitiesTable =>
      $$EntitiesTableTableTableManager(_db.attachedDatabase, _db.entitiesTable);
  $$InsuranceProductsTableTableTableManager get insuranceProductsTable =>
      $$InsuranceProductsTableTableTableManager(
        _db.attachedDatabase,
        _db.insuranceProductsTable,
      );
  $$InsuranceBenefitsTableTableTableManager get insuranceBenefitsTable =>
      $$InsuranceBenefitsTableTableTableManager(
        _db.attachedDatabase,
        _db.insuranceBenefitsTable,
      );
}
