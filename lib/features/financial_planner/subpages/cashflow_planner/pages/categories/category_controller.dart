import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/domain/enums/app_snack_type.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/categories/category_form_sheet.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_category_sheet/create_category_controller.dart';

class CategoryController extends GetxController {
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
    return categories
        .where(
          (category) =>
              category.type == TransactionType.earn.name &&
              !category.isArchived,
        )
        .toList();
  }

  List<CashflowCategoriesTableData> get expenseCategories {
    return categories
        .where(
          (category) =>
              category.type == TransactionType.spend.name &&
              !category.isArchived,
        )
        .toList();
  }

  List<CashflowCategoriesTableData> get archivedIncomeCategories {
    return categories
        .where(
          (category) =>
              category.type == TransactionType.earn.name && category.isArchived,
        )
        .toList();
  }

  List<CashflowCategoriesTableData> get archivedExpenseCategories {
    return categories
        .where(
          (category) =>
              category.type == TransactionType.spend.name &&
              category.isArchived,
        )
        .toList();
  }

  Future<void> loadCategories() async {
    isLoading.value = true;
    try {
      final result = await database.categoryDao.getAllCategories();
      categories.assignAll(result);
    } finally {
      isLoading.value = false;
    }
  }

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

  Future<void> confirmArchiveCategory(
    CashflowCategoriesTableData category,
  ) async {
    if (category.isSystem) {
      AppSnackbar.show(
        title: 'System category',
        message: 'This category is required for insurance premium planning.',
        type: AppSnackType.info,
      );
      return;
    }

    Get.dialog(
      AlertDialog(
        title: const Text('Archive category?'),
        content: Text(
          '"${category.name}" will no longer be available for new transactions. '
          'Existing transactions, bills, and plans will keep this category.',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              Get.back();
              await setCategoryArchived(category, isArchived: true);
            },
            child: const Text('Archive'),
          ),
        ],
      ),
    );
  }

  Future<void> restoreCategory(CashflowCategoriesTableData category) async {
    await setCategoryArchived(category, isArchived: false);
  }

  Future<void> setCategoryArchived(
    CashflowCategoriesTableData category, {
    required bool isArchived,
  }) async {
    if (category.isSystem && isArchived) {
      AppSnackbar.show(
        title: 'System category',
        message: 'This category is required for insurance premium planning.',
        type: AppSnackType.info,
      );
      return;
    }

    try {
      final updatedRows = await database.categoryDao.setCategoryArchived(
        category.id,
        isArchived: isArchived,
      );
      if (updatedRows == 0) return;
    } catch (_) {
      AppSnackbar.show(
        title: isArchived
            ? 'Could not archive category'
            : 'Could not restore category',
        message: 'Please try again.',
        type: AppSnackType.error,
      );
      return;
    }

    final index = categories.indexWhere((item) => item.id == category.id);
    if (index != -1) {
      categories[index] = categories[index].copyWith(isArchived: isArchived);
    }
  }
}
