import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter/foundation.dart' show debugPrint;
import 'package:getx_drift_app/data/default_data/default_accounts.dart';
import 'package:getx_drift_app/data/default_data/default_categories.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/data/enums/entity_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/premium_payment_type.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables/cashflow_categories_table.dart';
import 'tables/accounts_table.dart';
import 'tables/transaction_participants_table.dart';
import 'tables/entities_table.dart';
import 'tables/transactions_table.dart';
import 'tables/financial_obligations_table.dart';
import 'tables/cashflow_plan_allocation_table.dart';
import 'tables/cashflow_plan_metadata_table.dart';
import 'tables/cashflow_plan_table.dart';
import 'tables/bills_table.dart';
import 'tables/bill_occurrences_table.dart';
import 'tables/credit_card_billing_periods_table.dart';
import 'tables/credit_card_details_table.dart';
import 'tables/credit_card_statements_table.dart';
import 'tables/investor_profile_table.dart';
import 'tables/goals_table.dart';
import 'tables/goal_reservations_table.dart';
import 'tables/user_profile_table.dart';
import 'tables/protection_budget_continuities_table.dart';
import 'tables/protection_scenarios_table.dart';
import 'tables/retirement_goal_table.dart';
import 'tables/protection_dependency_table.dart';
import 'tables/expense_continuity_table.dart';
import 'tables/protection_needs_table.dart';
import 'tables/protection_plan_continuity_shares_table.dart';
import 'tables/protection_plans_table.dart';
import 'tables/loan_table.dart';
import 'tables/insurance_products_table.dart';
import 'tables/insurance_benefits_table.dart';
import 'tables/insurance_product_payment_terms_table.dart';
import 'tables/payment_terms_table.dart';
import 'tables/user_insurance_policy_table.dart';
import 'tables/premium_detail_table.dart';
import 'tables/user_insurance_benefits_table.dart';
import 'tables/insurance_premium_bills_table.dart';

// import 'tables/cashflow_plans_table.dart';

import 'package:getx_drift_app/data/database/daos/transactions_dao/transactions_dao.dart';
import 'package:getx_drift_app/data/database/daos/accounts_dao/accounts_dao.dart';
import 'package:getx_drift_app/data/database/daos/people_balance_dao/people_balance_dao.dart';
import 'package:getx_drift_app/data/database/daos/entities_dao/entities_dao.dart';
import 'package:getx_drift_app/data/database/daos/cashflow_plan_dao/cashflow_plan_dao.dart';
import 'package:getx_drift_app/data/database/daos/bills_dao/bills_dao.dart';
import 'package:getx_drift_app/data/database/daos/category_dao/category_dao.dart';
import 'package:getx_drift_app/data/database/daos/credit_card_dao/credit_card_dao.dart';
import 'package:getx_drift_app/data/database/daos/investor_profile/investor_profile_dao.dart';
import 'package:getx_drift_app/data/database/daos/goals_dao/goals_dao.dart';
import 'package:getx_drift_app/data/database/daos/goal_reservations_dao/goal_reservations_dao.dart';
import 'package:getx_drift_app/data/database/daos/user_profile_dao/user_profile_dao.dart';
import 'package:getx_drift_app/data/database/daos/retirement_goal_dao/retirement_goal_dao.dart';
import 'package:getx_drift_app/data/database/daos/protection_dao/protection_dao.dart';
import 'package:getx_drift_app/data/database/daos/insurance_policies_dao/insurance_policies_dao.dart';
import 'package:getx_drift_app/data/database/daos/payment_terms_dao/payment_terms_dao.dart';
import 'package:getx_drift_app/data/database/daos/insurance_product_payment_terms_dao/insurance_product_payment_terms_dao.dart';
import 'package:getx_drift_app/data/database/daos/user_insurance_policy_dao/user_insurance_policy_dao.dart';
import 'package:getx_drift_app/data/database/daos/insurance_premium_bills_dao/insurance_premium_bills_dao.dart';
part 'app_database.g.dart';

