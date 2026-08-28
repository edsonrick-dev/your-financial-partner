import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/cashflow_plan_allocation_table.dart';
import 'package:getx_drift_app/data/tables/cashflow_plan_table.dart';
import 'package:getx_drift_app/data/tables/cashflow_categories_table.dart';

part 'cashflow_plan_dao.g.dart';

class CashflowPlanWithCategory {
  final CashFlowPlan plan;
  final CashflowCategoriesTableData category;
  final List<CashFlowPlanAllocation> allocations;

  const CashflowPlanWithCategory({
    required this.plan,
    required this.category,
    required this.allocations,
  });
}

@DriftAccessor(
  tables: [CashFlowPlans, CashFlowPlanAllocations, CashflowCategoriesTable],
)
class CashflowPlanDao extends DatabaseAccessor<AppDatabase>
    with _$CashflowPlanDaoMixin {
  CashflowPlanDao(super.db);

  // -----------------------------
  // Plans
  // -----------------------------

  Future<List<CashFlowPlan>> getAllPlans() {
    return select(cashFlowPlans).get();
  }

  Stream<bool> watchHasCashflowPlan() {
    final query = select(cashFlowPlans);

    return query.watch().map((plans) => plans.isNotEmpty);
  }

  Stream<List<CashflowPlanWithCategory>> watchAllPlansWithDetails() {
    final query =
        select(cashFlowPlans).join([
          innerJoin(
            cashflowCategoriesTable,
            cashflowCategoriesTable.id.equalsExp(cashFlowPlans.categoryId),
          ),
          leftOuterJoin(
            cashFlowPlanAllocations,
            cashFlowPlanAllocations.planId.equalsExp(cashFlowPlans.id),
          ),
        ])..orderBy([
          OrderingTerm.asc(cashFlowPlans.id),
          OrderingTerm.asc(cashFlowPlanAllocations.allocationIndex),
        ]);

    return query.watch().map((rows) {
      final plans = <int, CashflowPlanWithCategory>{};
      final allocations = <int, List<CashFlowPlanAllocation>>{};

      for (final row in rows) {
        final plan = row.readTable(cashFlowPlans);
        final category = row.readTable(cashflowCategoriesTable);

        plans.putIfAbsent(
          plan.id,
          () => CashflowPlanWithCategory(
            plan: plan,
            category: category,
            allocations: [],
          ),
        );

        final allocation = row.readTableOrNull(cashFlowPlanAllocations);

        if (allocation != null) {
          allocations.putIfAbsent(plan.id, () => []).add(allocation);
        }
      }

      return plans.values.map((savedPlan) {
        return CashflowPlanWithCategory(
          plan: savedPlan.plan,
          category: savedPlan.category,
          allocations: List.unmodifiable(
            allocations[savedPlan.plan.id] ?? const [],
          ),
        );
      }).toList();
    });
  }

  // Stream<List<CashflowPlanWithCategory>> watchIncomePlans() {
  //   final query =
  //       select(cashFlowPlans).join([
  //           innerJoin(
  //             cashflowCategoriesTable,
  //             cashflowCategoriesTable.id.equalsExp(cashFlowPlans.categoryId),
  //           ),
  //           leftOuterJoin(
  //             cashFlowPlanAllocations,
  //             cashFlowPlanAllocations.planId.equalsExp(cashFlowPlans.id),
  //           ),
  //         ])
  //         ..where(cashFlowPlans.planType.equals('income'))
  //         ..orderBy([
  //           OrderingTerm.asc(cashFlowPlans.id),
  //           OrderingTerm.asc(cashFlowPlanAllocations.allocationIndex),
  //         ]);

  //   return query.watch().map((rows) {
  //     final plans = <int, CashflowPlanWithCategory>{};
  //     final allocations = <int, List<CashFlowPlanAllocation>>{};

  //     for (final row in rows) {
  //       final plan = row.readTable(cashFlowPlans);
  //       final category = row.readTable(cashflowCategoriesTable);

  //       plans.putIfAbsent(
  //         plan.id,
  //         () => CashflowPlanWithCategory(
  //           plan: plan,
  //           category: category,
  //           allocations: [],
  //         ),
  //       );

  //       final allocation = row.readTableOrNull(cashFlowPlanAllocations);

  //       if (allocation != null) {
  //         allocations.putIfAbsent(plan.id, () => []).add(allocation);
  //       }
  //     }

  //     return plans.values.map((savedPlan) {
  //       return CashflowPlanWithCategory(
  //         plan: savedPlan.plan,
  //         category: savedPlan.category,
  //         allocations: List.unmodifiable(
  //           allocations[savedPlan.plan.id] ?? const [],
  //         ),
  //       );
  //     }).toList();
  //   });
  // }

  Future<int> insertPlan(CashFlowPlansCompanion entry) {
    return into(cashFlowPlans).insert(entry);
  }

  Future<void> deletePlan(int planId) async {
    await attachedDatabase.transaction(() async {
      await (delete(
        cashFlowPlanAllocations,
      )..where((tbl) => tbl.planId.equals(planId))).go();

      await (delete(cashFlowPlans)..where((tbl) => tbl.id.equals(planId))).go();
    });
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

  Future<void> insertAllocations(
    List<CashFlowPlanAllocationsCompanion> entries,
  ) async {
    await batch((batch) {
      batch.insertAll(cashFlowPlanAllocations, entries);
    });
  }
}
