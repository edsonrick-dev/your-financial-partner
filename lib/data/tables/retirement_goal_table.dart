import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/tables/goals_table.dart';

class RetirementGoalsTable extends Table {
  IntColumn get goalId => integer().references(GoalsTable, #id)();

  IntColumn get retirementAge => integer()();

  IntColumn get fundEndAge => integer()();

  @override
  Set<Column> get primaryKey => {goalId};
}
