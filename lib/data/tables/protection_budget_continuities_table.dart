import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/tables/cashflow_plan_table.dart';
import 'package:getx_drift_app/data/tables/protection_scenarios_table.dart';

class ProtectionBudgetContinuities extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get protectionScenarioId => integer().references(
    ProtectionScenariosTable,
    #id,
    onDelete: KeyAction.cascade,
  )();

  IntColumn get cashFlowPlanId =>
      integer().references(CashFlowPlans, #id, onDelete: KeyAction.cascade)();

  RealColumn get continuityShare => real()();
}
