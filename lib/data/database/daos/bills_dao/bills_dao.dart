import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/data/tables/bills_table.dart';
import 'package:getx_drift_app/data/tables/bill_occurrences_table.dart';
import 'package:getx_drift_app/data/tables/cashflow_categories_table.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_payment_history.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_next_occurrence.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_category.dart';

part 'bills_dao.g.dart';

@DriftAccessor(
  tables: [BillsTable, BillOccurrencesTable, CashflowCategoriesTable],
)
class BillsDao extends DatabaseAccessor<AppDatabase> with _$BillsDaoMixin {
  BillsDao(super.db);
  Future<List<BillsTableData>> getActiveBillsForCategory(int categoryId) {
    return (select(billsTable)..where(
          (tbl) =>
              tbl.categoryId.equals(categoryId) & tbl.isActive.equals(true),
        ))
        .get();
  }

  Future<void> ensureFutureOccurrence(int billId) async {
    final bill = await getBillById(billId);

    if (bill == null || !bill.isActive) {
      return;
    }

    final occurrences = await getOccurrencesForBill(billId);

    if (occurrences.isEmpty) {
      return;
    }

    final latestOccurrence = occurrences.last;

    final nextDueDate = _calculateNextDueDate(
      bill: bill,
      from: latestOccurrence.dueDate,
    );

    final alreadyExists = occurrences.any(
      (occurrence) => _isSameDate(occurrence.dueDate, nextDueDate),
    );

    if (alreadyExists) {
      return;
    }

    await insertOccurrence(
      BillOccurrencesTableCompanion.insert(
        billId: billId,
        dueDate: nextDueDate,
        expectedAmount: bill.expectedAmount,
      ),
    );
  }

  DateTime _calculateNextDueDate({
    required BillsTableData bill,
    required DateTime from,
  }) {
    final frequency = BillsFrequency.values.firstWhere(
      (value) => value.name == bill.frequency,
    );

    switch (frequency) {
      case BillsFrequency.monthly:
        return _nextMonthlyDate(from: from, dayOfMonth: bill.dayOfMonth!);

      case BillsFrequency.quarterly:
      case BillsFrequency.semiAnnual:
      case BillsFrequency.annual:
        return _nextPatternDate(
          from: from,
          dayOfMonth: bill.dayOfMonth!,
          monthMask: bill.monthMask!,
        );

      case BillsFrequency.weekly:
      case BillsFrequency.biWeekly:
      case BillsFrequency.fortnightly:
        throw UnsupportedError(
          'Frequency ${frequency.name} is not currently supported for bills.',
        );
    }
  }

  DateTime _nextMonthlyDate({required DateTime from, required int dayOfMonth}) {
    final nextMonth = DateTime(from.year, from.month + 1, 1);

    final lastDay = DateTime(nextMonth.year, nextMonth.month + 1, 0).day;

    return DateTime(
      nextMonth.year,
      nextMonth.month,
      dayOfMonth.clamp(1, lastDay),
    );
  }

