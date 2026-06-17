import 'package:drift/drift.dart';
import 'package:getx_drift_app/core/utils/date_grouping.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/entity_type_enum.dart';
import 'package:getx_drift_app/data/models/person_balance_summary_model.dart';
import 'package:getx_drift_app/data/models/person_debt_activity.dart';
import 'package:getx_drift_app/data/tables/entities_table.dart';
import 'package:getx_drift_app/data/tables/financial_obligations_table.dart';
import 'package:getx_drift_app/data/tables/transactions_table.dart';

part 'people_balance_dao.g.dart';

@DriftAccessor(
  tables: [EntitiesTable, FinancialObligationsTable, TransactionsTable],
)
class PeopleBalanceDao extends DatabaseAccessor<AppDatabase>
    with _$PeopleBalanceDaoMixin {
  PeopleBalanceDao(super.db);
  Future<PersonBalanceSummary?> _buildPersonBalance(int personId) async {
    final me = await db.entitiesDao.getCurrentUserEntity();

    if (me == null) return null;

    final person = await db.entitiesDao.getEntityById(personId);

    if (person == null) return null;

    double receivable = 0;
    double payable = 0;

    final obligations = await select(financialObligationsTable).get();

    for (final item in obligations) {
      if (item.creditorEntityId == me.id && item.debtorEntityId == personId) {
        receivable += item.amount;
      }

      if (item.debtorEntityId == me.id && item.creditorEntityId == personId) {
        payable += item.amount;
      }
    }

    return PersonBalanceSummary(
      entity: person,
      receivable: receivable,
      payable: payable,
    );
  }

  Future<PersonBalanceSummary?> getPersonBalance(int personId) {
    return _buildPersonBalance(personId);
  }

  Stream<PersonBalanceSummary?> watchPersonBalance(int personId) {
    return select(
      financialObligationsTable,
    ).watch().asyncMap((_) => _buildPersonBalance(personId));
  }

  Stream<List<PersonDebtActivity>> watchPersonDebtActivity(int personId) {
    return select(financialObligationsTable).watch().asyncMap((_) async {
      final me = await db.entitiesDao.getCurrentUserEntity();

      if (me == null) {
        return [];
      }

      final obligations =
          await (select(financialObligationsTable)..where(
                (tbl) =>
                    (tbl.creditorEntityId.equals(me.id) &
                        tbl.debtorEntityId.equals(personId)) |
                    (tbl.creditorEntityId.equals(personId) &
                        tbl.debtorEntityId.equals(me.id)),
              ))
              .get();

      // final result = <PersonDebtActivity>[];

      // obligations.sort((a, b) {
      //   return a.createdAt.compareTo(b.createdAt);
      // });

      // double balance = 0;

      // for (final obligation in obligations) {
      //   final transaction =
      //       await (select(transactionsTable)
      //             ..where((tbl) => tbl.id.equals(obligation.transactionId)))
      //           .getSingleOrNull();

      //   if (transaction == null) continue;

      //   final isReceivable = obligation.creditorEntityId == me.id;

      //   if (isReceivable) {
      //     balance += obligation.amount;
      //   } else {
      //     balance -= obligation.amount;
      //   }

      //   result.add(
      //     PersonDebtActivity(
      //       obligation: obligation,
      //       transaction: transaction,
      //       isReceivable: isReceivable,
      //       runningBalance: balance,
      //     ),
      //   );
      // }

      final activities = <PersonDebtActivity>[];

      for (final obligation in obligations) {
        final transaction =
            await (select(transactionsTable)
                  ..where((tbl) => tbl.id.equals(obligation.transactionId)))
                .getSingleOrNull();

        if (transaction == null) continue;

        activities.add(
          PersonDebtActivity(
            obligation: obligation,
            transaction: transaction,
            isReceivable: obligation.creditorEntityId == me.id,
            runningBalance: 0, // temporary
          ),
        );
      }
      activities.sort(
        (a, b) => a.transaction.date.compareTo(b.transaction.date),
      );
      // result.sort((a, b) => b.transaction.date.compareTo(a.transaction.date));
      // result.sort((a, b) => b.transaction.date.compareTo(a.transaction.date));
      double balance = 0;

      final result = <PersonDebtActivity>[];

      for (final activity in activities) {
        if (activity.isReceivable) {
          balance += activity.obligation.amount;
        } else {
          balance -= activity.obligation.amount;
        }

        result.add(
          PersonDebtActivity(
            obligation: activity.obligation,
            transaction: activity.transaction,
            isReceivable: activity.isReceivable,
            runningBalance: balance,
          ),
        );
      }
      result.sort((a, b) => b.transaction.date.compareTo(a.transaction.date));

      return result;
    });
  }

  Stream<Map<String, List<PersonDebtActivity>>> watchGroupedPersonDebtActivity(
    int personId,
  ) {
    return watchPersonDebtActivity(personId).map((activities) {
      final grouped = <DateTime, List<PersonDebtActivity>>{};

      for (final item in activities) {
        final date = item.transaction.date;

        final normalizedDate = DateTime(date.year, date.month, date.day);

        grouped.putIfAbsent(normalizedDate, () => []);

        grouped[normalizedDate]!.add(item);
      }

      final sortedEntries = grouped.entries.toList()
        ..sort((a, b) => b.key.compareTo(a.key));

      final result = <String, List<PersonDebtActivity>>{};

      for (final entry in sortedEntries) {
        result[DateGrouping.label(entry.key)] = entry.value;
      }

      return result;
    });
  }

  Future<List<PersonBalanceSummary>> getPeopleBalances({
    bool includeSettled = true,
  }) async {
    final people = await (select(
      entitiesTable,
    )..where((tbl) => tbl.entityType.equals(EntityType.person.name))).get();

    // final currentUserId = await getCurrentUserId();
    final me = await (select(
      entitiesTable,
    )..where((tbl) => tbl.name.equals('Me'))).getSingle();

    final currentUserId = me.id;

    final result = <PersonBalanceSummary>[];

    for (final person in people) {
      if (person.id == currentUserId) continue;

      /// THEY OWE ME
      final receivableRows =
          await (select(financialObligationsTable)..where(
                (tbl) =>
                    tbl.creditorEntityId.equals(currentUserId) &
                    tbl.debtorEntityId.equals(person.id),
              ))
              .get();

      /// I OWE THEM
      final payableRows =
          await (select(financialObligationsTable)..where(
                (tbl) =>
                    tbl.creditorEntityId.equals(person.id) &
                    tbl.debtorEntityId.equals(currentUserId),
              ))
              .get();

      final receivable = receivableRows.fold<double>(
        0,
        (sum, row) => sum + row.amount,
      );

      final payable = payableRows.fold<double>(
        0,
        (sum, row) => sum + row.amount,
      );
      final net = receivable - payable;

      if (!includeSettled && net == 0) continue;
      result.add(
        PersonBalanceSummary(
          entity: person,
          receivable: receivable,
          payable: payable,
        ),
      );
    }
    result.sort((a, b) => b.netBalance.abs().compareTo(a.netBalance.abs()));

    ///Change this if you want change in sorting
    return result;
  }

  Stream<List<PersonBalanceSummary>> watchPeopleBalances({
    bool includeSettled = true,
  }) {
    return select(financialObligationsTable).watch().asyncMap((_) async {
      return getPeopleBalances(includeSettled: includeSettled);
    });
  }
}
