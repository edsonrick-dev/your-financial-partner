import 'package:drift/drift.dart';
import 'package:flutter/rendering.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/goal_reservations_table.dart';
import 'package:getx_drift_app/data/tables/goals_table.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/cash_and_bank_details_sheet/cash_and_bank_reservation_view.dart';

part 'goal_reservations_dao.g.dart';

@DriftAccessor(tables: [GoalReservationsTable, GoalsTable])
class GoalReservationsDao extends DatabaseAccessor<AppDatabase>
    with _$GoalReservationsDaoMixin {
  GoalReservationsDao(super.db);

  Future<List<GoalReservationWithGoal>> getReservationsWithGoalsForAccount(
    int accountId,
  ) async {
    final query = select(goalReservationsTable).join([
      innerJoin(
        goalsTable,
        goalsTable.id.equalsExp(goalReservationsTable.goalId),
      ),
    ])..where(goalReservationsTable.accountId.equals(accountId));

    final rows = await query.get();

    return rows.map((row) {
      return GoalReservationWithGoal(
        reservation: row.readTable(goalReservationsTable),
        goal: row.readTable(goalsTable),
      );
    }).toList();
  }

  Stream<List<GoalReservationWithGoal>> watchReservationsWithGoalsForAccount(
    int accountId,
  ) {
    final query =
        select(goalReservationsTable).join([
          innerJoin(
            goalsTable,
            goalsTable.id.equalsExp(goalReservationsTable.goalId),
          ),
        ])..where(
          goalReservationsTable.accountId.equals(accountId) &
              goalReservationsTable.amount.isBiggerThanValue(0),
        );

    return query.watch().map((rows) {
      return rows.map((row) {
        return GoalReservationWithGoal(
          reservation: row.readTable(goalReservationsTable),
          goal: row.readTable(goalsTable),
        );
      }).toList();
    });
  }

  Future<void> upsertReservation({
    required int accountId,
    required int goalId,
    required double amount,
  }) async {
    debugPrint('UPSERT → account=$accountId, goal=$goalId, amount=$amount');

    final existing = await getReservation(accountId: accountId, goalId: goalId);

    if (existing == null) {
      debugPrint('No existing reservation → INSERT');

      final id = await insertReservation(
        GoalReservationsTableCompanion.insert(
          accountId: accountId,
          goalId: goalId,
          amount: Value(amount),
        ),
      );

      debugPrint('Inserted reservation ID: $id');
      return;
    }

    debugPrint(
      'Existing reservation → '
      'id=${existing.id}, '
      'oldAmount=${existing.amount}',
    );

    await updateReservation(existing.copyWith(amount: amount));

    debugPrint('Updated reservation ID: ${existing.id}');
  }

  Future<int> insertReservation(GoalReservationsTableCompanion reservation) {
    return into(goalReservationsTable).insert(reservation);
  }

  // Future<void> upsertReservation({
  //   required int accountId,
  //   required int goalId,
  //   required double amount,
  // }) async {
  //   final existing = await getReservation(accountId: accountId, goalId: goalId);

  //   if (existing == null) {
  //     await insertReservation(
  //       GoalReservationsTableCompanion.insert(
  //         accountId: accountId,
  //         goalId: goalId,
  //         amount: Value(amount),
  //       ),
  //     );
  //     return;
  //   }

  //   await updateReservation(existing.copyWith(amount: amount));
  // }

  Future<GoalReservationsTableData?> getReservation({
    required int accountId,
    required int goalId,
  }) {
    return (select(goalReservationsTable)..where(
          (tbl) => tbl.accountId.equals(accountId) & tbl.goalId.equals(goalId),
        ))
        .getSingleOrNull();
  }

  Stream<GoalReservationsTableData?> watchReservation({
    required int accountId,
    required int goalId,
  }) {
    return (select(goalReservationsTable)..where(
          (tbl) => tbl.accountId.equals(accountId) & tbl.goalId.equals(goalId),
        ))
        .watchSingleOrNull();
  }

  Future<List<GoalReservationsTableData>> getReservationsForAccount(
    int accountId,
  ) {
    return (select(
      goalReservationsTable,
    )..where((tbl) => tbl.accountId.equals(accountId))).get();
  }

  Stream<List<GoalReservationsTableData>> watchReservationsForAccount(
    int accountId,
  ) {
    return (select(
      goalReservationsTable,
    )..where((tbl) => tbl.accountId.equals(accountId))).watch();
  }

  Future<List<GoalReservationsTableData>> getReservationsForGoal(int goalId) {
    return (select(
      goalReservationsTable,
    )..where((tbl) => tbl.goalId.equals(goalId))).get();
  }

  Stream<List<GoalReservationsTableData>> watchReservationsForGoal(int goalId) {
    return (select(
      goalReservationsTable,
    )..where((tbl) => tbl.goalId.equals(goalId))).watch();
  }

  Future<double> getTotalReservedForAccount(int accountId) async {
    final query = selectOnly(goalReservationsTable)
      ..addColumns([goalReservationsTable.amount.sum()])
      ..where(goalReservationsTable.accountId.equals(accountId));

    final result = await query.getSingle();

    return result.read(goalReservationsTable.amount.sum()) ?? 0;
  }

  Stream<double> watchTotalReservedForAccount(int accountId) {
    final query = selectOnly(goalReservationsTable)
      ..addColumns([goalReservationsTable.amount.sum()])
      ..where(
        goalReservationsTable.accountId.equals(accountId) &
            goalReservationsTable.amount.isBiggerThanValue(0),
      );

    return query.watchSingle().map(
      (row) => row.read(goalReservationsTable.amount.sum()) ?? 0.0,
    );
  }

  Future<double> getTotalReservedForGoal(int goalId) async {
    final query = selectOnly(goalReservationsTable)
      ..addColumns([goalReservationsTable.amount.sum()])
      ..where(goalReservationsTable.goalId.equals(goalId));

    final result = await query.getSingle();

    return result.read(goalReservationsTable.amount.sum()) ?? 0;
  }

  Future<bool> updateReservation(GoalReservationsTableData reservation) {
    return update(goalReservationsTable).replace(reservation);
  }

  Future<int> deleteReservation(int id) {
    return (delete(
      goalReservationsTable,
    )..where((tbl) => tbl.id.equals(id))).go();
  }
}
