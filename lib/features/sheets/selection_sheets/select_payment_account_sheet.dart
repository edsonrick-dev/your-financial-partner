import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/organize_THIS/payment_account_list.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';

class SelectPaymentAccountSheet extends StatelessWidget {
  final TransactionType transactionType;
  final int? excludedAccountId;
  const SelectPaymentAccountSheet({
    super.key,
    required this.transactionType,
    this.excludedAccountId,
  });
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      constraints: BoxConstraints(
        maxHeight: Get.height * AppSheetHeight.semiFull,
        minHeight: 200,
      ),
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(38)),
      ),

      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 12,
          children: [
            /// Header
            Column(
              children: [
                AppGrabber(),
                AppToolbar(title: 'Select Payment Account'),
              ],
            ),
            Flexible(
              child: PaymentAccountList(
                transactionType: transactionType,
                excludedAccountId: excludedAccountId,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
