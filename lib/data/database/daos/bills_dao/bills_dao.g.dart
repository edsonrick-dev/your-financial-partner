// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bills_dao.dart';

// ignore_for_file: type=lint
mixin _$BillsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CashflowCategoriesTableTable get cashflowCategoriesTable =>
      attachedDatabase.cashflowCategoriesTable;
  $BillsTableTable get billsTable => attachedDatabase.billsTable;
  $AccountsTableTable get accountsTable => attachedDatabase.accountsTable;
  $TransactionsTableTable get transactionsTable =>
      attachedDatabase.transactionsTable;
  $BillOccurrencesTableTable get billOccurrencesTable =>
      attachedDatabase.billOccurrencesTable;
  BillsDaoManager get managers => BillsDaoManager(this);
}

class BillsDaoManager {
  final _$BillsDaoMixin _db;
  BillsDaoManager(this._db);
  $$CashflowCategoriesTableTableTableManager get cashflowCategoriesTable =>
      $$CashflowCategoriesTableTableTableManager(
        _db.attachedDatabase,
        _db.cashflowCategoriesTable,
      );
  $$BillsTableTableTableManager get billsTable =>
      $$BillsTableTableTableManager(_db.attachedDatabase, _db.billsTable);
  $$AccountsTableTableTableManager get accountsTable =>
      $$AccountsTableTableTableManager(_db.attachedDatabase, _db.accountsTable);
  $$TransactionsTableTableTableManager get transactionsTable =>
      $$TransactionsTableTableTableManager(
        _db.attachedDatabase,
        _db.transactionsTable,
      );
  $$BillOccurrencesTableTableTableManager get billOccurrencesTable =>
      $$BillOccurrencesTableTableTableManager(
        _db.attachedDatabase,
        _db.billOccurrencesTable,
      );
}
