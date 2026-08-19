import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

class CashAndBankAccountCard extends StatelessWidget {
  final AccountsTableData account;
  final VoidCallback? onTap;

  const CashAndBankAccountCard({super.key, required this.account, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 16,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      Icon(AppIcons.categories.resolve(account.icon), size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(account.name, style: AppTextStyle.titleM),
                      ),
                    ],
                  ),
                ), // Current payable
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      account.currentValue.toCurrency(),
                      style: AppTextStyle.amountL.copyWith(
                        color: colorScheme.appInflow,
                      ),
                    ),
                    Text(
                      'Total Fund',
                      style: AppTextStyle.labelXS.copyWith(
                        color: colorScheme.textMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
