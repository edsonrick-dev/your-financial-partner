import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/retirement_goal_table.dart';

part 'retirement_goal_dao.g.dart';

@DriftAccessor(tables: [RetirementGoalsTable])
class RetirementGoalDao extends DatabaseAccessor<AppDatabase>
    with _$RetirementGoalDaoMixin {
  RetirementGoalDao(super.db);

  Future<RetirementGoalsTableData?> getByGoalId(int goalId) {
    return (select(
      retirementGoalsTable,
    )..where((tbl) => tbl.goalId.equals(goalId))).getSingleOrNull();
  }

  Future<void> save({
    required int goalId,
    required int retirementAge,
    required int fundEndAge,
  }) async {
    await into(retirementGoalsTable).insertOnConflictUpdate(
      RetirementGoalsTableCompanion(
        goalId: Value(goalId),
        retirementAge: Value(retirementAge),
        fundEndAge: Value(fundEndAge),
      ),
    );
  }
}
