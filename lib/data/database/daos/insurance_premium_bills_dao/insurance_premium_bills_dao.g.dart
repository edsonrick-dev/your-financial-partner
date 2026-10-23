// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'insurance_premium_bills_dao.dart';

// ignore_for_file: type=lint
mixin _$InsurancePremiumBillsDaoMixin on DatabaseAccessor<AppDatabase> {
  $UserInsurancePolicyTableTable get userInsurancePolicyTable =>
      attachedDatabase.userInsurancePolicyTable;
  $CashflowCategoriesTableTable get cashflowCategoriesTable =>
      attachedDatabase.cashflowCategoriesTable;
  $AccountsTableTable get accountsTable => attachedDatabase.accountsTable;
  $CreditCardBillingPeriodsTableTable get creditCardBillingPeriodsTable =>
      attachedDatabase.creditCardBillingPeriodsTable;
  $CreditCardStatementsTableTable get creditCardStatementsTable =>
      attachedDatabase.creditCardStatementsTable;
  $BillsTableTable get billsTable => attachedDatabase.billsTable;
  $InsurancePremiumBillsTableTable get insurancePremiumBillsTable =>
      attachedDatabase.insurancePremiumBillsTable;
  InsurancePremiumBillsDaoManager get managers =>
      InsurancePremiumBillsDaoManager(this);
}

class InsurancePremiumBillsDaoManager {
  final _$InsurancePremiumBillsDaoMixin _db;
  InsurancePremiumBillsDaoManager(this._db);
  $$UserInsurancePolicyTableTableTableManager get userInsurancePolicyTable =>
      $$UserInsurancePolicyTableTableTableManager(
        _db.attachedDatabase,
        _db.userInsurancePolicyTable,
      );
  $$CashflowCategoriesTableTableTableManager get cashflowCategoriesTable =>
      $$CashflowCategoriesTableTableTableManager(
        _db.attachedDatabase,
        _db.cashflowCategoriesTable,
      );
  $$AccountsTableTableTableManager get accountsTable =>
      $$AccountsTableTableTableManager(_db.attachedDatabase, _db.accountsTable);
  $$CreditCardBillingPeriodsTableTableTableManager
  get creditCardBillingPeriodsTable =>
      $$CreditCardBillingPeriodsTableTableTableManager(
        _db.attachedDatabase,
        _db.creditCardBillingPeriodsTable,
      );
  $$CreditCardStatementsTableTableTableManager get creditCardStatementsTable =>
      $$CreditCardStatementsTableTableTableManager(
        _db.attachedDatabase,
        _db.creditCardStatementsTable,
      );
  $$BillsTableTableTableManager get billsTable =>
      $$BillsTableTableTableManager(_db.attachedDatabase, _db.billsTable);
  $$InsurancePremiumBillsTableTableTableManager
  get insurancePremiumBillsTable =>
      $$InsurancePremiumBillsTableTableTableManager(
        _db.attachedDatabase,
        _db.insurancePremiumBillsTable,
      );
}
