import 'package:drift/drift.dart';
import 'package:flutter/foundation.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/protection_scenarios_table.dart';
import 'package:getx_drift_app/data/tables/protection_budget_continuities_table.dart';
import 'package:getx_drift_app/data/tables/protection_dependency_table.dart';
import 'package:getx_drift_app/data/tables/expense_continuity_table.dart';
import 'package:getx_drift_app/data/tables/protection_needs_table.dart';
import 'package:getx_drift_app/data/tables/protection_plan_continuity_shares_table.dart';
import 'package:getx_drift_app/data/tables/protection_plans_table.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/2_financial_dependency_questionnaire/financial_dependency_question.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/1_protection_horizon_questionnaire/models/protection_horizon_answers.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';

part 'protection_dao.g.dart';

@DriftAccessor(
  tables: [
    ProtectionScenariosTable,
    ProtectionBudgetContinuities,
    ProtectionDependencyTable,

    ExpenseContinuityTable,
    ProtectionNeedsTable,
    ProtectionPlanContinuitySharesTable,
    ProtectionPlansTable,
  ],
)
class ProtectionDao extends DatabaseAccessor<AppDatabase>
    with _$ProtectionDaoMixin {
  ProtectionDao(super.db);
  Future<ExpenseContinuityTableData?> getExpenseContinuity({
    required int protectionPlanId,
    required ProtectionType protectionType,
  }) async {
    final need = await getProtectionNeed(
      protectionPlanId: protectionPlanId,
      protectionType: protectionType,
      needType: ProtectionNeedType.expenseContinuity,
    );

    if (need == null) return null;

    return (select(
      expenseContinuityTable,
    )..where((tbl) => tbl.protectionNeedId.equals(need.id))).getSingleOrNull();
  }

  Future<void> updateExpenseContinuityMonthlyExpense({
    required int protectionNeedId,
    required double monthlyExpense,
  }) async {
    await (update(
      expenseContinuityTable,
    )..where((tbl) => tbl.protectionNeedId.equals(protectionNeedId))).write(
      ExpenseContinuityTableCompanion(monthlyExpense: Value(monthlyExpense)),
    );
  }

  Future<double?> getExpenseContinuityMonthlyExpense({
    required int protectionPlanId,
    required ProtectionType protectionType,
  }) async {
    final need = await getProtectionNeed(
      protectionPlanId: protectionPlanId,
      protectionType: protectionType,
      needType: ProtectionNeedType.expenseContinuity,
    );

    if (need == null) return null;

    final result = await (select(
      expenseContinuityTable,
    )..where((tbl) => tbl.protectionNeedId.equals(need.id))).getSingleOrNull();

    return result?.monthlyExpense;
  }

  Future<void> saveExpenseContinuity({
    required int protectionPlanId,
    required ProtectionType protectionType,
    required int protectionHorizon,
    required double monthlyExpense,
    required int planValidityYears,
    required double investedNeed,
    required double uninvestedNeed,
    required int calculationVersion,
  }) async {
    await transaction(() async {
      final now = DateTime.now();

      // Find the existing expense-continuity need.
      final existingNeed =
          await (select(protectionNeedsTable)..where(
                (tbl) =>
                    tbl.protectionPlanId.equals(protectionPlanId) &
                    tbl.protectionType.equals(protectionType.name) &
                    tbl.protectionNeedType.equals(
                      ProtectionNeedType.expenseContinuity.name,
                    ),
              ))
              .getSingleOrNull();

      late final int protectionNeedId;

      if (existingNeed == null) {
        // Create the protection need for the first time.
        protectionNeedId = await into(protectionNeedsTable).insert(
          ProtectionNeedsTableCompanion.insert(
            protectionPlanId: protectionPlanId,
            protectionType: protectionType.name,
            protectionNeedType: ProtectionNeedType.expenseContinuity.name,
            amount: Value(investedNeed),
            createdAt: now,
            updatedAt: now,
          ),
        );
      } else {
        // Update the existing need without changing createdAt.
        protectionNeedId = existingNeed.id;

        await (update(
          protectionNeedsTable,
        )..where((tbl) => tbl.id.equals(protectionNeedId))).write(
          ProtectionNeedsTableCompanion(
            amount: Value(investedNeed),
            updatedAt: Value(now),
          ),
        );
      }

      // Insert a new calculation or update the existing calculation.
      await into(expenseContinuityTable).insertOnConflictUpdate(
        ExpenseContinuityTableCompanion.insert(
          protectionNeedId: Value(protectionNeedId),
          protectionHorizon: protectionHorizon,
          monthlyExpense: monthlyExpense,
          planValidityYears: planValidityYears,
          investedNeed: investedNeed,
          uninvestedNeed: uninvestedNeed,
          calculationVersion: calculationVersion,
          calculatedAt: Value(now),
        ),
      );
    });
  }

  Future<ProtectionNeedsTableData?> getProtectionNeed({
    required int protectionPlanId,
    required ProtectionType protectionType,
    required ProtectionNeedType needType,
  }) {
    return (select(protectionNeedsTable)..where(
          (tbl) =>
              tbl.protectionPlanId.equals(protectionPlanId) &
              tbl.protectionType.equals(protectionType.name) &
              tbl.protectionNeedType.equals(needType.name),
        ))
        .getSingleOrNull();
  }

  Future<Set<ProtectionNeedType>> getExistingNeedTypes({
    required int protectionPlanId,
    required ProtectionType protectionType,
  }) async {
    final query = select(protectionNeedsTable)
      ..where(
        (tbl) =>
            tbl.protectionPlanId.equals(protectionPlanId) &
            tbl.protectionType.equals(protectionType.name),
      );

    final records = await query.get();

    return records
        .map(
          (record) => ProtectionNeedType.values.firstWhere(
            (type) => type.name == record.protectionNeedType,
          ),
        )
        .toSet();
  }

  Future<bool> isProtectionGapComplete({
    required int protectionPlanId,
    required ProtectionType protectionType,
  }) async {
    final existingNeeds = await getExistingNeedTypes(
      protectionPlanId: protectionPlanId,
      protectionType: protectionType,
    );

    return protectionType.requiredNeeds.every(
      (requiredNeed) => existingNeeds.contains(requiredNeed),
    );
  }

  Future<bool> isProtectionPlannerComplete({
    required int protectionPlanId,
  }) async {
    for (final protectionType in ProtectionType.values) {
      final isComplete = await isProtectionGapComplete(
        protectionPlanId: protectionPlanId,
        protectionType: protectionType,
      );

      if (!isComplete) return false;
    }

    return true;
  }

  Future<ProtectionPlansTableData?> getActiveProtectionPlan() {
    final now = DateTime.now();

    return (select(protectionPlansTable)
          ..where(
            (tbl) =>
                tbl.startDate.isSmallerOrEqualValue(now) &
                tbl.endDate.isBiggerOrEqualValue(now),
          )
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> createInitialProtectionPlanIfNeeded() async {
    final existingPlan = await select(protectionPlansTable).getSingleOrNull();

    if (existingPlan != null) return;

    final now = DateTime.now();
    debugPrint("Today's Date: $now");
    await into(protectionPlansTable).insert(
      ProtectionPlansTableCompanion.insert(
        startDate: now,
        endDate: DateTime(
          now.year + 5,
          now.month,
          now.day,
          now.hour,
          now.minute,
          now.second,
        ),
        createdAt: now,
        updatedAt: now,
      ),
    );
  }

  double _defaultContinuityShare(ProtectionType protectionType) {
    return switch (protectionType) {
      ProtectionType.death => 0.0,
      ProtectionType.criticalIllness || ProtectionType.disability => 1.0,
    };
  }

  Future<double> calculateMonthlyDependentExpenses(
    List<SavedCashflowPlanData> plans, {
    required ProtectionType protectionType,
  }) async {
    double total = 0;

    for (final plan in plans) {
      if (plan.planType != 'expense') continue;

      final shares = await getContinuitySharesForPlan(plan.planId);

      final continuityShare =
          shares[protectionType] ?? _defaultContinuityShare(protectionType);

      final monthlyExpense = plan.budgetPeriod.toMonthly(plan.amount);

      total += monthlyExpense * continuityShare;
    }

    return total;
  }

  Future<void> seedDefaultProtectionScenarios() async {
    await transaction(() async {
      for (final type in ProtectionType.values) {
        final existing =
            await (select(protectionScenariosTable)
                  ..where((tbl) => tbl.protectionType.equals(type.name)))
                .getSingleOrNull();

        if (existing != null) continue;

        final defaultHorizon = switch (type) {
          ProtectionType.death => ProtectionHorizon.zero,
          ProtectionType.criticalIllness => ProtectionHorizon.one,
          ProtectionType.disability => ProtectionHorizon.two,
        };

        await upsertProtectionScenario(
          protectionType: type,
          horizon: defaultHorizon,
        );
      }
    });
  }

  Future<bool> hasContinuityShares() async {
    final query = select(protectionBudgetContinuities)..limit(1);
    final records = await query.get();

    return records.isNotEmpty;
  }

  /// Save or update a continuity share for one budget plan and protection type.
  Future<void> saveContinuityShare({
    required int cashFlowPlanId,
    required ProtectionType protectionType,
    required double continuityShare,
  }) async {
    final share = continuityShare.clamp(0.0, 1.0);

    await transaction(() async {
      final scenario =
          await (select(
                protectionScenariosTable,
              )..where((tbl) => tbl.protectionType.equals(protectionType.name)))
              .getSingleOrNull();

      if (scenario == null) {
        throw StateError(
          'Protection scenario ${protectionType.name} has not been saved.',
        );
      }

      final existing =
          await (select(protectionBudgetContinuities)..where(
                (tbl) =>
                    tbl.protectionScenarioId.equals(scenario.id) &
                    tbl.cashFlowPlanId.equals(cashFlowPlanId),
              ))
              .getSingleOrNull();

      if (existing == null) {
        await into(protectionBudgetContinuities).insert(
          ProtectionBudgetContinuitiesCompanion.insert(
            protectionScenarioId: scenario.id,
            cashFlowPlanId: cashFlowPlanId,
            continuityShare: share,
          ),
        );
      } else {
        await (update(
          protectionBudgetContinuities,
        )..where((tbl) => tbl.id.equals(existing.id))).write(
          ProtectionBudgetContinuitiesCompanion(continuityShare: Value(share)),
        );
      }
    });
  }

  /// Load all saved continuity shares for a budget plan.
  Future<Map<ProtectionType, double>> getContinuitySharesForPlan(
    int cashFlowPlanId,
  ) async {
    final query =
        select(protectionBudgetContinuities).join([
          innerJoin(
            protectionScenariosTable,
            protectionScenariosTable.id.equalsExp(
              protectionBudgetContinuities.protectionScenarioId,
            ),
          ),
        ])..where(
          protectionBudgetContinuities.cashFlowPlanId.equals(cashFlowPlanId),
        );

    final rows = await query.get();

    return {
      for (final row in rows)
        if (ProtectionType.values.any(
          (type) =>
              type.name ==
              row.readTable(protectionScenariosTable).protectionType,
        ))
          ProtectionType.values.firstWhere(
            (type) =>
                type.name ==
                row.readTable(protectionScenariosTable).protectionType,
          ): row
              .readTable(protectionBudgetContinuities)
              .continuityShare,
    };
  }

  Future<void> upsertProtectionScenario({
    required ProtectionType protectionType,
    required ProtectionHorizon horizon,
  }) async {
    final existing =
        await (select(protectionScenariosTable)
              ..where((tbl) => tbl.protectionType.equals(protectionType.name)))
            .getSingleOrNull();

    final now = DateTime.now();

    if (existing == null) {
      await into(protectionScenariosTable).insert(
        ProtectionScenariosTableCompanion.insert(
          protectionType: protectionType.name,
          horizon: Value(horizon.name),
          createdAt: now,
          updatedAt: now,
        ),
      );
      return;
    }

    await (update(
      protectionScenariosTable,
    )..where((tbl) => tbl.id.equals(existing.id))).write(
      ProtectionScenariosTableCompanion(
        horizon: Value(horizon.name),
        updatedAt: Value(now),
      ),
    );
  }

  ///QUESTIONNAIRE ANSWERS
  Future<void> saveFinancialDependency(FinancialDependency dependency) async {
    final now = DateTime.now();

    await into(protectionDependencyTable).insertOnConflictUpdate(
      ProtectionDependencyTableCompanion(
        id: const Value(1),
        dependencyType: Value(dependency.name),
        createdAt: Value(now),
        updatedAt: Value(now),
      ),
    );
  }

  Future<FinancialDependency?> getFinancialDependency() async {
    final row = await select(protectionDependencyTable).getSingleOrNull();

    if (row == null) return null;

    return FinancialDependency.values.firstWhere(
      (value) => value.name == row.dependencyType,
    );
  }

  Future<void> saveProtectionHorizons(ProtectionHorizonAnswers answers) async {
    await transaction(() async {
      await upsertProtectionScenario(
        protectionType: ProtectionType.death,
        horizon: answers.death,
      );

      await upsertProtectionScenario(
        protectionType: ProtectionType.criticalIllness,
        horizon: answers.criticalIllness,
      );

      await upsertProtectionScenario(
        protectionType: ProtectionType.disability,
        horizon: answers.disability,
      );

      await createInitialProtectionPlanIfNeeded();
    });
  }

  Future<void> saveProtectionHorizon({
    required ProtectionType protectionType,
    required ProtectionHorizon horizon,
  }) async {
    await transaction(() async {
      await upsertProtectionScenario(
        protectionType: protectionType,
        horizon: horizon,
      );
    });
  }

  Future<List<ProtectionScenariosTableData>> getProtectionScenarios() {
    return select(protectionScenariosTable).get();
  }

  Future<bool> isProtectionHorizonCompleted() async {
    final scenarios = await getProtectionScenarios();
    return scenarios.length == 3;
  }

  Stream<List<ProtectionScenariosTableData>> watchProtectionScenarios() {
    return select(protectionScenariosTable).watch();
  }

  Stream<FinancialDependency?> watchFinancialDependency() {
    return select(protectionDependencyTable).watchSingleOrNull().map((row) {
      if (row == null) {
        return null;
      }

      return FinancialDependency.values.firstWhere(
        (value) => value.name == row.dependencyType,
      );
    });
  }
}
