import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/tables/accounts_table.dart';
import 'package:getx_drift_app/data/tables/goals_table.dart';

class GoalReservationsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get accountId => integer().references(AccountsTable, #id)();

  IntColumn get goalId => integer().references(GoalsTable, #id)();

  RealColumn get amount => real().withDefault(const Constant(0))();
}
