// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_balance_dao.dart';

// ignore_for_file: type=lint
mixin _$PeopleBalanceDaoMixin on DatabaseAccessor<AppDatabase> {
  $EntitiesTableTable get entitiesTable => attachedDatabase.entitiesTable;
  $CashflowCategoriesTableTable get cashflowCategoriesTable =>
      attachedDatabase.cashflowCategoriesTable;
  $AccountsTableTable get accountsTable => attachedDatabase.accountsTable;
  $TransactionsTableTable get transactionsTable =>
      attachedDatabase.transactionsTable;
  $FinancialObligationsTableTable get financialObligationsTable =>
      attachedDatabase.financialObligationsTable;
  PeopleBalanceDaoManager get managers => PeopleBalanceDaoManager(this);
}

class PeopleBalanceDaoManager {
  final _$PeopleBalanceDaoMixin _db;
  PeopleBalanceDaoManager(this._db);
  $$EntitiesTableTableTableManager get entitiesTable =>
      $$EntitiesTableTableTableManager(_db.attachedDatabase, _db.entitiesTable);
  $$CashflowCategoriesTableTableTableManager get cashflowCategoriesTable =>
      $$CashflowCategoriesTableTableTableManager(
        _db.attachedDatabase,
        _db.cashflowCategoriesTable,
      );
  $$AccountsTableTableTableManager get accountsTable =>
      $$AccountsTableTableTableManager(_db.attachedDatabase, _db.accountsTable);
  $$TransactionsTableTableTableManager get transactionsTable =>
      $$TransactionsTableTableTableManager(
        _db.attachedDatabase,
        _db.transactionsTable,
      );
  $$FinancialObligationsTableTableTableManager get financialObligationsTable =>
      $$FinancialObligationsTableTableTableManager(
        _db.attachedDatabase,
        _db.financialObligationsTable,
      );
}
