import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_next_occurrence.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/transaction_sheet.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/transaction_hydration_ext.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/data/models/transaction_with_details.dart';

class TransactionSheets {
  Future<void> earn({
    TransactionWithDetails? item,
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
    }

    await Get.bottomSheet(
      const TransactionSheet(transactionType: TransactionType.earn),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).whenComplete(controller.resetForm);
  }

  Future<void> spend({
    TransactionWithDetails? item,
    int? categoryId,
    AccountsTableData? account,
  }) async {
    final controller = Get.find<TransactionController>();

    if (item != null) {
      controller.loadSpendTransaction(item);
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
      const TransactionSheet(transactionType: TransactionType.spend),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).whenComplete(controller.resetForm);
  }
  // Future<void> billPayment(BillWithNextOccurrence bill) async {
  //   final transactionType = bill.isLoanPayment
  //       ? TransactionType.debtRepayment
  //       : TransactionType.spend;

  //   // Open TransactionSheet with transactionType
  // }

  Future<void> spendBill(BillWithNextOccurrence bill) async {
    final controller = Get.find<TransactionController>();

    controller.prepareBillPayment(bill);

    final transactionType = bill.isLoanPayment
        ? TransactionType.debtRepayment
        : TransactionType.spend;

    await Get.bottomSheet(
      TransactionSheet(transactionType: transactionType),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).whenComplete(controller.resetForm);
  }

  Future<void> debtRepayment(TransactionWithDetails item) async {
    final controller = Get.find<TransactionController>();

    await controller.loadDebtRepaymentTransaction(item);

    await Get.bottomSheet(
      const TransactionSheet(transactionType: TransactionType.debtRepayment),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).whenComplete(controller.resetForm);
  }

  Future<void> transfer({
    TransactionWithDetails? item,
    AccountsTableData? fromAccount,
  }) async {
    final controller = Get.find<TransactionController>();

    if (item != null) {
      controller.loadTransferTransaction(item);
    } else {
      controller.resetForm();

      if (fromAccount != null) {
        controller.setSelectedAccount(fromAccount);
      }
    }

    await Get.bottomSheet(
      const TransactionSheet(transactionType: TransactionType.transfer),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).whenComplete(controller.resetForm);
  }

  Future<void> payCreditCard({required AccountsTableData creditCard}) async {
    final controller = Get.find<TransactionController>();

    controller.resetForm();

    // Credit card is the destination.
    controller.selectedLinkedAccount.value = creditCard;

    await Get.bottomSheet(
      const TransactionSheet(transactionType: TransactionType.transfer),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).whenComplete(controller.resetForm);
  }

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

  // Future<void> giveMoney({
  //   TransactionWithDetails? item,
  //   AccountsTableData? account,
  // }) async {
  //   final controller = Get.find<TransactionController>();

  //   if (item != null) {
  //     controller.loadGiveMoneyTransaction(item);
  //   } else {
  //     controller.resetForm();

  //     if (account != null) {
  //       controller.setSelectedAccount(account);
  //     }
  //   }

  //   await Get.bottomSheet(
  //     const TransactionSheet(transactionType: TransactionType.give),
  //     isScrollControlled: true,
  //     backgroundColor: Colors.transparent,
  //   ).whenComplete(controller.resetForm);
  // }

  Future<void> giveMoney({
    TransactionWithDetails? item,
    AccountsTableData? account,
  }) async {
    final controller = Get.find<TransactionController>();

    if (item != null) {
      controller.loadGiveMoneyTransaction(item);
    } else {
      controller.resetForm();

      if (account != null) {
        controller.setSelectedAccount(account);
      }
    }

    await Get.bottomSheet(
      const TransactionSheet(transactionType: TransactionType.give),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).whenComplete(controller.resetForm);
  }
}
