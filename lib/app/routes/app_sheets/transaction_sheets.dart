import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/transaction_sheet.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/transaction_hydration_ext.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
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
      const TransactionSheet(transactionType: TransactionType.earn),

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
      // const SpendTransactionSheet(),
      const TransactionSheet(transactionType: TransactionType.spend),
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
      // const TransferTransactionSheet(),
      const TransactionSheet(transactionType: TransactionType.transfer),
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
      // const ReceiveMoneyTransactionSheet(),
      const TransactionSheet(transactionType: TransactionType.receive),
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
      // const GiveMoneyTransactionForm(),
      const TransactionSheet(transactionType: TransactionType.give),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }
}
