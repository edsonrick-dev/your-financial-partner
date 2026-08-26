import 'package:drift/drift.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_group/account_group_summary.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/tables/accounts_table.dart';
import 'package:getx_drift_app/data/tables/transactions_table.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/models/net_worth_item.dart';
part 'accounts_dao.g.dart';

/// ============================================================================
/// ACCOUNTS DAO
/// ============================================================================
///
/// DOMAIN
/// ---------------------------------------------------------------------------
/// Responsible for account management, balance projections,
/// balance calculations, account diagnostics, and portfolio metrics.
///
///
/// ACCOUNT ARCHITECTURE
/// ---------------------------------------------------------------------------
///
/// Transactions are the financial source of truth.
///
/// Account.currentValue currently acts as a cached projection that allows
/// the UI to display balances quickly without recalculating the entire
/// transaction history.
///
///                Transactions
///                      │
///                      ▼
///          Calculated Account Balance
///                      │
///                      ▼
///            Account.currentValue
///
///
/// BALANCE STRATEGY
/// ---------------------------------------------------------------------------
///
/// Current State
/// • Transactions generate balance changes.
/// • Account.currentValue is updated during transaction creation,
///   editing, and deletion.
///
/// Future State
/// • Transactions become the sole source of truth.
/// • Account.currentValue becomes a rebuildable cache.
/// • Balance verification tools ensure synchronization.
///
///
/// RESPONSIBILITIES
/// ---------------------------------------------------------------------------
///
/// Account Management
/// • Create accounts
/// • Update accounts
/// • Delete accounts
/// • Watch account changes
///
/// Balance Projection
/// • Maintain currentValue
/// • Incremental balance updates
///
/// Balance Engine
/// • Calculate balances from transactions
/// • Verify balance integrity
/// • Rebuild corrupted balances
///
/// Portfolio Metrics
/// • Available Funds
/// • Net Worth
/// • Assets
/// • Liabilities
///
/// ============================================================================
@DriftAccessor(tables: [AccountsTable, TransactionsTable])
class AccountsDao extends DatabaseAccessor<AppDatabase>
    with _$AccountsDaoMixin {
  AccountsDao(super.db);

  // ============================================================================
  // ACCOUNT CRUD
  // ============================================================================

  /// Returns a single account by ID.
  ///
  /// Returns null when the account does not exist.
  ///
  /// Used by:
  /// • Transaction Editing
  /// • Account Details
  /// • Transfers
  /// • Account Settings
  Future<AccountsTableData?> getAccountById(int accountId) {
    return (select(
      accountsTable,
    )..where((tbl) => tbl.id.equals(accountId))).getSingleOrNull();
  }

  /// Returns a live stream of all accounts.
  ///
  /// Emits whenever an account is created,
  /// updated, or deleted.
  ///
  /// Used by:
  /// • Account Lists
  /// • Dashboard
  /// • Account Selectors
  Stream<List<AccountsTableData>> watchAccounts() {
    return select(accountsTable).watch();
  }

  Stream<AccountsTableData?> watchAccount(int accountId) {
    return (select(
      accountsTable,
    )..where((tbl) => tbl.id.equals(accountId))).watchSingleOrNull();
  }

  Future<List<AccountsTableData>> getAllAccounts() {
    return select(accountsTable).get();
  }

  Stream<List<AccountsTableData>> watchAssetAccounts() {
    final assetTypes = AccountType.values
        .where((type) => type.isAsset)
        .map((type) => type.name)
        .toList();

    return (select(
      accountsTable,
    )..where((tbl) => tbl.accountType.isIn(assetTypes))).watch();
  }

  Stream<List<AccountGroupSummary>> watchAssetAccountGroups() {
    return watchAccounts().map((accounts) {
      final assetGroups = AccountGroup.values
          .where((group) => group.isAsset)
          .toList();

      return assetGroups
          .map((group) {
            final groupItems = accounts
                .where((account) {
                  final accountType = AccountType.fromName(account.accountType);

                  return accountType.group == group;
                })
                .map((account) {
                  final accountType = AccountType.fromName(account.accountType);

                  return NetWorthItem(
                    id: 'account_${account.id}',
                    name: account.name,
                    value: account.currentValue.abs(),
                    source: NetWorthItemSource.account,
                    group: accountType.group,
                    account: account,
                  );
                })
                .toList();

            return AccountGroupSummary(group: group, items: groupItems);
          })
          .where((summary) => summary.items.isNotEmpty)
          .toList();
    });
  }

  Stream<List<AccountGroupSummary>> watchLiabilityAccountGroups() {
    return watchAccounts().map((accounts) {
      final liabilityGroups = AccountGroup.values
          .where((group) => group.isLiability)
          .toList();

      return liabilityGroups
          .map((group) {
            final groupItems = accounts
                .where((account) {
                  final accountType = AccountType.fromName(account.accountType);

                  return accountType.group == group;
                })
                .map((account) {
                  final accountType = AccountType.fromName(account.accountType);

                  return NetWorthItem(
                    id: 'account_${account.id}',
                    name: account.name,
                    value: account.currentValue.abs(),
                    source: NetWorthItemSource.account,
                    group: accountType.group,
                    account: account,
                  );
                })
                .toList();

            return AccountGroupSummary(group: group, items: groupItems);
          })
          .where((summary) => summary.items.isNotEmpty)
          .toList();
    });
  }

  Future<int> insertAccount(AccountsTableCompanion entry) {
    return into(accountsTable).insert(entry);
  }

  Future<void> updateAccount(int accountId, AccountsTableCompanion data) {
    return (update(
      accountsTable,
    )..where((tbl) => tbl.id.equals(accountId))).write(data);
  }

  Future<void> deleteAccount(int accountId) {
    return (delete(
      accountsTable,
    )..where((tbl) => tbl.id.equals(accountId))).go();
  }

  // ============================================================================
  // ACCOUNT PROJECTION MANAGEMENT
  // ============================================================================
  Future<void> updateAccountBalance(int accountId, double newBalance) {
    return (update(accountsTable)..where((tbl) => tbl.id.equals(accountId)))
        .write(AccountsTableCompanion(currentValue: Value(newBalance)));
  }

  /// Applies a balance delta to the stored account projection.
  ///
  /// Example:
  ///
  /// Existing Balance: 1,000
  /// Delta: -300
  ///
  /// Result: 700
  ///
  /// WARNING:
  /// Does not recalculate from transaction history.
  ///
  /// Used by:
  /// • Earn Transactions
  /// • Spend Transactions
  /// • Transfers
  /// • Debt Transactions
  Future<void> adjustAccountBalance(int accountId, double delta) async {
    final account = await (select(
      accountsTable,
    )..where((tbl) => tbl.id.equals(accountId))).getSingle();

    final updatedBalance = account.currentValue + delta;

    await updateAccountBalance(accountId, updatedBalance);
  }

  // ============================================================================
  // PORTFOLIO METRICS
  // ============================================================================
  /// Money immediately available for spending.
  ///
  /// Includes:
  /// • Cash
  /// • Savings Accounts
  /// • Checking Accounts
  /// • E-wallets
  ///
  /// Excludes:
  /// • Credit Cards
  /// • Loans
  /// • Investments
  /// • Other Assets
  ///
  /// Rule:
  /// AccountType.group == AccountGroup.cashAndBank
  Stream<double> watchAvailableFunds() {
    final cashAndBankTypes = AccountType.values
        .where((type) => type.group == AccountGroup.cashAndBank)
        .map((type) => type.name)
        .toList();

    final query = select(accountsTable)
      ..where((tbl) => tbl.accountType.isIn(cashAndBankTypes));

    return query.watch().map((accounts) {
      return accounts.fold(0.0, (sum, account) => sum + account.currentValue);
    });
  }

  // ============================================================================
  // BALANCE CALCULATION ENGINE
  // ============================================================================

  /// Calculates an account balance dynamically from transaction history.
  ///
  /// This balance is derived entirely from transactions and does not rely on
  /// Account.currentValue.
  ///
  /// Transaction Rules:
  ///
  /// Earn      → +amount
  /// Receive   → +amount
  /// Spend     → -amount
  /// Give      → -amount
  /// Transfer
  ///    Source Account      → -amount
  ///    Destination Account → +amount
  ///
  /// This function represents the future source-of-truth balance engine.
  ///
  /// Related:
  /// • calculateAccountBalance()
  /// • verifyAccountBalance()
  /// • balanceDifference()
  Stream<double> watchAccountBalance(int accountId) {
    return watchAccount(accountId).asyncExpand((account) {
      if (account == null) {
        return Stream.value(0);
      }

      return select(transactionsTable).watch().map(
        (transactions) =>
            _calculateBalance(transactions, accountId, account.isLiability),
      );
    });
  }

  /// Core balance calculation engine.
  ///
  /// Shared by:
  /// • watchAccountBalance()
  /// • calculateAccountBalance()
  ///
  /// Ensures balance calculations remain consistent across both stream and
  /// non-stream implementations.
  ///
  /// IMPORTANT:
  /// This function should contain the single source of balance calculation logic.
  ///
  /// Any future transaction types must be added here.
  double _calculateBalance(
    List<TransactionsTableData> transactions,
    int accountId,
    bool isLiability,
  ) {
    double balance = 0;

    for (final tx in transactions) {
      final type = TransactionType.values.firstWhere(
        (e) => e.name == tx.transactionType,
      );

      switch (type) {
        case TransactionType.earn:
          if (tx.accountId == accountId) {
            balance += tx.amount;
          }
          break;

        case TransactionType.spend:
          if (tx.accountId == accountId) {
            balance += isLiability ? tx.amount : -tx.amount;
          }
          break;

        case TransactionType.receive:
          if (tx.accountId == accountId) {
            balance += tx.amount;
          }
          break;

        case TransactionType.give:
          if (tx.accountId == accountId) {
            balance += isLiability ? tx.amount : -tx.amount;
          }
          break;

        case TransactionType.transfer:
          if (tx.accountId == accountId) {
            balance -= tx.amount;
          }

          if (tx.linkedAccountId == accountId) {
            balance += tx.amount;
          }
          break;
        case TransactionType.balanceUpdate:
          if (tx.accountId == accountId) {
            balance += tx.amount;
          }
          break;
      }
    }

    return balance;
  }

  Future<double> calculateNetWorthAt(DateTime date) async {
    final accounts = await select(accountsTable).get();

    final transactions = await (select(
      transactionsTable,
    )..where((tbl) => tbl.date.isSmallerOrEqualValue(date))).get();

    double netWorth = 0;

    for (final account in accounts) {
      final balance = _calculateBalance(
        transactions,
        account.id,
        account.isLiability,
      );

      if (account.isLiability) {
        netWorth -= balance;
      } else {
        netWorth += balance;
      }
    }

    return netWorth;
  }

  /// Calculates an account balance on-demand.
  ///
  /// Unlike watchAccountBalance(), this performs a one-time calculation.
  ///
  /// Used by:
  /// • balance verification
  /// • account rebuild operations
  /// • diagnostics
  Future<double> calculateAccountBalance(int accountId) async {
    final account = await (select(
      accountsTable,
    )..where((tbl) => tbl.id.equals(accountId))).getSingle();

    final transactions = await select(transactionsTable).get();

    return _calculateBalance(transactions, accountId, account.isLiability);
  }
  // ============================================================================
  // BALANCE DIAGNOSTICS
  // ============================================================================

  /// Compares the stored account balance against the calculated balance.
  ///
  /// Returns:
  /// • true  → balances match
  /// • false → mismatch detected
  ///
  /// Used for detecting projection corruption.
  ///
  /// Formula:
  /// Account.currentValue
  ///        vs
  /// Calculated Transaction Balance
  Future<bool> verifyAccountBalance(int accountId) async {
    final account = await (select(
      accountsTable,
    )..where((tbl) => tbl.id.equals(accountId))).getSingle();

    final calculated = await calculateAccountBalance(accountId);

    return (account.currentValue - calculated).abs() < 0.01;
  }

  /// Returns the difference between calculated and stored balances.
  ///
  /// Positive Result:
  /// Calculated balance is higher than stored balance.
  ///
  /// Negative Result:
  /// Calculated balance is lower than stored balance.
  ///
  /// Zero:
  /// Account projection is synchronized.
  ///
  /// Used for diagnostics and future rebuild tooling.
  Future<double> balanceDifference(int accountId) async {
    final account = await (select(
      accountsTable,
    )..where((tbl) => tbl.id.equals(accountId))).getSingle();

    final calculated = await calculateAccountBalance(accountId);

    return calculated - account.currentValue;
  }
  // ============================================================================
  // BALANCE RECOVERY
  // ============================================================================

  /// Rebuilds an account's stored balance projection
  /// from transaction history.
  ///
  /// Process:
  ///
  /// Transactions
  ///      ↓
  /// Calculate Balance
  ///      ↓
  /// Update currentValue
  ///
  /// Used when:
  /// • Balance corruption is detected
  /// • Verification fails
  /// • Migration repair is required
  Future<void> rebuildAccountBalance(int accountId) async {
    final calculated = await calculateAccountBalance(accountId);

    await updateAccountBalance(accountId, calculated);
  }

  Future<void> rebuildAllAccountBalances() async {
    final accounts = await getAllAccounts();

    for (final account in accounts) {
      await rebuildAccountBalance(account.id);
    }
  }
}
