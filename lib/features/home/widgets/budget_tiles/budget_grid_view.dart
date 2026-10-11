import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/home/widgets/budget_tile.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/spend_transaction/spend_transaction_sheet.dart';

class BudgetGridView extends StatelessWidget {
  const BudgetGridView({
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
    if (consumptionPercentage >= 1) {
      progressColor = colorScheme.appOutflow;
    } else if (consumptionPercentage >= 0.8) {
      progressColor = colorScheme.appAccent;
    } else {
      progressColor = colorScheme.appInflow;
    }

    return AdaptivePressable(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        AppSheets.transaction.spend(categoryId: categoryId);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          // border: Border.all(color: colorScheme.appBorder),
        ),
        constraints: BoxConstraints(minHeight: 62),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Icon(AppIcons.categories.resolve(iconKey), size: 16),
                    // const SizedBox(width: 4),
                    Text(budgetName, style: AppTextStyle.titleM, maxLines: 1),
                  ],
                ),
              ),
              // SizedBox(height: 4),
              Stack(
                alignment: Alignment.center,
                children: [
                  Text(
                    '${(consumptionPercentage * 100).round()}%',
                    style: AppTextStyle.amountXS,
                  ),
                  CustomPaint(
                    size: const Size(50, 50),
                    painter: BudgetConsumptionGuagePainter(
                      backgroundColor: colorScheme.bg,
                      progress: consumptionPercentage,
                    ),
                  ),
                ],
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  '${remainingBalance.abs().toCurrency()} ${isOverBudget ? 'over' : 'left'}',
                  style: AppTextStyle.amountXS.copyWith(color: progressColor),
                ),
              ),

              SizedBox(width: 8),

              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  consumption.toCurrency(),
                  style: AppTextStyle.amountS,
                ),
              ),
              FittedBox(
                child: Text(
                  'out of ${budget.toCurrency()}',
                  style: AppTextStyle.amountXS.copyWith(
                    color: colorScheme.appTextMuted.withAlpha(160),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
