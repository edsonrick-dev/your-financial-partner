// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_reservations_dao.dart';

// ignore_for_file: type=lint
mixin _$GoalReservationsDaoMixin on DatabaseAccessor<AppDatabase> {
  $AccountsTableTable get accountsTable => attachedDatabase.accountsTable;
  $GoalsTableTable get goalsTable => attachedDatabase.goalsTable;
  $GoalReservationsTableTable get goalReservationsTable =>
      attachedDatabase.goalReservationsTable;
  GoalReservationsDaoManager get managers => GoalReservationsDaoManager(this);
}

class GoalReservationsDaoManager {
  final _$GoalReservationsDaoMixin _db;
  GoalReservationsDaoManager(this._db);
  $$AccountsTableTableTableManager get accountsTable =>
      $$AccountsTableTableTableManager(_db.attachedDatabase, _db.accountsTable);
  $$GoalsTableTableTableManager get goalsTable =>
      $$GoalsTableTableTableManager(_db.attachedDatabase, _db.goalsTable);
  $$GoalReservationsTableTableTableManager get goalReservationsTable =>
      $$GoalReservationsTableTableTableManager(
        _db.attachedDatabase,
        _db.goalReservationsTable,
      );
}
