import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/transaction_sheets.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/transaction_sheet.dart';
import 'package:getx_drift_app/features/transactions/controllers/extensions/transaction_hydration_ext.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/loan_payment_transaction/load_loan_payment_transaction.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';

extension SpendTransactionSheet on TransactionSheets {
  Future<void> loanPayment(TransactionWithDetails item) async {
    final controller = Get.find<TransactionController>();

    await controller.loadLoanPaymentTransaction(item);

    await Get.bottomSheet(
      const TransactionSheet(transactionType: TransactionType.debtRepayment),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    ).whenComplete(controller.resetForm);
  }
}
