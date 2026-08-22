// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cashflow_plan_dao.dart';

// ignore_for_file: type=lint
mixin _$CashflowPlanDaoMixin on DatabaseAccessor<AppDatabase> {
  $CashflowCategoriesTableTable get cashflowCategoriesTable =>
      attachedDatabase.cashflowCategoriesTable;
  $AccountsTableTable get accountsTable => attachedDatabase.accountsTable;
  $LoansTable get loans => attachedDatabase.loans;
  $CashFlowPlansTable get cashFlowPlans => attachedDatabase.cashFlowPlans;
  $CashFlowPlanAllocationsTable get cashFlowPlanAllocations =>
      attachedDatabase.cashFlowPlanAllocations;
  CashflowPlanDaoManager get managers => CashflowPlanDaoManager(this);
}

class CashflowPlanDaoManager {
  final _$CashflowPlanDaoMixin _db;
  CashflowPlanDaoManager(this._db);
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
  $$CashFlowPlanAllocationsTableTableManager get cashFlowPlanAllocations =>
      $$CashFlowPlanAllocationsTableTableManager(
        _db.attachedDatabase,
        _db.cashFlowPlanAllocations,
      );
}
