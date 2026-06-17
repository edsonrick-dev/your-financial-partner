import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/enums/frequency_type_enum.dart';
import 'package:getx_drift_app/domain/scheduling/month_pattern.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_category_sheet.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_frequency_cycles_sheet.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_frequency_sheet.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_other_transactions.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_payment_account_sheet.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_person_sheet.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_type_payment_account_sheet.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';

class SelectionSheets {
  Future<CashflowCategoriesTableData?> selectCategory(
    TransactionType transactionType, {
    CashflowCategoriesTableData? selectedCategory,
  }) {
    return Get.bottomSheet<CashflowCategoriesTableData>(
      SelectCategorySheet(
        transactionType: transactionType,
        selectedCategory: selectedCategory,
      ),
    );
  }

  Future<MonthPattern?> selectMonthPattern(FrequencyType frequency) {
    return Get.bottomSheet<MonthPattern>(
      SelectMonthPatternSheet(
        patterns: frequency.monthPatterns,
        frequency: frequency,
      ),
    );
  }

  Future<AccountsTableData?> selectAccount(
    TransactionType transactionType, {
    int? excludedAccountId,
  }) {
    return Get.bottomSheet(
      SelectPaymentAccountSheet(
        transactionType: transactionType,

        excludedAccountId: excludedAccountId,
      ),
    );
  }

  Future<AccountType?> selectPaymentAccountType({
    required List<AccountType> accountTypes,
  }) {
    return Get.bottomSheet<AccountType>(
      SelectPaymentAccountTypeSheet(accountTypes: accountTypes),
    );
  }

  Future<EntitiesTableData?> selectTransactionParticipant({
    List<int> excludedPersonIds = const [],
  }) async {
    return await Get.bottomSheet<EntitiesTableData>(
      SelectPersonSheet(excludedPersonIds: excludedPersonIds),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> selectOtherTransaction() {
    return Get.bottomSheet(
      const SelectOtherTransactionSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<FrequencyType?> selectFrequency() {
    return Get.bottomSheet(
      const SelectFrequencySheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
