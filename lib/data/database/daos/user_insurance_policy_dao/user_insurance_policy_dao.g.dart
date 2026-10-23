// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_insurance_policy_dao.dart';

// ignore_for_file: type=lint
mixin _$UserInsurancePolicyDaoMixin on DatabaseAccessor<AppDatabase> {
  $UserInsurancePolicyTableTable get userInsurancePolicyTable =>
      attachedDatabase.userInsurancePolicyTable;
  $PremiumDetailsTableTable get premiumDetailsTable =>
      attachedDatabase.premiumDetailsTable;
  $EntitiesTableTable get entitiesTable => attachedDatabase.entitiesTable;
  $InsuranceProductsTableTable get insuranceProductsTable =>
      attachedDatabase.insuranceProductsTable;
  $InsuranceBenefitsTableTable get insuranceBenefitsTable =>
      attachedDatabase.insuranceBenefitsTable;
  $UserInsuranceBenefitsTableTable get userInsuranceBenefitsTable =>
      attachedDatabase.userInsuranceBenefitsTable;
  UserInsurancePolicyDaoManager get managers =>
      UserInsurancePolicyDaoManager(this);
}

class UserInsurancePolicyDaoManager {
  final _$UserInsurancePolicyDaoMixin _db;
  UserInsurancePolicyDaoManager(this._db);
  $$UserInsurancePolicyTableTableTableManager get userInsurancePolicyTable =>
      $$UserInsurancePolicyTableTableTableManager(
        _db.attachedDatabase,
        _db.userInsurancePolicyTable,
      );
  $$PremiumDetailsTableTableTableManager get premiumDetailsTable =>
      $$PremiumDetailsTableTableTableManager(
        _db.attachedDatabase,
        _db.premiumDetailsTable,
      );
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
  $$UserInsuranceBenefitsTableTableTableManager
  get userInsuranceBenefitsTable =>
      $$UserInsuranceBenefitsTableTableTableManager(
        _db.attachedDatabase,
        _db.userInsuranceBenefitsTable,
      );
}
