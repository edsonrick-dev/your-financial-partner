import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/categories/category_form_sheet.dart';

class CategoryController extends GetxController {
  // final CategoryDao categoryDao;

  // CategoryController({required this.categoryDao});

  final categories = <CashflowCategoriesTableData>[].obs;

  final isLoading = false.obs;

  List<CashflowCategoriesTableData> get incomeCategories {
    return categories.where((category) => category.type == 'earn').toList();
  }

  List<CashflowCategoriesTableData> get expenseCategories {
    return categories.where((category) => category.type == 'spend').toList();
  }

  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  // Future<void> loadCategories() async {
  //   isLoading.value = true;

  //   try {
  //     final result = await database.categoryDao.getAllCategories();

  //     categories.assignAll(result);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }
  Future<void> loadCategories() async {
    isLoading.value = true;

    try {
      final result = await database.categoryDao.getAllCategories();

      debugPrint('CATEGORY COUNT: ${result.length}');

      for (final category in result) {
        debugPrint('CATEGORY: ${category.name} | TYPE: ${category.type}');
      }

      categories.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }

  void openCreateCategory() {
    Get.bottomSheet(
      CategoryFormSheet(
        onSave: (name, icon, type) async {
          await createCategory(name: name, icon: icon, type: type);

          Get.back();
        },
      ),
      isScrollControlled: true,
    );
  }

  void openEditCategory(CashflowCategoriesTableData category) {
    Get.bottomSheet(
      CategoryFormSheet(
        category: category,
        onSave: (name, icon, type) async {
          await updateCategory(
            category: category,
            name: name,
            icon: icon,
            type: type,
          );

          Get.back();
        },
      ),
      isScrollControlled: true,
    );
  }

  Future<void> createCategory({
    required String name,
    required String icon,
    required String type,
  }) async {
    await database.categoryDao.createCategory(
      CashflowCategoriesTableCompanion.insert(
        name: name,
        icon: icon,
        type: type,
      ),
    );

    await loadCategories();
  }

  Future<void> updateCategory({
    required CashflowCategoriesTableData category,
    required String name,
    required String icon,
    required String type,
  }) async {
    await database.categoryDao.updateCategory(
      category.copyWith(name: name, icon: icon, type: type),
    );

    await loadCategories();
  }

  void confirmDeleteCategory(CashflowCategoriesTableData category) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Category?'),
        content: Text('Delete "${category.name}"?'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Get.back();
              await deleteCategory(category);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  Future<void> deleteCategory(CashflowCategoriesTableData category) async {
    await database.categoryDao.deleteCategory(category.id);

    await loadCategories();
  }
}
