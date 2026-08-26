import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/features/transaction/payment_account_list.dart';
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
    return AppSheet(
      adaptiveHeight: true,
      minHeightFactor: AppSheetHeight.quarter,
      height: AppSheetHeight.full,
      title: 'Select Payment Account',
      child: Column(
        children: [
          AppSection(
            child: Row(
              children: [
                const SizedBox(width: 16),
                Text(
                  'Account',
                  style: AppTextStyle.bodyM.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),
                const Spacer(),
                Text(
                  'Available Balance',
                  style: AppTextStyle.bodyM.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Flexible(
            child: PaymentAccountList(
              transactionType: transactionType,
              excludedAccountId: excludedAccountId,
            ),
          ),
        ],
      ),
    );
  }
}
