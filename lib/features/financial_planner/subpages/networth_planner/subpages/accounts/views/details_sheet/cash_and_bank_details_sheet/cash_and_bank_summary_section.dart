import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/cash_and_bank_details_sheet/update_account_balance_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/widgets/account_card_metric.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/num_extension.dart';

class CashAndBankSummarySection extends GetView<AccountController> {
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
            if (totalFund < 0) ...[
              const SizedBox(height: 20),
              AppButton(
                size: ButtonSize.medium,
                text: 'Balance update needed',
                isInversed: true,
                onTap: () {
                  controller.initializeBalanceUpdate(account);
                  Get.bottomSheet(
                    UpdateAccountBalanceSheet(account: account),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                  );
                },
                type: ButtonType.outline,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
