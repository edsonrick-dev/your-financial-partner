import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/home/widgets/budget_progress_bar.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

class BudgetTile extends StatelessWidget {
  const BudgetTile({
    super.key,
    required this.budget,
    required this.consumption,
    required this.budgetName,
    required this.iconKey,
  });
  final double budget;
  final double consumption;
  final String budgetName;
  final String iconKey;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    double remainingBalance = budget - consumption;
    bool isOverBudget = remainingBalance < 0;
    double consumptionPercentage = budget <= 0
        ? 0
        : (consumption / budget).clamp(0.0, 1.0);

    Color progressColor;
    if (consumptionPercentage >= 1) {
      progressColor = colorScheme.appOutflow;
    } else if (consumptionPercentage >= 0.8) {
      progressColor = colorScheme.appAccent;
    } else {
      progressColor = colorScheme.appInflow;
    }
    return AdaptivePressable(
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        constraints: BoxConstraints(minHeight: 60),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  AppIcons.categories.resolve(iconKey),
                  color: colorScheme.appSuccess,
                ),
                Opacity(
                  opacity: 0.2,
                  child: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.appSuccess,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        budgetName,
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                      Spacer(),
                      Text(
                        '${remainingBalance.abs().toCurrency()} ${isOverBudget ? 'over' : 'left'}',
                        style: TextStyle(
                          color: progressColor,
                          fontWeight: FontWeight.w500,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        consumption.toCurrency(),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),

                      Text(
                        ' / ${budget.toCurrency()}',
                        style: TextStyle(
                          color: colorScheme.appTextMuted,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                      Spacer(),

                      Text(
                        '${(consumptionPercentage * 100).round()}%',
                        style: TextStyle(
                          color: colorScheme.appTextMuted,
                          fontWeight: FontWeight.w500,
                          fontFeatures: [FontFeature.tabularFigures()],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  BudgetProgressBar(
                    progress: consumptionPercentage,
                    // marker: 0.90, // optional
                    color: progressColor,
                  ),
                ],
              ),
            ),
            SizedBox(width: 8),
          ],
        ),
      ),
    );
  }
}
