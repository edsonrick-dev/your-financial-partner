import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/transaction_sheets.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/transaction_sheet.dart';
import 'package:getx_drift_app/features/transactions/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transactions/controllers/extensions/transaction_hydration_ext.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/earn_transaction/load_earn_transaction.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';

extension EarnTransactionSheet on TransactionSheets {
  Future<void> earn({
    TransactionWithDetails? item,
    int? categoryId,
    AccountsTableData? account,
  }) async {
    final controller = Get.find<TransactionController>();

    if (item != null) {
      controller.loadEarnTransaction(item);
    } else {
      controller.resetForm();

      if (account != null) {
        controller.setSelectedAccount(account);
      }
      if (categoryId != null) {
        await controller.selectCategoryById(categoryId);
      }
    }

    await Get.bottomSheet(
      const TransactionSheet(transactionType: TransactionType.earn),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).whenComplete(controller.resetForm);
  }
}
