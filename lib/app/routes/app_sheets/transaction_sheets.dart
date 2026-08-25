import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/transaction_hydration_ext.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/earn_transaction_sheet.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/give_money_transaction_sheet.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/receive_money_transaction_sheet.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/spend_transaction_sheet.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/transfer_transaction_sheet.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';

class TransactionSheets {
  Future<void> earn([TransactionWithDetails? item]) async {
    final controller = Get.find<TransactionController>();

    if (item != null) {
      controller.loadEarnTransaction(item);
    } else {
      controller.resetForm();
    }

    await Get.bottomSheet(
      const EarnTransactionSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> spend({TransactionWithDetails? item, int? categoryId}) async {
    final controller = Get.find<TransactionController>();

    if (item != null) {
      controller.loadSpendTransaction(item);
    } else {
      controller.resetForm();

      if (categoryId != null) {
        await controller.selectCategoryById(categoryId);
      }
    }

    await Get.bottomSheet(
      const SpendTransactionSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> transfer([TransactionWithDetails? item]) async {
    final controller = Get.find<TransactionController>();

    if (item != null) {
      controller.loadTransferTransaction(item);
    } else {
      controller.resetForm();
    }

    await Get.bottomSheet(
      const TransferTransactionSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> receiveMoney([TransactionWithDetails? item]) async {
    final controller = Get.find<TransactionController>();
    if (item != null) {
      controller.loadReceiveMoneyTransaction(item);
    } else {
      controller.resetForm();
    }

    await Get.bottomSheet(
      const ReceiveMoneyTransactionSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  Future<void> giveMoney([TransactionWithDetails? item]) async {
    final controller = Get.find<TransactionController>();

    if (item != null) {
      controller.loadGiveMoneyTransaction(item);
    } else {
      controller.resetForm();
    }
    await Get.bottomSheet(
      const GiveMoneyTransactionSheet(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
