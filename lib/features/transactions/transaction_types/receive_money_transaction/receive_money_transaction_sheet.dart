import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/transaction_sheets.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/transaction_sheet.dart';
import 'package:getx_drift_app/features/transactions/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transactions/controllers/extensions/transaction_hydration_ext.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/receive_money_transaction/load_receive_money_transaction.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';

extension TransferTractionSheet on TransactionSheets {
  Future<void> receiveMoney({
    TransactionWithDetails? item,
    AccountsTableData? account,
  }) async {
    final controller = Get.find<TransactionController>();

    if (item != null) {
      controller.loadReceiveMoneyTransaction(item);
    } else {
      controller.resetForm();

      if (account != null) {
        controller.setSelectedAccount(account);
      }
    }

    await Get.bottomSheet(
      const TransactionSheet(transactionType: TransactionType.receive),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).whenComplete(controller.resetForm);
  }
}
