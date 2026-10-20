import 'package:drift/drift.dart';
import 'package:flutter/cupertino.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/entities_table.dart';

part 'entities_dao.g.dart';

@DriftAccessor(tables: [EntitiesTable])
/// ============================================================
/// ENTITIES DAO
/// ============================================================
///
/// Central repository responsible for managing people and entities.
///
/// Entities represent:
///
/// • User
/// • Friends
/// • Family Members
/// • Colleagues
///
/// • Debtors
/// • Creditors
///
/// ARCHITECTURE
///
/// Entities are identity records.
///
/// Financial relationships are stored separately in:
///
/// • FinancialObligationsTable
/// • TransactionParticipantsTable
///
/// This DAO manages entity lifecycle and lookup operations.
class EntitiesDao extends DatabaseAccessor<AppDatabase>
    with _$EntitiesDaoMixin {
  EntitiesDao(super.db);
  Future<EntitiesTableData?> getBySupabaseId(int supabaseId) {
    return (select(
      entitiesTable,
    )..where((tbl) => tbl.supabaseId.equals(supabaseId))).getSingleOrNull();
  }

  Future<EntitiesTableData?> getCurrentUserEntity() {
    return (select(
      entitiesTable,
    )..where((tbl) => tbl.name.equals('Me'))).getSingleOrNull();
  }

  Future<int> insertEntity(EntitiesTableCompanion entry) {
    return into(entitiesTable).insert(entry);
  }

  Future<List<EntitiesTableData>> getAllEntities() {
    return select(entitiesTable).get();
  }

  Stream<List<EntitiesTableData>> watchEntitiesByType(String type) {
    return (select(
      entitiesTable,
    )..where((tbl) => tbl.entityType.equals(type))).watch();
  }

  Future<EntitiesTableData?> getEntityById(int id) {
    return (select(
      entitiesTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// Watches locally cached system insurance companies.
  Stream<List<EntitiesTableData>> watchSystemInsuranceCompanies() {
    return (select(entitiesTable)
          ..where(
            (tbl) =>
                tbl.isSystem.equals(true) &
                tbl.entityType.equals('organization') &
                tbl.organizationType.equals('insuranceCompany'),
          )
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.displayName)]))
        .watch();
  }

  /// Inserts or updates a system entity using its Supabase ID.
  ///
  /// Existing local IDs are preserved when the Supabase ID matches.
  Future<void> upsertSystemEntity({
    required int supabaseId,
    required String name,
    String? displayName,
    required String entityType,
    String? organizationType,
  }) async {
    await transaction(() async {
      final existing = await (select(
        entitiesTable,
      )..where((tbl) => tbl.supabaseId.equals(supabaseId))).getSingleOrNull();

      final companion = EntitiesTableCompanion(
        supabaseId: Value(supabaseId),
        name: Value(name),
        displayName: Value(displayName),
        entityType: Value(entityType),
        organizationType: Value(organizationType),
        isSystem: const Value(true),
      );

      if (existing != null) {
        await (update(
          entitiesTable,
        )..where((tbl) => tbl.id.equals(existing.id))).write(companion);
      } else {
        await into(entitiesTable).insert(companion);
      }
    });
  }

  Future<void> syncSystemInsuranceCompanies(
    List<Map<String, dynamic>> remoteEntities,
  ) async {
    await transaction(() async {
      for (final json in remoteEntities) {
        final supabaseId = (json['id'] as num).toInt();

        final existing = await (select(
          entitiesTable,
        )..where((tbl) => tbl.supabaseId.equals(supabaseId))).getSingleOrNull();

        final companion = EntitiesTableCompanion(
          supabaseId: Value(supabaseId),
          name: Value(json['name'] as String),
          displayName: Value(json['display_name'] as String),
          entityType: Value(json['entity_type'] as String),
          organizationType: Value(json['organization_type'] as String?),
          isSystem: const Value(true),
        );

        if (existing != null) {
          await (update(
            entitiesTable,
          )..where((tbl) => tbl.id.equals(existing.id))).write(companion);
        } else {
          await into(entitiesTable).insert(companion);
        }
      }
    });
  }

  Future<void> debugPrintAllEntities() async {
    final rows = await select(entitiesTable).get();

    debugPrint('========== DRIFT ENTITIES TABLE ==========');
    debugPrint('Total rows: ${rows.length}');

    for (final row in rows) {
      debugPrint('''
--------------------------------------------
ID: ${row.id}
Supabase ID: ${row.supabaseId}
Name: ${row.name}
Display Name: ${row.displayName}
Short Code: ${row.shortCode}
Entity Type: ${row.entityType}
Organization Type: ${row.organizationType}
Is System: ${row.isSystem}
Icon Key: ${row.iconKey}
Contact Number: ${row.contactNumber}
Email Address: ${row.emailAddress}
Metadata: ${row.metadata}
--------------------------------------------
''');
    }

    debugPrint('========== END OF ENTITIES TABLE ==========');
  }
}
