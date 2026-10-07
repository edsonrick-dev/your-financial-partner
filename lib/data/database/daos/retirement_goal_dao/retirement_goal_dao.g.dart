// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'retirement_goal_dao.dart';

// ignore_for_file: type=lint
mixin _$RetirementGoalDaoMixin on DatabaseAccessor<AppDatabase> {
  $GoalsTableTable get goalsTable => attachedDatabase.goalsTable;
  $RetirementGoalsTableTable get retirementGoalsTable =>
      attachedDatabase.retirementGoalsTable;
  RetirementGoalDaoManager get managers => RetirementGoalDaoManager(this);
}

class RetirementGoalDaoManager {
  final _$RetirementGoalDaoMixin _db;
  RetirementGoalDaoManager(this._db);
  $$GoalsTableTableTableManager get goalsTable =>
      $$GoalsTableTableTableManager(_db.attachedDatabase, _db.goalsTable);
  $$RetirementGoalsTableTableTableManager get retirementGoalsTable =>
      $$RetirementGoalsTableTableTableManager(
        _db.attachedDatabase,
        _db.retirementGoalsTable,
      );
}
