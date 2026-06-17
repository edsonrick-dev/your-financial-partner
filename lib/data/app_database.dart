import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:getx_drift_app/data/default_data/default_accounts.dart';
import 'package:getx_drift_app/data/default_data/default_categories.dart';
import 'package:getx_drift_app/data/enums/entity_type_enum.dart';
import 'package:getx_drift_app/data/models/cashflow_plan_model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'tables/cashflow_categories_table.dart';
import 'tables/accounts_table.dart';
import 'tables/transaction_participants_table.dart';
import 'tables/entities_table.dart';
import 'tables/transactions_table.dart';
import 'tables/financial_obligations_table.dart';
import 'tables/cashflow_plans_table.dart';

import 'package:getx_drift_app/data/database/daos/transactions_dao/transactions_dao.dart';
import 'package:getx_drift_app/data/database/daos/accounts_dao/accounts_dao.dart';
import 'package:getx_drift_app/data/database/daos/people_balance_dao/people_balance_dao.dart';
import 'package:getx_drift_app/data/database/daos/entities_dao/entities_dao.dart';

part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    CashflowCategoriesTable,
    AccountsTable,
    TransactionsTable,
    EntitiesTable,
    TransactionParticipantsTable,
    FinancialObligationsTable,
    CashflowPlansTable,
  ],
  daos: [TransactionsDao, AccountsDao, PeopleBalanceDao, EntitiesDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();

      await seedDefaultCategories();
      await seedDefaultPaymentAccounts();
      await seedDefaultEntities();
    },

    onUpgrade: (m, from, to) async {
      await m.deleteTable('financial_obligations_table');
      await m.deleteTable('transaction_participants_table');

      await m.createTable(financialObligationsTable);
      await m.createTable(transactionParticipantsTable);
    },
  );
  @override
  int get schemaVersion => 5;

  Future<List<CashFlowPlan>> getCashFlowPlans() async {
    final rows = await select(cashflowPlansTable).get();

    return rows.map((e) => e.toDomain()).toList();
  }

  Future<double> getTotalAccountValue() async {
    final accounts = await select(accountsTable).get();

    return accounts.fold<double>(
      0,
      (sum, account) => sum + account.currentValue,
    );
  }

  Future<CashflowCategoriesTableData?> getCategoryById(int id) {
    return (select(
      cashflowCategoriesTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  ///Transactions

  /// Low-level transaction deletion.
  ///
  /// Removes a transaction record from the database.
  ///
  /// WARNING:
  /// This function does NOT reverse account balances,
  /// remove financial impacts, or restore projections.
  ///
  /// Most application code should use
  /// deleteTransactionWithBalanceUpdate()
  /// instead.
  ///
  /// Intended for:
  /// • Internal DAO operations
  /// • Controlled cleanup flows
  /// • Transaction effect reversal workflows
  Future<void> deleteTransaction(int id) async {
    await (delete(transactionsTable)..where((tbl) => tbl.id.equals(id))).go();
  }

  ///PERSONS

  ///Accounts
  ///Cash Flows
  Future<int> insertCashflowCategory(CashflowCategoriesTableCompanion entry) {
    return into(cashflowCategoriesTable).insert(entry);
  }

  Future<List<CashflowCategoriesTableData>> getAllCashflowCategories() {
    return select(cashflowCategoriesTable).get();
  }

  Stream<List<CashflowCategoriesTableData>> watchCategoriesByType(String type) {
    return (select(
      cashflowCategoriesTable,
    )..where((tbl) => tbl.type.equals(type))).watch();
  }

  Future<List<CashflowCategoriesTableData>> getCategoriesByType(String type) {
    return (select(
      cashflowCategoriesTable,
    )..where((tbl) => tbl.type.equals(type))).get();
  }

  Future<void> seedDefaultCategories() async {
    final existing = await select(cashflowCategoriesTable).get();

    /// already seeded

    if (existing.isNotEmpty) return;

    /// convert default categories
    /// into drift companions

    final categories = DefaultCategories.all
        .map(
          (category) => CashflowCategoriesTableCompanion.insert(
            name: category.name,
            icon: category.iconKey,
            type: category.type,
          ),
        )
        .toList();

    /// batch insert

    await batch((batch) {
      batch.insertAll(cashflowCategoriesTable, categories);
    });
  }

  Future<void> seedDefaultEntities() async {
    final existing = await select(entitiesTable).get();

    if (existing.isNotEmpty) return;

    await into(entitiesTable).insert(
      EntitiesTableCompanion.insert(
        name: 'Me',
        entityType: EntityType.person.name,
      ),
    );
  }

  Future<void> seedDefaultPaymentAccounts() async {
    final existing = await select(accountsTable).get();

    if (existing.isNotEmpty) return;

    final accounts = DefaultAccounts.all
        .map(
          (account) => AccountsTableCompanion.insert(
            name: account.name,
            icon: account.iconKey,
            accountGroup: account.group,
            accountType: account.type,
          ),
        )
        .toList();

    await batch((batch) {
      batch.insertAll(accountsTable, accounts);
    });
  }

  Future<int> deleteFinancialObligationsByTransaction(int transactionId) {
    return (delete(
      financialObligationsTable,
    )..where((tbl) => tbl.transactionId.equals(transactionId))).go();
  }

  Future<void> deleteParticipantsByTransaction(int transactionId) {
    return (delete(
      transactionParticipantsTable,
    )..where((tbl) => tbl.transactionId.equals(transactionId))).go();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase(file);
  });
}
