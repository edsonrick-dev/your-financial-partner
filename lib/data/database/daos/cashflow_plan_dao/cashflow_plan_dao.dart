import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/cashflow_plan_allocation_table.dart';
import 'package:getx_drift_app/data/tables/cashflow_plan_metadata_table.dart';
import 'package:getx_drift_app/data/tables/cashflow_plan_table.dart';
import 'package:getx_drift_app/data/tables/cashflow_categories_table.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';

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
  tables: [
    CashFlowPlans,
    CashFlowPlanAllocations,
    CashflowCategoriesTable,
    CashflowPlanMetadata,
  ],
)
class CashflowPlanDao extends DatabaseAccessor<AppDatabase>
    with _$CashflowPlanDaoMixin {
  CashflowPlanDao(super.db);

  Future<void> _incrementCashflowRevision() async {
    final metadata = await (select(
      cashflowPlanMetadata,
    )..where((tbl) => tbl.id.equals(1))).getSingle();

    await (update(
      cashflowPlanMetadata,
    )..where((tbl) => tbl.id.equals(1))).write(
      CashflowPlanMetadataCompanion(
        revision: Value(metadata.revision + 1),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<int> getCashflowRevision() async {
    final metadata = await (select(
      cashflowPlanMetadata,
    )..where((tbl) => tbl.id.equals(1))).getSingle();

    return metadata.revision;
  }

  Future<bool> updatePlan({
    required int planId,
    required int categoryId,
    required String planType,
    required double amount,
    required String period,
    required String distributionType,
    required DateTime updatedAt,
  }) async {
    return transaction(() async {
      final updated =
          await (update(
            cashFlowPlans,
          )..where((tbl) => tbl.id.equals(planId))).write(
            CashFlowPlansCompanion(
              categoryId: Value(categoryId),
              planType: Value(planType),
              amount: Value(amount),
              period: Value(period),
              distributionType: Value(distributionType),
              updatedAt: Value(updatedAt),
            ),
          );

      if (updated > 0) {
        await _incrementCashflowRevision();
      }

      return updated > 0;
    });
  }

  Future<void> deleteAllocationsForPlan(int planId) async {
    await (delete(
      cashFlowPlanAllocations,
    )..where((tbl) => tbl.planId.equals(planId))).go();
  }

  Future<void> convertPlanToYearlyCustom({
    required int planId,
    required List<double> monthlyAllocations,
  }) async {
    if (monthlyAllocations.length != 12) {
      throw ArgumentError(
        'Yearly custom distribution must contain 12 allocations.',
      );
    }

    await transaction(() async {
      await (update(
        cashFlowPlans,
      )..where((tbl) => tbl.id.equals(planId))).write(
        CashFlowPlansCompanion(
          amount: const Value(0),
          period: Value(BudgetPeriod.yearly.name),
          distributionType: Value(CashFlowDistribution.custom.name),
          updatedAt: Value(DateTime.now()),
        ),
      );

      await (delete(
        cashFlowPlanAllocations,
      )..where((tbl) => tbl.planId.equals(planId))).go();

      await batch((batch) {
        batch.insertAll(
          cashFlowPlanAllocations,
          List.generate(
            12,
            (index) => CashFlowPlanAllocationsCompanion.insert(
              planId: planId,
              allocationIndex: index,
              amount: monthlyAllocations[index],
            ),
          ),
        );
      });

      await _incrementCashflowRevision();
    });
  }

  Future<List<CashflowPlanWithCategory>> getExpensePlansForCategory(
    int categoryId,
  ) async {
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
          ])
          ..where(
            cashFlowPlans.categoryId.equals(categoryId) &
                cashFlowPlans.planType.equals('expense'),
          )
          ..orderBy([
            OrderingTerm.asc(cashFlowPlans.id),
            OrderingTerm.asc(cashFlowPlanAllocations.allocationIndex),
          ]);

    final rows = await query.get();

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
  }

  Future<bool> updatePlanAmount({
    required int planId,
    required double amount,
  }) async {
    return transaction(() async {
      final updated =
          await (update(
            cashFlowPlans,
          )..where((tbl) => tbl.id.equals(planId))).write(
            CashFlowPlansCompanion(
              amount: Value(amount),
              updatedAt: Value(DateTime.now()),
            ),
          );

      if (updated > 0) {
        await _incrementCashflowRevision();
      }

      return updated > 0;
    });
  }
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

  Future<int> insertPlan(CashFlowPlansCompanion entry) async {
    return transaction(() async {
      final id = await into(cashFlowPlans).insert(entry);

      await _incrementCashflowRevision();

      return id;
    });
  }

  Future<void> deletePlan(int planId) async {
    await attachedDatabase.transaction(() async {
      await (delete(
        cashFlowPlanAllocations,
      )..where((tbl) => tbl.planId.equals(planId))).go();

      await (delete(cashFlowPlans)..where((tbl) => tbl.id.equals(planId))).go();

      await _incrementCashflowRevision();
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
    await transaction(() async {
      await batch((batch) {
        batch.insertAll(cashFlowPlanAllocations, entries);
      });

      await _incrementCashflowRevision();
    });
  }
}
