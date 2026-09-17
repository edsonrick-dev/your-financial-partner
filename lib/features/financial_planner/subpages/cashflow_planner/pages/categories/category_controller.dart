import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/categories/category_form_sheet.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_category_sheet/create_category_controller.dart';

class CategoryController extends GetxController {
  void openEditCategory(CashflowCategoriesTableData category) {
    final transactionType = category.type == 'earn'
        ? TransactionType.earn
        : TransactionType.spend;

    Get.put(CreateCategoryController(transactionType));

    Get.bottomSheet(
      CategoryFormSheet(category: category),
      isScrollControlled: true,
    );
  }

  final selectedCategoryTypeIndex = 0.obs;
  // final CategoryDao categoryDao;
  @override
  void onInit() {
    super.onInit();
    loadCategories();
  }

  // CategoryController({required this.categoryDao});

  final categories = <CashflowCategoriesTableData>[].obs;

  final isLoading = false.obs;

  List<CashflowCategoriesTableData> get incomeCategories {
    return categories.where((category) => category.type == 'earn').toList();
  }

  List<CashflowCategoriesTableData> get expenseCategories {
    return categories.where((category) => category.type == 'spend').toList();
  }

  Future<void> loadCategories() async {
    isLoading.value = true;

    try {
      final result = await database.categoryDao.getAllCategories();

      debugPrint('==============================');
      debugPrint('CATEGORY COUNT: ${result.length}');

      for (final category in result) {
        debugPrint(
          'ID: ${category.id} | '
          'NAME: ${category.name} | '
          'TYPE: "${category.type}"',
        );
      }

      debugPrint(
        'INCOME COUNT: ${result.where((c) => c.type == 'earn').length}',
      );

      debugPrint(
        'EXPENSE COUNT: ${result.where((c) => c.type == 'spend').length}',
      );

      debugPrint('==============================');

      categories.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }
  // Future<void> loadCategories() async {
  //   isLoading.value = true;

  //   try {
  //     final result = await database.categoryDao.getAllCategories();

  //     debugPrint('CATEGORY COUNT: ${result.length}');

  //     for (final category in result) {
  //       debugPrint('CATEGORY: ${category.name} | TYPE: ${category.type}');
  //     }

  //     categories.assignAll(result);
  //   } finally {
  //     isLoading.value = false;
  //   }
  // }

  void openCreateCategory() {
    Get.put(
      CreateCategoryController(
        selectedCategoryTypeIndex.value == 0
            ? TransactionType.earn
            : TransactionType.spend,
      ),
    );

    Get.bottomSheet(const CategoryFormSheet(), isScrollControlled: true);
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

    // await loadCategories();
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
