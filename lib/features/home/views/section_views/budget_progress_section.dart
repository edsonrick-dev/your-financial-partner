import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/home/widgets/budget_progress_indicator.dart';
import 'package:getx_drift_app/features/home/widgets/budget_tile.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

class BudgetProgressSection extends StatelessWidget {
  const BudgetProgressSection({super.key});

  @override
  Widget build(BuildContext context) {
    double spentAmount = 4200;
    double budgetAmount = 10000;
    double progress = spentAmount / budgetAmount;
    final colorScheme = context.colors;
    return AppSection(
      sectionTitle: 'Budget Progress',
      trailingText: 'View All',
      trailingType: SectionTrailingType.textButton,
      onTrailingPressed: () {},
      child: Container(
        // padding: EdgeInsets.all(16),
        constraints: BoxConstraints(minHeight: 44),
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            //Header
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    left: 16.0,
                    top: 16,
                    right: 16,
                  ),
                  child: Row(
                    spacing: 16,
                    children: [
                      BudgetProgressIndicator(
                        progress: progress,
                        progressColor: Colors.green,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              '${(progress * 100).round()}%',
                              style: AppTextStyle.amountM,
                            ),
                            Text('of budget', style: AppTextStyle.labelS),
                          ],
                        ),
                      ),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'July Progress',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                height: 24 / 20,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  spentAmount.toCompactCurrency(
                                    kThreshold: 1000000,
                                  ),
                                  style: AppTextStyle.amountM,
                                ),
                                Text(' spent of '),
                                Text(
                                  budgetAmount.toCompactCurrency(
                                    kThreshold: 1000000,
                                  ),
                                  style: TextStyle(
                                    fontFeatures: [
                                      FontFeature.tabularFigures(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  spacing: 4,
                                  children: [
                                    Container(
                                      width: 8,
                                      height: 8,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: colorScheme.appSuccess,
                                      ),
                                    ),
                                    Text('On Track'),
                                  ],
                                ),
                                Spacer(),
                                Text('18 days left'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 4),
                Divider(
                  indent: 16,
                  endIndent: 16,
                  color: colorScheme.appBorderMuted,
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    left: 8.0,
                    right: 8,
                    bottom: 8,
                  ),
                  child: Column(
                    spacing: 8,
                    children: [
                      BudgetTile(
                        budgetName: 'Groceries',
                        iconKey: 'basket',
                        consumption: 5250,
                        budget: 8000,
                      ),
                      BudgetTile(
                        budgetName: 'Dining Out',
                        iconKey: 'hamburger',
                        budget: 2400,
                        consumption: 1850,
                      ),
                      BudgetTile(
                        budgetName: 'Transportation',
                        iconKey: 'car',
                        budget: 4000,
                        consumption: 2150,
                      ),
                      BudgetTile(
                        budgetName: 'Utilities',
                        iconKey: 'lightning',
                        budget: 6500,
                        consumption: 4800,
                      ),
                      BudgetTile(
                        budgetName: 'Shopping',
                        iconKey: 'gift',
                        budget: 3000,
                        consumption: 4200,
                      ),
                    ],
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
