import 'package:flutter/material.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class BudgetCard extends StatelessWidget {
  final String title;
  final String iconKey;
  final double consumption;
  final double budget;
  const BudgetCard({
    super.key,
    required this.title,
    required this.iconKey,
    required this.consumption,
    this.budget = 0,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    double remainingBalance = budget - consumption;
    double consumptionPercentage = budget <= 0
        ? 0
        : (consumption / budget).clamp(0.0, 1.0);
    bool isOverBudget = remainingBalance < 0;
    Color progressColor;

    if (consumptionPercentage >= 1) {
      progressColor = colorScheme.error;
    } else if (consumptionPercentage >= 0.8) {
      progressColor = colorScheme.appText;
    } else {
      progressColor = colorScheme.appText;
    }
    return GestureDetector(
      onTap: () {
        AppSheets.budgetSheets();
      },
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: colorScheme.appBorder, width: 0.5),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 8,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Icon(
                  AppIcons.categories.resolve(iconKey),
                  size: 20,
                  color: colorScheme.appText,
                ),
                Opacity(
                  opacity: 0.1,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: colorScheme.appText,
                    ),
                    height: 36,
                    width: 36,
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                spacing: 12,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: TextStyle(fontSize: 17, height: 20 / 17),
                          ),
                          RichText(
                            text: TextSpan(
                              text: '''Today's Budget''',
                              style: TextStyle(
                                fontSize: 10,
                                height: 12 / 10,
                                color: colorScheme.appTextMuted,
                              ),
                              children: [
                                TextSpan(
                                  text: ' • ',
                                  style: TextStyle(
                                    fontSize: 10,
                                    height: 12 / 10,
                                    color: colorScheme.appTextMuted,
                                  ),
                                ),
                                TextSpan(
                                  text: 'Resets tomorrow',
                                  style: TextStyle(
                                    fontSize: 10,
                                    height: 12 / 10,
                                    color: colorScheme.appTextMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: remainingBalance.abs().toCurrency(),
                              style: TextStyle(
                                fontSize: 17,
                                fontFeatures: [FontFeature.tabularFigures()],
                                height: 20 / 17,
                                color: colorScheme.appText,
                              ),
                              children: [
                                TextSpan(
                                  text: isOverBudget ? ' over' : ' left',
                                  style: TextStyle(
                                    fontSize: 15,
                                    height: 20 / 15,
                                    color: colorScheme.appText,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    spacing: 4,
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          return Container(
                            width: double.infinity,
                            height: 8,
                            decoration: BoxDecoration(
                              color: progressColor.withAlpha(50),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                width:
                                    constraints.maxWidth *
                                    consumptionPercentage,
                                decoration: BoxDecoration(
                                  color: progressColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: consumption.toCurrency(),
                              style: TextStyle(
                                fontSize: 17,
                                height: 20 / 17,
                                fontWeight: FontWeight.bold,
                                color: progressColor,
                              ),
                              children: [
                                TextSpan(
                                  text: ' / ',
                                  style: TextStyle(
                                    fontSize: 15,
                                    height: 20 / 15,
                                    color: colorScheme.appText,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                                TextSpan(
                                  text: budget.toCurrency(),
                                  style: TextStyle(
                                    fontSize: 15,
                                    height: 20 / 15,
                                    color: colorScheme.appText,
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          Text(
                            '${(consumptionPercentage * 100).round()}%',
                            style: TextStyle(
                              fontSize: 15,
                              height: 20 / 15,
                              color: colorScheme.appText,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
