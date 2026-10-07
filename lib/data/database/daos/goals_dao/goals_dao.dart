import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/goals_table.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';

part 'goals_dao.g.dart';

@DriftAccessor(tables: [GoalsTable])
class GoalsDao extends DatabaseAccessor<AppDatabase> with _$GoalsDaoMixin {
  GoalsDao(super.db);
  Future<GoalsTableData> getOrCreateGoal(GoalType type) async {
    final existing = await getGoalByType(type);

    if (existing != null) {
      return existing;
    }

    final id = await insertGoal(
      GoalsTableCompanion.insert(type: type.name, targetAmount: const Value(0)),
    );

    return (select(goalsTable)..where((tbl) => tbl.id.equals(id))).getSingle();
  }

  Future<int> insertGoal(GoalsTableCompanion goal) {
    return into(goalsTable).insert(goal);
  }

  Future<GoalsTableData?> getGoalById(int id) {
    return (select(
      goalsTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Stream<GoalsTableData?> watchGoalById(int id) {
    return (select(
      goalsTable,
    )..where((tbl) => tbl.id.equals(id))).watchSingleOrNull();
  }

  Future<GoalsTableData?> getGoalByType(GoalType type) {
    return (select(
      goalsTable,
    )..where((tbl) => tbl.type.equals(type.name))).getSingleOrNull();
  }

  Stream<GoalsTableData?> watchGoalByType(GoalType type) {
    return (select(
      goalsTable,
    )..where((tbl) => tbl.type.equals(type.name))).watchSingleOrNull();
  }

  Future<List<GoalsTableData>> getAllGoals() {
    return select(goalsTable).get();
  }

  Stream<List<GoalsTableData>> watchAllGoals() {
    return select(goalsTable).watch();
  }

  Future<bool> updateGoal(GoalsTableData goal) {
    return update(goalsTable).replace(goal);
  }

  Future<int> deleteGoal(int id) {
    return (delete(goalsTable)..where((tbl) => tbl.id.equals(id))).go();
  }
}
