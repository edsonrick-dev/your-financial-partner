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
    final availableFund = 10000;
    final reservedFund = 20000;

    return AdaptivePressable(
      borderRadius: BorderRadius.circular(12),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
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
                      'Total Fund',
                      style: AppTextStyle.labelXS.copyWith(
                        color: colorScheme.textMuted,
                      ),
                    ),
                    Text(
                      account.currentValue.toCurrency(),
                      style: AppTextStyle.amountL.copyWith(
                        color: colorScheme.appInflow,
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Available / limit
            Row(
              children: [
                Expanded(
                  child: _AccountMetric(
                    label: 'Available Fund',
                    value: availableFund.toCurrency(),
                  ),
                ),
                Expanded(
                  child: _AccountMetric(
                    label: 'Reserved',
                    value: reservedFund.toCurrency(),
                  ),
                ),
              ],
            ),

            // ...[
            //   const SizedBox(height: 16),

            //   ClipRRect(
            //     borderRadius: BorderRadius.circular(4),
            //     child: LinearProgressIndicator(
            //       value: utilization.clamp(0.0, 1.0),
            //       minHeight: 6,
            //     ),
            //   ),

            //   const SizedBox(height: 6),

            //   Text(
            //     '${(utilization * 100).toStringAsFixed(1)}% utilized',
            //     style: AppTextStyle.bodyS,
            //   ),
            // ],
          ],
        ),
      ),
    );
  }
}

class _AccountMetric extends StatelessWidget {
  final String label;
  final String value;

  const _AccountMetric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.labelXS.copyWith(color: colorScheme.textMuted),
        ),
        const SizedBox(height: 2),
        Text(value, style: AppTextStyle.amountM),
      ],
    );
  }
}
