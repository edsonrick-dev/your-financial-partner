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
      // await seedDefaultTransactions();
    },

    onUpgrade: (m, from, to) async {
      if (from < 6) {
        await m.deleteTable('financial_obligations_table');
        await m.deleteTable('transaction_participants_table');

        await m.createTable(financialObligationsTable);
        await m.createTable(transactionParticipantsTable);
      }

      if (from < 7) {
        await m.addColumn(accountsTable, accountsTable.creditLimit);
      }
    },
  );
  @override
  int get schemaVersion => 8;

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

  // Future<void> seedDefaultTransactions() async {
  //   final existing = await select(transactionsTable).get();

  //   if (existing.isNotEmpty) return;

  //   // ------------------------------------------------------------
  //   // GET SEEDED REFERENCES
  //   // ------------------------------------------------------------

  //   final accounts = await select(accountsTable).get();
  //   final categories = await select(cashflowCategoriesTable).get();
  //   final entities = await select(entitiesTable).get();

  //   // Resolve records by their seed names.
  //   final accountByName = {
  //     for (final account in accounts) account.name: account,
  //   };

  //   final categoryByName = {
  //     for (final category in categories) category.name: category,
  //   };

  //   final entityByName = {for (final entity in entities) entity.name: entity};

  //   // ------------------------------------------------------------
  //   // SORT TRANSACTIONS CHRONOLOGICALLY
  //   // ------------------------------------------------------------

  //   final transactions = [...DefaultTransactions.all]
  //     ..sort((a, b) => a.date.compareTo(b.date));

  //   // ------------------------------------------------------------
  //   // VALIDATE REFERENCES
  //   // ------------------------------------------------------------

  //   for (final transaction in transactions) {
  //     if (!accountByName.containsKey(transaction.accountName)) {
  //       throw StateError(
  //         'Default transaction "${transaction.description}" '
  //         'references unknown account "${transaction.accountName}".',
  //       );
  //     }

  //     if (transaction.categoryName != null &&
  //         !categoryByName.containsKey(transaction.categoryName)) {
  //       throw StateError(
  //         'Default transaction "${transaction.description}" '
  //         'references unknown category "${transaction.categoryName}".',
  //       );
  //     }

  //     if (transaction.entityName != null &&
  //         !entityByName.containsKey(transaction.entityName)) {
  //       throw StateError(
  //         'Default transaction "${transaction.description}" '
  //         'references unknown entity "${transaction.entityName}".',
  //       );
  //     }

  //     if (transaction.linkedAccountName != null &&
  //         !accountByName.containsKey(transaction.linkedAccountName)) {
  //       throw StateError(
  //         'Default transaction "${transaction.description}" '
  //         'references unknown linked account '
  //         '"${transaction.linkedAccountName}".',
  //       );
  //     }

  //     if (transaction.isDebtRepayment && !transaction.isDebt) {
  //       throw StateError(
  //         'Default transaction "${transaction.description}" '
  //         'cannot be a debt repayment without isDebt = true.',
  //       );
  //     }

  //     // Give and receive transactions must have a person/entity.
  //     if ((transaction.type == TransactionType.give ||
  //             transaction.type == TransactionType.receive) &&
  //         transaction.entityName == null) {
  //       throw StateError(
  //         'Default transaction "${transaction.description}" '
  //         'requires an entity.',
  //       );
  //     }
  //   }

  //   // ------------------------------------------------------------
  //   // INSERT TRANSACTIONS
  //   // ------------------------------------------------------------

  //   for (final transaction in transactions) {
  //     final account = accountByName[transaction.accountName]!;

  //     final category = transaction.categoryName == null
  //         ? null
  //         : categoryByName[transaction.categoryName];

  //     final linkedAccount = transaction.linkedAccountName == null
  //         ? null
  //         : accountByName[transaction.linkedAccountName];

  //     final entity = transaction.entityName == null
  //         ? null
  //         : entityByName[transaction.entityName];

  //     // ----------------------------------------------------------
  //     // TRANSACTION
  //     // ----------------------------------------------------------

  //     final transactionId = await into(transactionsTable).insert(
  //       TransactionsTableCompanion.insert(
  //         amount: transaction.amount,
  //         date: transaction.date,
  //         note: Value(transaction.description),
  //         transactionType: transaction.type.name,
  //         categoryId: Value(category?.id),
  //         accountId: account.id,
  //         linkedAccountId: Value(linkedAccount?.id),
  //       ),
  //     );

  //     // ----------------------------------------------------------
  //     // PERSON TRANSACTION
  //     // ----------------------------------------------------------

  //     if (entity != null &&
  //         (transaction.type == TransactionType.give ||
  //             transaction.type == TransactionType.receive)) {
  //       await into(transactionParticipantsTable).insert(
  //         TransactionParticipantsTableCompanion.insert(
  //           transactionId: transactionId,
  //           entityId: entity.id,
  //           allocatedAmount: transaction.amount,
  //           allocationPercentage: const Value(1.0),

  //           // For RECEIVE:
  //           // the other person gave/payed the money.
  //           //
  //           // For GIVE:
  //           // you gave/payed the money.
  //           isPayer: Value(transaction.type == TransactionType.receive),

  //           displayNameSnapshot: Value(entity.name),
  //         ),
  //       );
  //     }

  //     // ----------------------------------------------------------
  //     // DEBT / DEBT REPAYMENT
  //     // ----------------------------------------------------------

  //     if (entity != null && transaction.isDebt) {
  //       final me = entityByName['Me'];

  //       if (me == null) {
  //         throw StateError('Current user entity "Me" was not found.');
  //       }

  //       late final int debtorEntityId;
  //       late final int creditorEntityId;

  //       if (transaction.isDebtRepayment) {
  //         // ------------------------------------------------------
  //         // DEBT REPAYMENT
  //         //
  //         // Give repayment:
  //         // Juan → Me
  //         //
  //         // Receive repayment:
  //         // Me → Maria
  //         //
  //         // The repayment reverses the original debt direction.
  //         // ------------------------------------------------------

  //         debtorEntityId = me.id;
  //         creditorEntityId = entity.id;
  //       } else {
  //         // ------------------------------------------------------
  //         // NEW DEBT
  //         // ------------------------------------------------------

  //         switch (transaction.type) {
  //           case TransactionType.give:
  //             // You gave/lent money to the person.
  //             //
  //             // Person owes you.
  //             debtorEntityId = entity.id;
  //             creditorEntityId = me.id;
  //             break;

  //           case TransactionType.receive:
  //             // You received/borrowed money from the person.
  //             //
  //             // You owe the person.
  //             debtorEntityId = me.id;
  //             creditorEntityId = entity.id;
  //             break;

  //           default:
  //             throw StateError(
  //               'Debt is only valid for give or receive transactions.',
  //             );
  //         }
  //       }

  //       await into(financialObligationsTable).insert(
  //         FinancialObligationsTableCompanion.insert(
  //           transactionId: transactionId,
  //           debtorEntityId: debtorEntityId,
  //           creditorEntityId: creditorEntityId,
  //           amount: transaction.amount,
  //           type: transaction.isDebtRepayment
  //               ? 'repayment'
  //               : transaction.type.name,
  //           note: Value(transaction.description),
  //         ),
  //       );
  //     }
  //   }
  // }

  Future<void> seedDefaultEntities() async {
    final existing = await select(entitiesTable).get();

    if (existing.isNotEmpty) return;

    await batch((batch) {
      batch.insertAll(entitiesTable, [
        EntitiesTableCompanion.insert(
          name: 'Me',
          entityType: EntityType.person.name,
        ),
        EntitiesTableCompanion.insert(
          name: 'Juan',
          entityType: EntityType.person.name,
        ),
        EntitiesTableCompanion.insert(
          name: 'Maria',
          entityType: EntityType.person.name,
        ),
      ]);
    });
  }

  Future<void> seedDefaultPaymentAccounts() async {
    final existing = await select(accountsTable).get();

    if (existing.isNotEmpty) return;

    final accounts = DefaultAccounts.all
        .map(
          (account) => AccountsTableCompanion.insert(
            name: account.name,
            icon: account.iconKey,

            // accountGroup: account.group,
            accountType: account.type.name,
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
