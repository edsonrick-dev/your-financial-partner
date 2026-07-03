import 'package:flutter/material.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/models/split_expense_summary.dart';
import 'package:getx_drift_app/data/models/transaction_participant_with_entity.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';
import 'package:getx_drift_app/data/tables/transactions_table.dart';
import 'package:getx_drift_app/data/tables/transaction_participants_table.dart';
import 'package:getx_drift_app/data/tables/financial_obligations_table.dart';
import 'package:getx_drift_app/features/home/controllers/home_controller.dart';
import 'package:intl/intl.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';

import 'package:drift/drift.dart';
part 'transactions_dao.g.dart';

/// =============================================================================
/// TRANSACTIONS DAO
/// =============================================================================
///
/// Central transaction repository responsible for:
///
/// • Creating and updating transactions
/// • Managing transaction participants
/// • Managing financial obligations
/// • Calculating account balances from transaction history
/// • Building transaction detail models for UI consumption
/// • Providing transaction streams and grouped transaction views
///
/// ARCHITECTURE
///
/// Transactions are treated as the source of truth.
///
/// Account.currentValue acts as a cached projection and can be verified or
/// rebuilt from transaction history using balance calculation functions.
///
/// Responsibilities:
///
/// Transaction Layer
/// ├─ TransactionsTable
/// ├─ TransactionParticipantsTable
/// └─ FinancialObligationsTable
///
/// Projection Layer
/// ├─ TransactionWithDetails
/// ├─ SplitExpenseSummary
/// └─ Account Balance Calculations
///
/// Presentation Layer
/// ├─ watchTransactions()
/// ├─ watchRecentTransactions()
/// └─ watchGroupedTransactions()
///
/// =============================================================================
@DriftAccessor(
  tables: [
    TransactionsTable,
    TransactionParticipantsTable,
    FinancialObligationsTable,
  ],
)
class TransactionsDao extends DatabaseAccessor<AppDatabase>
    with _$TransactionsDaoMixin {
  TransactionsDao(super.db);

  Stream<MonthlyCashFlowSummary> watchMonthlySummary({
    required DateTime month,
  }) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);

    final query = select(transactionsTable)
      ..where(
        (t) =>
            t.date.isBiggerOrEqualValue(start) & t.date.isSmallerThanValue(end),
      );

    return query.watch().map((transactions) {
      double income = 0;
      double expenses = 0;
      double savings = 0;

      for (final tx in transactions) {
        switch (tx.type) {
          case TransactionType.earn:
            income += tx.amount;
            break;

          case TransactionType.spend:
            expenses += tx.amount;
            break;

          case TransactionType.transfer:
            // ignore
            break;

          case TransactionType.give:
            // ignore
            break;

          case TransactionType.receive:
            // ignore
            break;
        }
      }

      return MonthlyCashFlowSummary(
        income: income,
        expenses: expenses,
        savings: savings,
      );
    });
  }

  /// =============================================================================
  /// TRANSACTION PERSISTENCE
  /// =============================================================================

  /// Updates an existing transaction while preserving its identity.
  ///
  /// Used during transaction editing.
  ///
  /// Preserves:
  /// • transaction.id
  /// • createdAt
  ///
  /// Updates:
  /// • amount
  /// • date
  /// • account references
  /// • category references
  /// • note
  /// • updatedAt
  ///
  /// Related Flow:
  /// reverseTransactionEffects()
  ///     ↓
  /// updateTransaction()
  ///     ↓
  /// reapply transaction effects
  Future<void> updateTransaction(
    int transactionId,
    TransactionsTableCompanion data,
  ) {
    return (update(
      transactionsTable,
    )..where((tbl) => tbl.id.equals(transactionId))).write(data);
  }

  /// =============================================================================
  /// BALANCE ENGINE
  /// =============================================================================

  /// Creates a new transaction record.
  ///
  /// Returns:
  /// • Newly created transaction ID.
  ///
  /// Used by:
  /// • Earn
  /// • Spend
  /// • Transfer
  /// • Give Money
  /// • Receive Money
  Future<int> insertTransaction(TransactionsTableCompanion entry) {
    return into(transactionsTable).insert(entry);
  }

  /// =============================================================================
  /// PARTICIPANT MANAGEMENT
  /// =============================================================================

  /// Creates a participant record for a transaction.
  ///
  /// Used primarily for:
  /// • Shared Expenses
  /// • Give Money
  /// • Receive Money
  ///
  /// Stores:
  /// • participant entity
  /// • allocated amount
  /// • percentage allocation
  /// • payer information
  Future<int> insertTransactionParticipant(
    TransactionParticipantsTableCompanion entry,
  ) {
    return into(transactionParticipantsTable).insert(entry);
  }

  /// Removes all participant records belonging to a transaction.
  ///
  /// Used during:
  /// • transaction editing
  /// • transaction deletion
  ///
  /// Typically executed by:
  /// reverseTransactionEffects()
  Future<int> deleteParticipantsByTransaction(int transactionId) {
    return (delete(
      transactionParticipantsTable,
    )..where((tbl) => tbl.transactionId.equals(transactionId))).go();
  }

  /// =============================================================================
  /// OBLIGATION MANAGEMENT
  /// =============================================================================

  /// Creates a debt/receivable record linked to a transaction.
  ///
  /// Used for:
  /// • Give Money
  /// • Receive Money
  /// • Shared Expenses
  ///
  /// Examples:
  ///
  /// Give Money
  /// Me → Babs
  ///
  /// Receive Money
  /// Babs → Me
  ///
  /// Shared Expense
  /// Babs owes Me
  Future<int> insertFinancialObligation(
    FinancialObligationsTableCompanion entry,
  ) {
    return into(financialObligationsTable).insert(entry);
  }

  /// =============================================================================
  /// TRANSACTION STREAMS
  /// =============================================================================

  /// Returns fully hydrated transaction models.
  ///
  /// Joins:
  /// • Transactions
  /// • Categories
  /// • Accounts
  /// • Linked Accounts
  /// • Participants
  /// • Obligations
  ///
  /// Produces:
  /// TransactionWithDetails
  ///
  /// Primary data source for transaction screens.
  Stream<List<TransactionWithDetails>> watchTransactions() {
    final linkedAccounts = alias(accountsTable, 'linked_accounts');

    final query =
        select(transactionsTable).join([
          leftOuterJoin(
            cashflowCategoriesTable,
            cashflowCategoriesTable.id.equalsExp(transactionsTable.categoryId),
          ),

          innerJoin(
            accountsTable,
            accountsTable.id.equalsExp(transactionsTable.accountId),
          ),

          leftOuterJoin(
            linkedAccounts,
            linkedAccounts.id.equalsExp(transactionsTable.linkedAccountId),
          ),
        ])..orderBy([
          OrderingTerm.desc(transactionsTable.date),
          OrderingTerm.desc(transactionsTable.createdAt),
        ]);

    return query.watch().asyncMap((rows) async {
      return Future.wait(
        rows.map((row) async {
          final transaction = row.readTable(transactionsTable);

          final category = row.readTableOrNull(cashflowCategoriesTable);

          final account = row.readTable(accountsTable);

          final participants = await getParticipantsWithEntities(
            transaction.id,
          );

          TransactionParticipantWithEntity? myParticipant;

          try {
            myParticipant = participants.firstWhere(
              (participant) => participant.entity.id == 1,
            );
          } catch (_) {
            myParticipant = null;
          }

          final myShare = myParticipant != null
              ? myParticipant.participant.allocatedAmount
              : transaction.amount;

          final receivableAmount = participants
              .where((participant) => participant.entity.id != 1)
              .fold<double>(0, (sum, participant) {
                return sum + participant.participant.allocatedAmount;
              });
          final obligations = await (select(
            financialObligationsTable,
          )..where((tbl) => tbl.transactionId.equals(transaction.id))).get();

          debugPrint(
            'Transaction ${transaction.id}: ${obligations.length} obligations',
          );
          // final obligation =
          //     await (select(
          //           financialObligationsTable,
          //         )..where((tbl) => tbl.transactionId.equals(transaction.id)))
          //         .getSingleOrNull();
          return TransactionWithDetails(
            transaction: transaction,

            category: category,

            account: account,

            linkedAccount: row.readTableOrNull(linkedAccounts),

            participants: participants,
            // obligationType: obligation?.type,
            obligations: obligations,
            obligationType: obligations.isNotEmpty
                ? obligations.first.type
                : null,
            splitSummary: SplitExpenseSummary(
              totalPaid: transaction.amount,

              myShare: myShare,

              receivableAmount: receivableAmount,

              isSharedExpense: participants.length > 1,
            ),
          );
        }).toList(),
      );
    });
  }

  /// Returns the latest 5 transactions.
  ///
  /// Used by:
  /// • Dashboard
  /// • Home Screen
  ///
  /// Derived from:
  /// watchTransactions()
  Stream<List<TransactionWithDetails>> watchRecentTransactions() {
    return watchTransactions().map(
      (transactions) => transactions.take(5).toList(),
    );
  }

  /// Groups transactions by calendar day.
  ///
  /// Output Example:
  ///
  /// Today
  /// ├─ Transaction A
  /// └─ Transaction B
  ///
  /// Yesterday
  /// └─ Transaction C
  ///
  /// June 10, 2026
  /// └─ Transaction D
  ///
  /// Used by:
  /// Transaction History Screen
  Stream<Map<String, List<TransactionWithDetails>>> watchGroupedTransactions() {
    return watchTransactions().map((transactions) {
      final grouped = <DateTime, List<TransactionWithDetails>>{};

      for (final item in transactions) {
        final date = item.transaction.date;

        final normalizedDate = DateTime(date.year, date.month, date.day);

        grouped.putIfAbsent(normalizedDate, () => []);

        grouped[normalizedDate]!.add(item);
      }

      /// SORT DATES DESCENDING

      final sortedEntries = grouped.entries.toList()
        ..sort((a, b) => b.key.compareTo(a.key));

      /// CONVERT TO STRING LABELS

      final result = <String, List<TransactionWithDetails>>{};

      for (final entry in sortedEntries) {
        result[groupLabel(entry.key)] = entry.value;
      }

      return result;
    });
  }

  /// =============================================================================
  /// UTILITY FUNCTIONS
  /// =============================================================================

  /// Converts a date into a human-readable section label.
  ///
  /// Examples:
  /// • Today
  /// • Yesterday
  /// • June 8, 2026
  ///
  /// Used by:
  /// watchGroupedTransactions()
  String groupLabel(DateTime date) {
    final now = DateTime.now();

    final today = DateTime(now.year, now.month, now.day);

    final yesterday = today.subtract(const Duration(days: 1));

    final target = DateTime(date.year, date.month, date.day);

    if (target == today) {
      return 'Today';
    }

    if (target == yesterday) {
      return 'Yesterday';
    }

    return DateFormat('MMMM d, yyyy').format(date);
  }

  /// Hydrates participant records with their associated entities.
  ///
  /// Converts:
  ///
  /// TransactionParticipant
  ///       +
  /// Entity
  ///
  /// Into:
  ///
  /// TransactionParticipantWithEntity
  ///
  /// Used when constructing TransactionWithDetails.
  Future<List<TransactionParticipantWithEntity>> getParticipantsWithEntities(
    int transactionId,
  ) async {
    final participantRows = await (select(
      transactionParticipantsTable,
    )..where((tbl) => tbl.transactionId.equals(transactionId))).get();

    final result = <TransactionParticipantWithEntity>[];

    for (final participant in participantRows) {
      final entity = await (select(
        entitiesTable,
      )..where((tbl) => tbl.id.equals(participant.entityId))).getSingleOrNull();

      if (entity == null) {
        debugPrint('Missing entity for participantId: ${participant.entityId}');

        continue;
      }

      result.add(
        TransactionParticipantWithEntity(
          participant: participant,
          entity: entity,
        ),
      );
    }

    return result;
  }
}
