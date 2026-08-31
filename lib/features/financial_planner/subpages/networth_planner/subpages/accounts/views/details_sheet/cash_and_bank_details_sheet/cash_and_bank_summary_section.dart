import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/widgets/account_card_metric.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CashAndBankSummarySection extends StatelessWidget {
  final AccountsTableData account;

  const CashAndBankSummarySection({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    // final reservedFund = account.initialBalance;
    final totalFund = account.currentValue;
    final availableFunds = totalFund;
    final colorScheme = context.colors;
    return AppSection(
      child: Container(
        padding: EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.text, colorScheme.gradient2],
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total Fund',
                        style: AppTextStyle.titleL.copyWith(
                          color: colorScheme.appInversedtextMuted,
                        ),
                      ),
                      const SizedBox(height: 4),

                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          totalFund.toCurrency(),
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
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: 0.2,
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: colorScheme.appInversedtext,
                          ),
                        ),
                      ),
                      Icon(
                        PhosphorIconsRegular.dotsThree,
                        color: colorScheme.text,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: AccountCardMetric(
                    label: 'Available Fund',
                    value: availableFunds.toCurrency(),
                  ),
                ),
                Expanded(
                  child: AccountCardMetric(
                    label: 'Reserved Fund',
                    value: 0.toCurrency(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
