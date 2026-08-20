import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/tables/cashflow_plan_table.dart';

class CashFlowPlanAllocations extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get planId =>
      integer().references(CashFlowPlans, #id, onDelete: KeyAction.cascade)();

  IntColumn get allocationKey => integer()();

  RealColumn get amount => real()();
}
