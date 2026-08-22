import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/cashflow_plan_allocation_table.dart';
import 'package:getx_drift_app/data/tables/cashflow_plan_table.dart';

part 'cashflow_plan_dao.g.dart';

@DriftAccessor(tables: [CashFlowPlans, CashFlowPlanAllocations])
class CashflowPlanDao extends DatabaseAccessor<AppDatabase>
    with _$CashflowPlanDaoMixin {
  CashflowPlanDao(super.db);

  // -----------------------------
  // Plans
  // -----------------------------

  Future<List<CashFlowPlan>> getAllPlans() {
    return select(cashFlowPlans).get();
  }

  Stream<List<CashFlowPlan>> watchAllPlans() {
    return select(cashFlowPlans).watch();
  }

  // -----------------------------
  // Allocations
  // -----------------------------

  Future<List<CashFlowPlanAllocation>> getAllocationsForPlan(int planId) {
    return (select(cashFlowPlanAllocations)
          ..where((tbl) => tbl.planId.equals(planId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.allocationIndex)]))
        .get();
  }

  Stream<List<CashFlowPlanAllocation>> watchAllocationsForPlan(int planId) {
    return (select(cashFlowPlanAllocations)
          ..where((tbl) => tbl.planId.equals(planId))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.allocationIndex)]))
        .watch();
  }
}