@DriftDatabase(
  tables: [
    CashflowCategoriesTable,
    CashflowPlanMetadata,
    AccountsTable,
    TransactionsTable,
    EntitiesTable,
    TransactionParticipantsTable,
    FinancialObligationsTable,
    Loans,
    CashFlowPlanAllocations,
    CashFlowPlans,
    BillsTable,
    BillOccurrencesTable,
    CreditCardDetailsTable,
    CreditCardBillingPeriodsTable,
    CreditCardStatementsTable,
    InvestorProfilesTable,
    GoalsTable,
    GoalReservationsTable,
    UserProfileTable,
    RetirementGoalsTable,

    ProtectionScenariosTable,
    ProtectionBudgetContinuities,
    ProtectionDependencyTable,

    ExpenseContinuityTable,
    ProtectionNeedsTable,
    ProtectionPlanContinuitySharesTable,
    ProtectionPlansTable,

    InsuranceProductsTable,
    InsuranceBenefitsTable,

    PaymentTermsTable,
    InsuranceProductPaymentTermsTable,
    PremiumDetailsTable,
    UserInsurancePolicyTable,
    UserInsuranceBenefitsTable,
    InsurancePremiumBillsTable,
  ],
  daos: [
    TransactionsDao,
    AccountsDao,
    PeopleBalanceDao,
    EntitiesDao,
    CashflowPlanDao,
    BillsDao,
    CategoryDao,
    CreditCardDao,
    InvestorProfileDao,
    GoalsDao,
    GoalReservationsDao,
    UserProfileDao,
    RetirementGoalDao,
    ProtectionDao,
    InsurancePoliciesDao,
    PaymentTermsDao,
    InsuranceProductPaymentTermsDao,
    UserInsurancePolicyDao,
    InsurancePremiumBillsDao,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (m) async {
      await m.createAll();

      await seedDefaultCategories();

      await seedDefaultEntities();
      await seedCashflowPlanMetadata();
    },

    onUpgrade: (m, from, to) async {
      if (from < 3) {
        await m.createTable(userProfileTable);
        await m.createTable(retirementGoalsTable);
      }
      if (from < 5) {
        await m.createTable(cashflowPlanMetadata);
      }
      if (from < 7) {
        await m.createTable(protectionScenariosTable);
        await m.createTable(protectionBudgetContinuities);
      }
      if (from < 8) {
        await m.createTable(protectionDependencyTable);
      }

      if (from < 9) {
        await m.addColumn(entitiesTable, entitiesTable.supabaseId);
      }
      if (from < 11) {
        await m.createTable(insuranceProductsTable);
      }
      if (from < 13) {
        await m.addColumn(
          cashflowCategoriesTable,
          cashflowCategoriesTable.isArchived,
        );
      }
      if (from < 14) {
        await m.addColumn(
          cashflowCategoriesTable,
          cashflowCategoriesTable.isSystem,
        );
        await customStatement('''
          UPDATE cashflow_categories_table
          SET is_system = 1, is_archived = 0
          WHERE type = 'spend'
            AND LOWER(TRIM(name)) IN ('insurance', 'insurances')
        ''');
      }
      // if (from < 6) {
      //   await m.deleteTable('financial_obligations_table');
      //   await m.deleteTable('transaction_participants_table');

      //   await m.createTable(financialObligationsTable);
      //   await m.createTable(transactionParticipantsTable);
      // }
    },
    beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    },
  );
  @override
  int get schemaVersion => 14;

  Future<double> getTotalAccountValue() async {
    final accounts = await select(accountsTable).get();

    return accounts.fold<double>(
      0,
      (sum, account) => sum + account.currentValue,
    );
  }

  Future<void> seedCashflowPlanMetadata() async {
    await into(cashflowPlanMetadata).insertOnConflictUpdate(
      CashflowPlanMetadataCompanion.insert(id: const Value(1)),
    );
  }

  ///PERSONS

  ///Accounts
  ///Cash Flows

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
            isSystem: Value(category.isSystem),
          ),
        )
        .toList();

    /// batch insert

    await batch((batch) {
      batch.insertAll(cashflowCategoriesTable, categories);
    });
  }

  Future<void> seedDefaultEntities() async {
    final defaultEntities = [
      // People
      (name: 'Me', entityType: EntityType.person, organizationType: null),
      (
        name: 'Katrina Francesca Villano',
        entityType: EntityType.person,
        organizationType: null,
      ),
      (
        name: 'Chie Junio',
        entityType: EntityType.person,
        organizationType: null,
      ),
    ];

    final existing = await select(entitiesTable).get();

    for (final entity in existing) {
      debugPrint(
        'Entity: id=${entity.id}, name=${entity.name}, '
        'type=${entity.entityType}',
      );
    }

    final existingNames = existing.map((e) => e.name).toSet();

    final missing = defaultEntities
        .where((entity) => !existingNames.contains(entity.name))
        .toList();

    if (missing.isEmpty) return;

    await batch((batch) {
      batch.insertAll(
        entitiesTable,
        missing.map((entity) {
          return EntitiesTableCompanion.insert(
            name: entity.name,
            entityType: entity.entityType.name,
            // ignore: dead_code
            organizationType: Value(entity.organizationType?.name),
            isSystem: const Value(true),
          );
        }).toList(),
      );
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
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'app.db'));
    return NativeDatabase(file);
  });
}
