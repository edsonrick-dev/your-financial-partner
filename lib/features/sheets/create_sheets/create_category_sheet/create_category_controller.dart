import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/add_button_state.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';

// enum CategoryType { income, expense }

class CreateCategoryController extends GetxController {
  final Rx<AddButtonState> buttonState = AddButtonState.collapsed.obs;
  void expandButton() {
    buttonState.value = AddButtonState.expanded;
  }

  void collapseButton() {
    buttonState.value = AddButtonState.collapsed;
  }

  void setLoading() {
    buttonState.value = AddButtonState.loading;
  }

  CreateCategoryController(TransactionType transactionType)
    : _categoryType = transactionType.obs;

  final Rx<TransactionType> _categoryType;
  final TextEditingController nameController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();

  final RxString selectedIconKey = 'fallback'.obs;

  final RxBool isSaving = false.obs;

  void selectIcon(String iconKey) {
    selectedIconKey.value = iconKey;
  }

  void selectCategoryType(TransactionType type) {
    _categoryType.value = type;
  }

  Future<CashflowCategoriesTableData?> saveCategory() async {
    final name = nameController.text.trim();

    if (name.isEmpty) return null;

    final insertedId = await database.insertCashflowCategory(
      CashflowCategoriesTableCompanion.insert(
        name: name,
        icon: selectedIconKey.value,
        type: _categoryType.value.name,
      ),
    );

    final createdCategory = await database.getCategoryById(insertedId);

    // resetForm();

    collapseButton();

    return createdCategory;
  }

  @override
  void onClose() {
    nameController.dispose();

    super.onClose();
  }
}
