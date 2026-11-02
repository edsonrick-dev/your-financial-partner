import 'package:drift/drift.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/cashflow_categories_table.dart';

part 'category_dao.g.dart';

@DriftAccessor(tables: [CashflowCategoriesTable])
class CategoryDao extends DatabaseAccessor<AppDatabase>
    with _$CategoryDaoMixin {
  CategoryDao(super.db);

  /// Get all categories.
  Future<List<CashflowCategoriesTableData>> getAllCategories() {
    return select(cashflowCategoriesTable).get();
  }

  /// Watch all categories reactively.
  Stream<List<CashflowCategoriesTableData>> watchAllCategories() {
    return select(cashflowCategoriesTable).watch();
  }

  /// Get active categories by type for category selection flows.
  Future<List<CashflowCategoriesTableData>> getCategoriesByType(String type) {
    return (select(
          cashflowCategoriesTable,
        )..where((tbl) => tbl.type.equals(type) & tbl.isArchived.equals(false)))
        .get();
  }

  /// Watch active categories by type for category selection flows.
  Stream<List<CashflowCategoriesTableData>> watchCategoriesByType(String type) {
    return (select(
          cashflowCategoriesTable,
        )..where((tbl) => tbl.type.equals(type) & tbl.isArchived.equals(false)))
        .watch();
  }

  /// Get one category.

  Future<CashflowCategoriesTableData?> getCategoryById(int id) {
    return (select(
      cashflowCategoriesTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  Future<CashflowCategoriesTableData> getOrCreateInsuranceCategory() async {
    final expenseCategories = await (select(
      cashflowCategoriesTable,
    )..where((tbl) => tbl.type.equals('spend'))).get();

    for (final category in expenseCategories) {
      if (!category.isSystem) continue;

      if (category.isArchived) {
        await (update(
          cashflowCategoriesTable,
        )..where((tbl) => tbl.id.equals(category.id))).write(
          const CashflowCategoriesTableCompanion(isArchived: Value(false)),
        );
        return (await getCategoryById(category.id))!;
      }
      return category;
    }

    for (final category in expenseCategories) {
      if (category.name.trim().toLowerCase() == 'insurances' ||
          category.name.trim().toLowerCase() == 'insurance') {
        await (update(
          cashflowCategoriesTable,
        )..where((tbl) => tbl.id.equals(category.id))).write(
          const CashflowCategoriesTableCompanion(
            isArchived: Value(false),
            isSystem: Value(true),
          ),
        );
        return (await getCategoryById(category.id))!;
      }
    }

    final id = await createCategory(
      CashflowCategoriesTableCompanion.insert(
        name: 'Insurances',
        icon: 'shieldPlus',
        type: 'spend',
        isDefault: const Value(true),
        isSystem: const Value(true),
      ),
    );

    return (await getCategoryById(id))!;
  }

  /// Create category.
  Future<int> createCategory(CashflowCategoriesTableCompanion entry) {
    return into(cashflowCategoriesTable).insert(entry);
  }

  /// Update category.
  Future<bool> updateCategory(CashflowCategoriesTableData category) async {
    final existing = await getCategoryById(category.id);
    if (existing == null || existing.isSystem) return false;

    return update(cashflowCategoriesTable).replace(category);
  }

  /// Archive or restore a category while preserving its historical records.
  Future<int> setCategoryArchived(int id, {required bool isArchived}) {
    final query = update(cashflowCategoriesTable)
      ..where((tbl) {
        final matchesId = tbl.id.equals(id);
        return isArchived ? matchesId & tbl.isSystem.equals(false) : matchesId;
      });

    return query.write(
      CashflowCategoriesTableCompanion(isArchived: Value(isArchived)),
    );
  }
}
