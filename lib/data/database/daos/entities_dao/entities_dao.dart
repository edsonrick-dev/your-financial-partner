import 'package:drift/drift.dart';
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
}
