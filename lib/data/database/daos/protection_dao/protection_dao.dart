import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/protection_scenarios_table.dart';
import 'package:getx_drift_app/data/tables/protection_budget_continuities_table.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/protection_horizon_questionnaire/models/protection_horizon_answers.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';

part 'protection_dao.g.dart';

@DriftAccessor(tables: [ProtectionScenariosTable, ProtectionBudgetContinuities])
class ProtectionDao extends DatabaseAccessor<AppDatabase>
    with _$ProtectionDaoMixin {
  ProtectionDao(super.db);

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
          horizon: horizon.name,
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
}
