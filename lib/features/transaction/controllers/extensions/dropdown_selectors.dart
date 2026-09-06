import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';

extension DropdownSelectors on TransactionController {
  Future<void> selectCategory(TransactionType transactionType) async {
    final result = await AppSheets.selection.selectCategory(
      transactionType,
      selectedCategory: selectedCategory.value,
    );
    if (result == null) return;

    selectedCategory.value = result;
  }

  Future<void> selectCategoryWithFilter(
    TransactionType transactionType,
    Set<int> excludedCategoryIds,
  ) async {
    final result = await AppSheets.selection.selectCategory(
      transactionType,
      selectedCategory: selectedCategory.value,
      excludedCategoryIds: excludedCategoryIds,
    );

    if (result == null) return;

    selectedCategory.value = result;
  }

  Future<void> selectAccount(TransactionType transactionType) async {
    final result = await AppSheets.selection.selectAccount(transactionType);

    if (result == null) return;

    selectedAccount.value = result;

    // Optional protection
    if (selectedLinkedAccount.value?.id == result.id) {
      selectedLinkedAccount.value = null;
    }
  }

  Future<void> selectLinkedAccount(TransactionType transactionType) async {
    final result = await AppSheets.selection.selectAccount(
      transactionType,

      excludedAccountId: selectedAccount.value?.id,
    );

    if (result == null) return;

    selectedLinkedAccount.value = result;
  }

  // Future<void> selectCashflowPlanType() async {
  //   final result = await AppSheets.selectCashflowPlanType();

  //   if (result == null) return;

  //   selectedCashfLowPlanType.value = result;
  // }
}
