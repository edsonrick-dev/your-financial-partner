import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_group_enum.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/features/transactions/payment_account_list.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';

class SelectPaymentAccountSheet extends StatelessWidget {
  final TransactionType transactionType;
  final int? excludedAccountId;
  final AccountGroup? accountGroup;
  const SelectPaymentAccountSheet({
    super.key,
    required this.transactionType,
    this.excludedAccountId,
    this.accountGroup,
  });
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSheet(
      adaptiveHeight: true,
      title: accountGroup == AccountGroup.creditCards
          ? 'Select Credit Card'
          : 'Select Payment Account',
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
              accountGroup: accountGroup,
            ),
          ),
        ],
      ),
    );
  }
}
