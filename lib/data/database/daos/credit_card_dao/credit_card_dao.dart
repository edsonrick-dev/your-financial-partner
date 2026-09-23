import 'package:drift/drift.dart';
import 'package:flutter/rendering.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/tables/credit_card_details_table.dart';
import 'package:getx_drift_app/data/tables/credit_card_billings_table.dart';
import 'package:getx_drift_app/data/tables/credit_card_statements_table.dart';
import 'package:getx_drift_app/data/tables/transactions_table.dart';
import 'package:getx_drift_app/domain/credit_card/credit_card_dates.dart';
import 'dart:math' as math;

part 'credit_card_dao.g.dart';

@DriftAccessor(
  tables: [
    CreditCardDetailsTable,
    CreditCardBillingPeriodsTable,
    CreditCardStatementsTable,
    TransactionsTable,
  ],
)
class CreditCardDao extends DatabaseAccessor<AppDatabase>
    with _$CreditCardDaoMixin {
  CreditCardDao(super.db);
  Future<double> getAmountDue(int accountId) async {
    final statement = await getLatestUnpaidStatement(accountId);

    if (statement == null) {
      return 0;
    }

    return calculateStatementRemainingBalance(statementId: statement.id);
  }

  Future<List<CreditCardBillingPeriodsTableData>> getBillingPeriodsForAccount(
    int accountId,
  ) {
    return (select(creditCardBillingPeriodsTable)
          ..where((tbl) => tbl.accountId.equals(accountId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.startDate)]))
        .get();
  }

  Future<double> calculateStatementBalance({
    required int accountId,
    required int billingPeriodId,
  }) async {
    final period = await (select(
      creditCardBillingPeriodsTable,
    )..where((tbl) => tbl.id.equals(billingPeriodId))).getSingleOrNull();

    if (period == null) {
      return 0;
    }

    // ------------------------------------------------------------
    // 1. Get previous outstanding balance.
    //
    // Only unpaid / partially-paid statements are carried forward.
    // Historical carriedForward statements are ignored.
    // ------------------------------------------------------------

    final previousStatementsQuery =
        select(creditCardStatementsTable).join([
          innerJoin(
            creditCardBillingPeriodsTable,
            creditCardBillingPeriodsTable.id.equalsExp(
              creditCardStatementsTable.billingPeriodId,
            ),
          ),
        ])..where(
          creditCardBillingPeriodsTable.accountId.equals(accountId) &
              creditCardBillingPeriodsTable.endDate.isSmallerThanValue(
                period.startDate,
              ) &
              creditCardStatementsTable.status.isIn([
                CreditCardStatementStatus.unpaid.name,
                CreditCardStatementStatus.partiallyPaid.name,
              ]),
        );

    final previousRows = await previousStatementsQuery.get();

    final previousOutstandingBalance = previousRows.fold<double>(0, (
      total,
      row,
    ) {
      final statement = row.readTable(creditCardStatementsTable);

      return total + statement.statementBalance;
    });

    // ------------------------------------------------------------
    // 2. Get transactions during the current billing period.
    // ------------------------------------------------------------

    final transactions =
        await (select(transactionsTable)..where(
              (tbl) =>
                  tbl.date.isBiggerOrEqualValue(period.startDate) &
                  tbl.date.isSmallerOrEqualValue(period.endDate) &
                  (tbl.accountId.equals(accountId) |
                      tbl.linkedAccountId.equals(accountId)),
            ))
            .get();

    double currentPurchases = 0;
    double currentPayments = 0;

    for (final transaction in transactions) {
      debugPrint(
        'Transaction: '
        'id=${transaction.id}, '
        'type=${transaction.type}, '
        'amount=${transaction.amount}, '
        'date=${transaction.date}, '
        'accountId=${transaction.accountId}, '
        'linkedAccountId=${transaction.linkedAccountId}',
      );

      switch (transaction.type) {
        case TransactionType.spend:
          if (transaction.accountId == accountId) {
            currentPurchases += transaction.amount;
          }
          break;

        case TransactionType.transfer:
          if (transaction.linkedAccountId == accountId) {
            currentPayments += transaction.amount;
          }
          break;

        default:
          break;
      }
    }

    // ------------------------------------------------------------
    // 3. Build cumulative statement.
    //
    // Previous balance + current purchases - current payments.
    // Never allow a negative statement balance.
    // ------------------------------------------------------------

    final totalBeforePayments = previousOutstandingBalance + currentPurchases;
    debugPrint('=== CALCULATE STATEMENT BALANCE ===');
    debugPrint('accountId: $accountId');
    debugPrint('billingPeriodId: ${period.id}');
    debugPrint('period: ${period.startDate} → ${period.endDate}');
    debugPrint('previousOutstandingBalance: $previousOutstandingBalance');
    debugPrint('currentPurchases: $currentPurchases');
    debugPrint('currentPayments: $currentPayments');
    debugPrint(
      'result: ${math.max(0, previousOutstandingBalance + currentPurchases - currentPayments)}',
    );
    return math.max(0, totalBeforePayments - currentPayments);
  }

  Future<double> calculateStatementPayments({
    required int accountId,
    required int billingPeriodId,
  }) async {
    final period = await (select(
      creditCardBillingPeriodsTable,
    )..where((tbl) => tbl.id.equals(billingPeriodId))).getSingleOrNull();

    if (period == null) {
      return 0;
    }

    final transactions =
        await (select(transactionsTable)..where(
              (tbl) =>
                  tbl.date.isBiggerOrEqualValue(period.startDate) &
                  tbl.date.isSmallerOrEqualValue(period.endDate) &
                  tbl.transactionType.equals(TransactionType.transfer.name) &
                  tbl.linkedAccountId.equals(accountId),
            ))
            .get();

    return transactions.fold<double>(
      0,
      (total, transaction) => total + transaction.amount,
    );
  }

  Future<CreditCardStatementsTableData?> closeBillingPeriod({
    required int accountId,
  }) async {
    return attachedDatabase.transaction(() async {
      final billingPeriod = await getOpenBillingPeriod(accountId);

      if (billingPeriod == null) {
        return null;
      }

      final details = await getByAccountId(accountId);

      if (details == null) {
        return null;
      }

      // ------------------------------------------------------------
      // 1. Get previous outstanding statements.
      //
      // These are consolidated into the new statement.
      // ------------------------------------------------------------

      final previousStatementsQuery =
          select(creditCardStatementsTable).join([
            innerJoin(
              creditCardBillingPeriodsTable,
              creditCardBillingPeriodsTable.id.equalsExp(
                creditCardStatementsTable.billingPeriodId,
              ),
            ),
          ])..where(
            creditCardBillingPeriodsTable.accountId.equals(accountId) &
                creditCardBillingPeriodsTable.endDate.isSmallerThanValue(
                  billingPeriod.startDate,
                ) &
                creditCardStatementsTable.status.isIn([
                  CreditCardStatementStatus.unpaid.name,
                  CreditCardStatementStatus.partiallyPaid.name,
                ]),
          );

      final previousRows = await previousStatementsQuery.get();

      final previousStatements = previousRows
          .map((row) => row.readTable(creditCardStatementsTable))
          .toList();

      // ------------------------------------------------------------
      // 2. Calculate the new cumulative statement balance.
      //
      // This includes:
      // - previous outstanding balance
      // - current-period purchases
      // - payments made during the current period
      // ------------------------------------------------------------

      final statementBalance = await calculateStatementBalance(
        accountId: accountId,
        billingPeriodId: billingPeriod.id,
      );

      // ------------------------------------------------------------
      // 3. Calculate payment due date.
      // ------------------------------------------------------------

      final paymentDueDate = CreditCardDates.advancePaymentDueDate(
        nextStatementDate: billingPeriod.endDate,
        paymentDueDay: details.paymentDueDay,
      );

      // ------------------------------------------------------------
      // 4. Create the new cumulative statement.
      // ------------------------------------------------------------

      final statementId = await into(creditCardStatementsTable).insert(
        CreditCardStatementsTableCompanion.insert(
          billingPeriodId: billingPeriod.id,
          statementBalance: statementBalance,
          paymentDueDate: paymentDueDate,
          status: CreditCardStatementStatus.unpaid.name,
        ),
      );

      // ------------------------------------------------------------
      // 5. Previous statements are now historical.
      //
      // Their balances are represented by the new statement.
      // ------------------------------------------------------------

      for (final statement in previousStatements) {
        await (update(
          creditCardStatementsTable,
        )..where((tbl) => tbl.id.equals(statement.id))).write(
          CreditCardStatementsTableCompanion(
            status: Value(CreditCardStatementStatus.carriedForward.name),
          ),
        );
      }

      // ------------------------------------------------------------
      // 6. Close current billing period.
      // ------------------------------------------------------------

      await (update(
        creditCardBillingPeriodsTable,
      )..where((tbl) => tbl.id.equals(billingPeriod.id))).write(
        CreditCardBillingPeriodsTableCompanion(
          status: Value(CreditCardBillingPeriodStatus.closed.name),
        ),
      );

      // ------------------------------------------------------------
      // 7. Create next billing period.
      // ------------------------------------------------------------

      final nextStartDate = billingPeriod.endDate.add(const Duration(days: 1));

      final nextStatementDate = CreditCardDates.advanceStatementDate(
        currentStatementDate: billingPeriod.endDate,
        statementDay: details.statementDay,
      );

      await into(creditCardBillingPeriodsTable).insert(
        CreditCardBillingPeriodsTableCompanion.insert(
          accountId: accountId,
          startDate: nextStartDate,
          endDate: nextStatementDate,
          status: CreditCardBillingPeriodStatus.open.name,
        ),
      );

      // ------------------------------------------------------------
      // 8. Return the newly created statement.
      // ------------------------------------------------------------

      return (select(
        creditCardStatementsTable,
      )..where((tbl) => tbl.id.equals(statementId))).getSingle();
    });
  }

  Future<double> calculateStatementRemainingBalance({
    required int statementId,
  }) async {
    final statement = await (select(
      creditCardStatementsTable,
    )..where((tbl) => tbl.id.equals(statementId))).getSingleOrNull();

    if (statement == null) {
      return 0;
    }

    // A carried-forward statement is historical.
    if (statement.status == CreditCardStatementStatus.carriedForward.name) {
      return 0;
    }

    final billingPeriod =
        await (select(creditCardBillingPeriodsTable)
              ..where((tbl) => tbl.id.equals(statement.billingPeriodId)))
            .getSingleOrNull();

    if (billingPeriod == null) {
      return statement.statementBalance;
    }

    // Find the next statement after this one.
    //
    // Payments after this statement closes and before the next
    // statement closes belong to this statement.
    final nextStatementQuery =
        select(creditCardStatementsTable).join([
            innerJoin(
              creditCardBillingPeriodsTable,
              creditCardBillingPeriodsTable.id.equalsExp(
                creditCardStatementsTable.billingPeriodId,
              ),
            ),
          ])
          ..where(
            creditCardBillingPeriodsTable.accountId.equals(
                  billingPeriod.accountId,
                ) &
                creditCardBillingPeriodsTable.endDate.isBiggerThanValue(
                  billingPeriod.endDate,
                ),
          )
          ..orderBy([OrderingTerm.asc(creditCardBillingPeriodsTable.endDate)])
          ..limit(1);

    final nextRow = await nextStatementQuery.getSingleOrNull();

    DateTime paymentStartDate = billingPeriod.endDate;
    DateTime? paymentEndDate;

    if (nextRow != null) {
      final nextPeriod = nextRow.readTable(creditCardBillingPeriodsTable);

      paymentEndDate = nextPeriod.endDate;
    }

    // Payments made after this statement closed.
    //
    // If there is a newer statement, only payments before that
    // newer statement closes belong to this statement.
    final paymentsQuery = select(transactionsTable)
      ..where(
        (tbl) =>
            tbl.transactionType.equals(TransactionType.transfer.name) &
            tbl.linkedAccountId.equals(billingPeriod.accountId) &
            tbl.date.isBiggerThanValue(paymentStartDate),
      );

    if (paymentEndDate != null) {
      paymentsQuery.where(
        (tbl) => tbl.date.isSmallerThanValue(paymentEndDate!),
      );
    }

    final payments = await paymentsQuery.get();

    final totalPayments = payments.fold<double>(
      0,
      (total, payment) => total + math.max(0, payment.amount),
    );

    return math.max(0, statement.statementBalance - totalPayments);
  }

  Future<double> calculateStatementPaymentsAfterClose({
    required int statementId,
  }) async {
    final statement = await (select(
      creditCardStatementsTable,
    )..where((tbl) => tbl.id.equals(statementId))).getSingleOrNull();

    if (statement == null) {
      return 0;
    }

    final billingPeriod =
        await (select(creditCardBillingPeriodsTable)
              ..where((tbl) => tbl.id.equals(statement.billingPeriodId)))
            .getSingleOrNull();

    if (billingPeriod == null) {
      return 0;
    }

    final payments =
        await (select(transactionsTable)..where(
              (tbl) =>
                  tbl.date.isBiggerThanValue(billingPeriod.endDate) &
                  tbl.transactionType.equals(TransactionType.transfer.name) &
                  tbl.linkedAccountId.equals(billingPeriod.accountId),
            ))
            .get();

    return payments.fold<double>(
      0,
      (total, transaction) => total + transaction.amount,
    );
  }

  Future<CreditCardBillingPeriodsTableData?> getOpenBillingPeriod(
    int accountId,
  ) {
    return (select(creditCardBillingPeriodsTable)
          ..where(
            (tbl) =>
                tbl.accountId.equals(accountId) &
                tbl.status.equals(CreditCardBillingPeriodStatus.open.name),
          )
          ..limit(1))
        .getSingleOrNull();
  }

  Future<CreditCardStatementsTableData?> getStatementForBillingPeriod(
    int billingPeriodId,
  ) {
    return (select(creditCardStatementsTable)
          ..where((tbl) => tbl.billingPeriodId.equals(billingPeriodId))
          ..limit(1))
        .getSingleOrNull();
  }

  Future<List<CreditCardStatementsTableData>> getStatementsForAccount(
    int accountId,
  ) {
    return (select(creditCardStatementsTable).join([
            innerJoin(
              creditCardBillingPeriodsTable,
              creditCardBillingPeriodsTable.id.equalsExp(
                creditCardStatementsTable.billingPeriodId,
              ),
            ),
          ])
          ..where(creditCardBillingPeriodsTable.accountId.equals(accountId))
          ..orderBy([OrderingTerm.desc(creditCardStatementsTable.generatedAt)]))
        .map((row) => row.readTable(creditCardStatementsTable))
        .get();
  }

  Future<CreditCardStatementsTableData?> getLatestStatement(
    int accountId,
  ) async {
    final statements = await getStatementsForAccount(accountId);

    if (statements.isEmpty) {
      return null;
    }

    return statements.first;
  }

  Future<CreditCardStatementsTableData?> getLatestUnpaidStatement(
    int accountId,
  ) {
    return (select(creditCardStatementsTable).join([
            innerJoin(
              creditCardBillingPeriodsTable,
              creditCardBillingPeriodsTable.id.equalsExp(
                creditCardStatementsTable.billingPeriodId,
              ),
            ),
          ])
          ..where(
            creditCardBillingPeriodsTable.accountId.equals(accountId) &
                creditCardStatementsTable.status.equals(
                  CreditCardStatementStatus.unpaid.name,
                ),
          )
          ..orderBy([OrderingTerm.desc(creditCardBillingPeriodsTable.endDate)])
          ..limit(1))
        .map((row) => row.readTable(creditCardStatementsTable))
        .getSingleOrNull();
  }

  Future<int> createInitialBillingPeriod({
    required int accountId,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    return into(creditCardBillingPeriodsTable).insert(
      CreditCardBillingPeriodsTableCompanion.insert(
        accountId: accountId,
        startDate: startDate,
        endDate: endDate,
        status: CreditCardBillingPeriodStatus.open.name,
      ),
    );
  }

  Future<CreditCardDetailsTableData?> getByAccountId(int accountId) {
    return (select(
      creditCardDetailsTable,
    )..where((tbl) => tbl.accountId.equals(accountId))).getSingleOrNull();
  }

  /// Creates the billing configuration for a credit card.
  Future<int> insert(CreditCardDetailsTableCompanion details) {
    return into(creditCardDetailsTable).insert(details);
  }

  /// Advances the credit card by exactly one billing cycle.
  ///
  /// The recurring statement/payment days remain unchanged.
  /// Only the next concrete dates are updated.
  Future<CreditCardDetailsTableData?> advanceBillingCycle(int accountId) async {
    final details = await getByAccountId(accountId);

    if (details == null) {
      return null;
    }

    final nextStatementDate = CreditCardDates.advanceStatementDate(
      currentStatementDate: details.nextStatementDate,
      statementDay: details.statementDay,
    );

    final nextPaymentDueDate = CreditCardDates.advancePaymentDueDate(
      nextStatementDate: nextStatementDate,
      paymentDueDay: details.paymentDueDay,
    );

    await (update(
      creditCardDetailsTable,
    )..where((tbl) => tbl.accountId.equals(accountId))).write(
      CreditCardDetailsTableCompanion(
        nextStatementDate: Value(nextStatementDate),
        nextPaymentDueDate: Value(nextPaymentDueDate),
      ),
    );

    return getByAccountId(accountId);
  }
}
