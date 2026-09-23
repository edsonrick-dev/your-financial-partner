// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'credit_card_dao.dart';

// ignore_for_file: type=lint
mixin _$CreditCardDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountsTableTable get accountsTable => attachedDatabase.accountsTable;
  $CreditCardDetailsTableTable get creditCardDetailsTable =>
      attachedDatabase.creditCardDetailsTable;
  $CreditCardBillingPeriodsTableTable get creditCardBillingPeriodsTable =>
      attachedDatabase.creditCardBillingPeriodsTable;
  $CreditCardStatementsTableTable get creditCardStatementsTable =>
      attachedDatabase.creditCardStatementsTable;
  $CashflowCategoriesTableTable get cashflowCategoriesTable =>
      attachedDatabase.cashflowCategoriesTable;
  $TransactionsTableTable get transactionsTable =>
      attachedDatabase.transactionsTable;
  CreditCardDaoManager get managers => CreditCardDaoManager(this);
}

class CreditCardDaoManager {
  final _$CreditCardDaoMixin _db;
  CreditCardDaoManager(this._db);
  $$AccountsTableTableTableManager get accountsTable =>
      $$AccountsTableTableTableManager(_db.attachedDatabase, _db.accountsTable);
  $$CreditCardDetailsTableTableTableManager get creditCardDetailsTable =>
      $$CreditCardDetailsTableTableTableManager(
        _db.attachedDatabase,
        _db.creditCardDetailsTable,
      );
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
  $$CashflowCategoriesTableTableTableManager get cashflowCategoriesTable =>
      $$CashflowCategoriesTableTableTableManager(
        _db.attachedDatabase,
        _db.cashflowCategoriesTable,
      );
  $$TransactionsTableTableTableManager get transactionsTable =>
      $$TransactionsTableTableTableManager(
        _db.attachedDatabase,
        _db.transactionsTable,
      );
}
