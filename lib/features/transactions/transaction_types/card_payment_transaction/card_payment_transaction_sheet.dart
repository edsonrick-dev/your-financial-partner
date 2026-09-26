import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/transaction_sheets.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/transaction_sheet.dart';
import 'package:getx_drift_app/features/transactions/controllers/extensions/transaction_hydration_ext.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/card_payment_transaction/load_card_payment_transaction.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';

extension CardPaymentTransactionSheet on TransactionSheets {
  Future<void> payCreditCard({
    AccountsTableData? creditCard,
    TransactionWithDetails? transaction,
  }) async {
    final controller = Get.find<TransactionController>();

    if (transaction != null) {
      // EDIT
      controller.loadCardPaymentTransaction(transaction);
    } else {
      // CREATE
      controller.resetForm();

      if (creditCard != null) {
        // Credit card is the destination.
        controller.selectedLinkedAccount.value = creditCard;
      }
    }

    await Get.bottomSheet(
      const TransactionSheet(transactionType: TransactionType.cardPayment),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).whenComplete(controller.resetForm);
  }
}