  DateTime _nextPatternDate({
    required DateTime from,
    required int dayOfMonth,
    required int monthMask,
  }) {
    var year = from.year;
    var month = from.month + 1;

    while (true) {
      if (month > 12) {
        month = 1;
        year++;
      }

      final isScheduledMonth = (monthMask & (1 << (month - 1))) != 0;

      if (isScheduledMonth) {
        final lastDay = DateTime(year, month + 1, 0).day;

        return DateTime(year, month, dayOfMonth.clamp(1, lastDay));
      }

      month++;
    }
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  Stream<List<BillPaymentHistory>> watchPaymentHistoryForBill(int billId) {
    final query =
        select(billOccurrencesTable).join([
            innerJoin(
              transactionsTable,
              transactionsTable.id.equalsExp(
                billOccurrencesTable.transactionId,
              ),
            ),
          ])
          ..where(
            billOccurrencesTable.billId.equals(billId) &
                billOccurrencesTable.isPaid.equals(true),
          )
          ..orderBy([
            OrderingTerm.desc(transactionsTable.date),
            OrderingTerm.desc(transactionsTable.createdAt),
          ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return BillPaymentHistory(
          occurrence: row.readTable(billOccurrencesTable),
          transaction: row.readTable(transactionsTable),
        );
      }).toList();
    });
  }

  Stream<List<BillWithNextOccurrence>> watchCurrentMonthOccurrences({
    required DateTime month,
  }) {
    final start = DateTime(month.year, month.month, 1);
    final end = DateTime(month.year, month.month + 1, 1);

    final query =
        select(billOccurrencesTable).join([
            innerJoin(
              billsTable,
              billsTable.id.equalsExp(billOccurrencesTable.billId),
            ),
            innerJoin(
              cashflowCategoriesTable,
              cashflowCategoriesTable.id.equalsExp(billsTable.categoryId),
            ),
          ])
          ..where(
            billOccurrencesTable.dueDate.isBiggerOrEqualValue(start) &
                billOccurrencesTable.dueDate.isSmallerThanValue(end),
          )
          ..orderBy([
            OrderingTerm.asc(billOccurrencesTable.isPaid),
            OrderingTerm.asc(billOccurrencesTable.dueDate),
          ]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return BillWithNextOccurrence(
          bill: row.readTable(billsTable),
          occurrence: row.readTable(billOccurrencesTable),
          category: row.readTable(cashflowCategoriesTable),
        );
      }).toList();
    });
  }

  Stream<List<BillWithCategory>> watchAllActiveBills() {
    final query =
        select(billsTable).join([
            innerJoin(
              cashflowCategoriesTable,
              cashflowCategoriesTable.id.equalsExp(billsTable.categoryId),
            ),
          ])
          ..where(billsTable.isActive.equals(true))
          ..orderBy([OrderingTerm.asc(billsTable.name)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return BillWithCategory(
          bill: row.readTable(billsTable),
          category: row.readTable(cashflowCategoriesTable),
        );
      }).toList();
    });
  }

  Future<void> unmarkOccurrenceAsPaid(int occurrenceId) async {
    await (update(
      billOccurrencesTable,
    )..where((tbl) => tbl.id.equals(occurrenceId))).write(
      BillOccurrencesTableCompanion(
        actualAmount: const Value(null),
        transactionId: const Value(null),
        isPaid: const Value(false),
      ),
    );
  }

  Future<void> markOccurrenceAsPaid({
    required int occurrenceId,
    required int transactionId,
    required double actualAmount,
  }) async {
    await (update(
      billOccurrencesTable,
    )..where((tbl) => tbl.id.equals(occurrenceId))).write(
      BillOccurrencesTableCompanion(
        actualAmount: Value(actualAmount),
        transactionId: Value(transactionId),
        isPaid: const Value(true),
      ),
    );
  }

  Stream<List<BillWithNextOccurrence>> watchBillsWithNextOccurrence() {
    final query =
        select(billsTable).join([
            innerJoin(
              cashflowCategoriesTable,
              cashflowCategoriesTable.id.equalsExp(billsTable.categoryId),
            ),
            innerJoin(
              billOccurrencesTable,
              billOccurrencesTable.billId.equalsExp(billsTable.id),
            ),
          ])
          ..where(
            billsTable.isActive.equals(true) &
                billOccurrencesTable.isPaid.equals(false),
          )
          ..orderBy([OrderingTerm.asc(billOccurrencesTable.dueDate)]);

    return query.watch().map((rows) {
      return rows.map((row) {
        return BillWithNextOccurrence(
          bill: row.readTable(billsTable),
          occurrence: row.readTable(billOccurrencesTable),
          category: row.readTable(cashflowCategoriesTable),
        );
      }).toList();
    });
  }

  // Future<void> debugPrintBills() async {
  //   final bills = await select(billsTable).get();

  //   for (final bill in bills) {
  //     print('========== BILL ==========');
  //     print('id: ${bill.id}');
  //     print('name: ${bill.name}');
  //     print('categoryId: ${bill.categoryId}');
  //     print('expectedAmount: ${bill.expectedAmount}');
  //     print('frequency: ${bill.frequency}');
  //     print('dayOfMonth: ${bill.dayOfMonth}');
  //     print('monthMask: ${bill.monthMask}');
  //     print('reminderEnabled: ${bill.reminderEnabled}');
  //     print('reminderDaysBefore: ${bill.reminderDaysBefore}');
  //   }
  // }

  // Future<void> debugPrintOccurrences() async {
  //   final occurrences = await select(billOccurrencesTable).get();

  //   for (final occurrence in occurrences) {
  //     print('========== OCCURRENCE ==========');
  //     print('id: ${occurrence.id}');
  //     print('billId: ${occurrence.billId}');
  //     print('dueDate: ${occurrence.dueDate}');
  //     print('expectedAmount: ${occurrence.expectedAmount}');
  //     print('actualAmount: ${occurrence.actualAmount}');
  //     print('isPaid: ${occurrence.isPaid}');
  //     print('transactionId: ${occurrence.transactionId}');
  //   }
  // }
  // -----------------------------
  // Bills
  // -----------------------------

  Future<int> insertBill(BillsTableCompanion entry) {
    return into(billsTable).insert(entry);
  }

  Future<BillsTableData?> getBillById(int billId) {
    return (select(
      billsTable,
    )..where((tbl) => tbl.id.equals(billId))).getSingleOrNull();
  }

  Future<List<BillsTableData>> getAllBills() {
    return select(billsTable).get();
  }

  Stream<List<BillsTableData>> watchAllBills() {
    return (select(
      billsTable,
    )..where((tbl) => tbl.isActive.equals(true))).watch();
  }

  Future<void> updateBill(int billId, BillsTableCompanion entry) async {
    await (update(
      billsTable,
    )..where((tbl) => tbl.id.equals(billId))).write(entry);
  }

  Future<void> deleteBill(int billId) async {
    await attachedDatabase.transaction(() async {
      await (delete(
        billOccurrencesTable,
      )..where((tbl) => tbl.billId.equals(billId))).go();

      await (delete(billsTable)..where((tbl) => tbl.id.equals(billId))).go();
    });
  }

  // -----------------------------
  // Occurrences
  // -----------------------------
  Future<BillOccurrencesTableData?> getOccurrenceByTransactionId(
    int transactionId,
  ) {
    return (select(billOccurrencesTable)
          ..where((tbl) => tbl.transactionId.equals(transactionId)))
        .getSingleOrNull();
  }

  Future<List<BillOccurrencesTableData>> getAllBillOccurrences() {
    return select(billOccurrencesTable).get();
  }

  Future<void> insertBillWithFirstOccurrence({
    required BillsTableCompanion bill,
    required DateTime dueDate,
    required double expectedAmount,
  }) async {
    await attachedDatabase.transaction(() async {
      final billId = await into(billsTable).insert(bill);

      await into(billOccurrencesTable).insert(
        BillOccurrencesTableCompanion.insert(
          billId: billId,
          dueDate: dueDate,
          expectedAmount: expectedAmount,
        ),
      );
    });
  }

  Future<int> insertOccurrence(BillOccurrencesTableCompanion entry) {
    return into(billOccurrencesTable).insert(entry);
  }

  Future<List<BillOccurrencesTableData>> getOccurrencesForBill(int billId) {
    return (select(billOccurrencesTable)
          ..where((tbl) => tbl.billId.equals(billId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.dueDate)]))
        .get();
  }

  Stream<List<BillOccurrencesTableData>> watchOccurrencesForBill(int billId) {
    return (select(billOccurrencesTable)
          ..where((tbl) => tbl.billId.equals(billId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.dueDate)]))
        .watch();
  }

  Future<BillOccurrencesTableData?> getOccurrenceById(int occurrenceId) {
    return (select(
      billOccurrencesTable,
    )..where((tbl) => tbl.id.equals(occurrenceId))).getSingleOrNull();
  }

  Future<void> updateOccurrence(
    int occurrenceId,
    BillOccurrencesTableCompanion entry,
  ) async {
    await (update(
      billOccurrencesTable,
    )..where((tbl) => tbl.id.equals(occurrenceId))).write(entry);
  }
}
