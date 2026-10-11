import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/app_opacity.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/home/widgets/budget_progress_bar.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/spend_transaction/spend_transaction_sheet.dart';

class BudgetListView extends StatelessWidget {
  const BudgetListView({
    super.key,
    required this.budget,
    required this.consumption,
    required this.budgetName,
    required this.iconKey,
    required this.categoryId,
  });

  final double budget;
  final double consumption;
  final String budgetName;
  final String iconKey;
  final int categoryId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    double remainingBalance = budget - consumption;
    bool isOverBudget = remainingBalance < 0;
    double consumptionPercentage = budget <= 0
        ? 0
        : (consumption / budget).clamp(0.0, 1.0);

    Color progressColor;
    if (consumptionPercentage > 1) {
      progressColor = colorScheme.appOutflow;
    } else if (consumptionPercentage >= 0.8) {
      progressColor = colorScheme.appAccent;
    } else {
      progressColor = colorScheme.appInflow;
    }

    // Color iconColor = colorScheme.appInfo;
    return AdaptivePressable(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        AppSheets.transaction.spend(categoryId: categoryId);
      },
      child: Container(
        // color: colorScheme.appAccent,
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        constraints: BoxConstraints(minHeight: 60),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 44,
                  height: 44,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: AppOpacity.transactionIcon,
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: colorScheme.appText,
                          ),
                        ),
                      ),
                      Icon(
                        AppIcons.categories.resolve(iconKey),
                        size: 20,
                        color: colorScheme.appText,
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              budgetName,
                              style: AppTextStyle.titleL,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          SizedBox(width: 8),

                          RichText(
                            text: TextSpan(
                              style: AppTextStyle.bodyS.copyWith(
                                color: progressColor,
                              ),
                              children: [
                                TextSpan(
                                  text: remainingBalance.abs().toCurrency(),
                                  style: AppTextStyle.amountL,
                                ),

                                TextSpan(
                                  text: ' ${isOverBudget ? 'over' : 'left'}',
                                  style: TextStyle(
                                    color: progressColor.withValues(alpha: 0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: RichText(
                              text: TextSpan(
                                style: AppTextStyle.amountXS.copyWith(
                                  color: colorScheme.appTextMuted,
                                ),
                                children: [
                                  TextSpan(
                                    text: consumption.toCurrency(),
                                    style: AppTextStyle.amountM.copyWith(
                                      color: colorScheme.appText,
                                    ),
                                  ),
                                  const TextSpan(text: ' / '),
                                  TextSpan(text: budget.toCurrency()),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: 12),

                          Text(
                            '${(consumptionPercentage * 100).round()}% used',
                            style: AppTextStyle.amountM.copyWith(
                              color: colorScheme.appTextMuted,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            BudgetProgressBar(
              height: 8,
              progress: consumptionPercentage,
              color: progressColor,
            ),
          ],
        ),
      ),
    );
  }
}
