// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'protection_dao.dart';

// ignore_for_file: type=lint
mixin _$ProtectionDaoMixin on DatabaseAccessor<AppDatabase> {
  $ProtectionScenariosTableTable get protectionScenariosTable =>
      attachedDatabase.protectionScenariosTable;
  $CashflowCategoriesTableTable get cashflowCategoriesTable =>
      attachedDatabase.cashflowCategoriesTable;
  $AccountsTableTable get accountsTable => attachedDatabase.accountsTable;
  $LoansTable get loans => attachedDatabase.loans;
  $CashFlowPlansTable get cashFlowPlans => attachedDatabase.cashFlowPlans;
  $ProtectionBudgetContinuitiesTable get protectionBudgetContinuities =>
      attachedDatabase.protectionBudgetContinuities;
  $ProtectionDependencyTableTable get protectionDependencyTable =>
      attachedDatabase.protectionDependencyTable;
  ProtectionDaoManager get managers => ProtectionDaoManager(this);
}

class ProtectionDaoManager {
  final _$ProtectionDaoMixin _db;
  ProtectionDaoManager(this._db);
  $$ProtectionScenariosTableTableTableManager get protectionScenariosTable =>
      $$ProtectionScenariosTableTableTableManager(
        _db.attachedDatabase,
        _db.protectionScenariosTable,
      );
  $$CashflowCategoriesTableTableTableManager get cashflowCategoriesTable =>
      $$CashflowCategoriesTableTableTableManager(
        _db.attachedDatabase,
        _db.cashflowCategoriesTable,
      );
  $$AccountsTableTableTableManager get accountsTable =>
      $$AccountsTableTableTableManager(_db.attachedDatabase, _db.accountsTable);
  $$LoansTableTableManager get loans =>
      $$LoansTableTableManager(_db.attachedDatabase, _db.loans);
  $$CashFlowPlansTableTableManager get cashFlowPlans =>
      $$CashFlowPlansTableTableManager(_db.attachedDatabase, _db.cashFlowPlans);
  $$ProtectionBudgetContinuitiesTableTableManager
  get protectionBudgetContinuities =>
      $$ProtectionBudgetContinuitiesTableTableManager(
        _db.attachedDatabase,
        _db.protectionBudgetContinuities,
      );
  $$ProtectionDependencyTableTableTableManager get protectionDependencyTable =>
      $$ProtectionDependencyTableTableTableManager(
        _db.attachedDatabase,
        _db.protectionDependencyTable,
      );
}
