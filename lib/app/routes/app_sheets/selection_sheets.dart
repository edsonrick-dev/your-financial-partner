import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/enums/frequency_type_enum.dart';
import 'package:getx_drift_app/domain/scheduling/month_pattern.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/add_account/forms/credit_card_installment_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/select_institution_sheet.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_category_sheet.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_day_of_month.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_frequency_cycles_sheet.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_frequency_sheet.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_other_transactions.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_payment_account_sheet.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_person_sheet.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_payment_account_type_sheet.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';

class SelectionSheets {
  Future<AccountsTableData?> selectCreditCard() {
    return Get.bottomSheet<AccountsTableData>(
      const SelectCreditCardSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<EntitiesTableData?> selectInstitution() {
    return Get.bottomSheet<EntitiesTableData>(
      const SelectInstitutionSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

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
    Get.put(CreateEntityController());

    final result = await Get.bottomSheet<EntitiesTableData>(
      SelectPersonSheet(excludedPersonIds: excludedPersonIds),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );

    // Get.delete<CreateEntityController>();

    return result;
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

  Future<int?> selectDayOfMonth({int? selectedDAy}) {
    return Get.bottomSheet<int>(
      SelectDayOfMonthSheet(selectedDay: selectedDAy),
      isScrollControlled: true,
    );
  }
}
