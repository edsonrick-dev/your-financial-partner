import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/accounts_table.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/widgets/account_card_metric.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/num_extension.dart';

Color _utilizationColor(double utilization) {
  if (utilization >= 0.90) {
    return Colors.red.shade900;
  }

  if (utilization >= 0.70) {
    return Colors.red;
  }

  if (utilization >= 0.50) {
    return Colors.orange;
  }

  if (utilization >= 0.30) {
    return Colors.amber;
  }

  return Colors.green;
}

class CreditCardSummarySection extends StatelessWidget {
  final AccountsTableData account;

  const CreditCardSummarySection({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final creditLimit = account.creditLimit ?? 0;
    final payable = account.currentValue.abs();
    final availableCredit = account.availableCredit ?? 0;

    final utilization = creditLimit > 0 ? payable / creditLimit : 0.0;

    final utilizationColor = _utilizationColor(utilization);
    return AppSection(
      child: Container(
        padding: EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppGradient.gradientA(colorScheme),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Payable',
                        style: AppTextStyle.titleL.copyWith(
                          color: colorScheme.appInversedtextMuted,
                        ),
                      ),
                      const SizedBox(height: 4),

                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          payable.toCurrency(),
                          style: AppTextStyle.amountXL.copyWith(
                            color: colorScheme.appInversedtext,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                AdaptivePressable(
                  onTap: () {
                    AppSheets.openAccountActionSheet(account);
                  },
                  child: Icon(
                    Icons.more_horiz,
                    color: colorScheme.appInversedtext,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: AccountCardMetric(
                    label: 'Available Credit',
                    value: availableCredit.toCurrency(),
                  ),
                ),
                Expanded(
                  child: AccountCardMetric(
                    label: 'Credit Limit',
                    value: creditLimit.toCurrency(),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            LinearProgressIndicator(
              color: utilizationColor,
              backgroundColor: colorScheme.appInversedtext,
              value: utilization.clamp(0.0, 1.0),
              minHeight: 6,
              borderRadius: BorderRadius.circular(10),
            ),

            const SizedBox(height: 6),

            Text(
              '${(utilization * 100).toStringAsFixed(1)}% utilized',
              style: AppTextStyle.bodyS.copyWith(
                color: colorScheme.appInversedtextMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
