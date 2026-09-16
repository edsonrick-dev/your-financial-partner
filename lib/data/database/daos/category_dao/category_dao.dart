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

  /// Get categories by type.
  Future<List<CashflowCategoriesTableData>> getCategoriesByType(String type) {
    return (select(
      cashflowCategoriesTable,
    )..where((tbl) => tbl.type.equals(type))).get();
  }

  /// Watch categories by type.
  Stream<List<CashflowCategoriesTableData>> watchCategoriesByType(String type) {
    return (select(
      cashflowCategoriesTable,
    )..where((tbl) => tbl.type.equals(type))).watch();
  }

  /// Get one category.

  Future<CashflowCategoriesTableData?> getCategoryById(int id) {
    return (select(
      cashflowCategoriesTable,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
  }

  /// Create category.
  Future<int> createCategory(CashflowCategoriesTableCompanion entry) {
    return into(cashflowCategoriesTable).insert(entry);
  }

  /// Update category.
  Future<bool> updateCategory(CashflowCategoriesTableData category) {
    return update(cashflowCategoriesTable).replace(category);
  }

  /// Delete category.
  Future<int> deleteCategory(int id) {
    return (delete(
      cashflowCategoriesTable,
    )..where((tbl) => tbl.id.equals(id))).go();
  }
}
