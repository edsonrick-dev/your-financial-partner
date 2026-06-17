// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transactions_dao.dart';

// ignore_for_file: type=lint
mixin _$TransactionsDaoMixin on DatabaseAccessor<AppDatabase> {
  $CashflowCategoriesTableTable get cashflowCategoriesTable =>
      attachedDatabase.cashflowCategoriesTable;
  $AccountsTableTable get accountsTable => attachedDatabase.accountsTable;
  $TransactionsTableTable get transactionsTable =>
      attachedDatabase.transactionsTable;
  $EntitiesTableTable get entitiesTable => attachedDatabase.entitiesTable;
  $TransactionParticipantsTableTable get transactionParticipantsTable =>
      attachedDatabase.transactionParticipantsTable;
  $FinancialObligationsTableTable get financialObligationsTable =>
      attachedDatabase.financialObligationsTable;
  TransactionsDaoManager get managers => TransactionsDaoManager(this);
}

class TransactionsDaoManager {
  final _$TransactionsDaoMixin _db;
  TransactionsDaoManager(this._db);
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
  $$EntitiesTableTableTableManager get entitiesTable =>
      $$EntitiesTableTableTableManager(_db.attachedDatabase, _db.entitiesTable);
  $$TransactionParticipantsTableTableTableManager
  get transactionParticipantsTable =>
      $$TransactionParticipantsTableTableTableManager(
        _db.attachedDatabase,
        _db.transactionParticipantsTable,
      );
  $$FinancialObligationsTableTableTableManager get financialObligationsTable =>
      $$FinancialObligationsTableTableTableManager(
        _db.attachedDatabase,
        _db.financialObligationsTable,
      );
}
