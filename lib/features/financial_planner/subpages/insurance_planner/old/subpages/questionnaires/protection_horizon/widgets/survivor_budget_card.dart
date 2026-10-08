import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/subpages/questionnaires/protection_horizon/widgets/sheets/survivor_budget_sheet.dart';

class SurvivorBudgetCard extends StatelessWidget {
  const SurvivorBudgetCard({
    super.key,
    required this.plan,
    required this.survivorShare,
    required this.onShareChanged,
  });

  final SavedCashflowPlanData plan;
  final double survivorShare;
  final ValueChanged<double> onShareChanged;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final annualAmount = plan.budgetPeriod.toAnnual(plan.amount);
    final survivorAnnualAmount = annualAmount * survivorShare;

    return AdaptivePressable(
      onTap: () {
        Get.bottomSheet(
          SurvivorBudgetSheet(
            plan: plan,
            survivorShare: survivorShare,
            onShareChanged: onShareChanged,
          ),
          isScrollControlled: true,
          backgroundColor: colorScheme.bgLight,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: colorScheme.appBorder),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Icon(AppIcons.categories.resolve(plan.iconKey), size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(plan.category, style: AppTextStyle.titleL),
                      Text(
                        survivorAnnualAmount.toCurrency(),
                        style: AppTextStyle.amountS.copyWith(),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  '${(survivorShare * 100).toStringAsFixed(0)}%',
                  style: AppTextStyle.amountL,
                ),
              ],
            ),
            // Column(
            //   crossAxisAlignment: CrossAxisAlignment.start,
            //   children: [
            //     const SizedBox(height: 4),

            //     const SizedBox(height: 8),
            //     Text(
            //       '${survivorAnnualAmount.toCurrency()} / year survivor budget',
            //       style: AppTextStyle.bodyM,
            //     ),
            //   ],
            // ),
            // Icon(
            //   PhosphorIconsRegular.caretRight,
            //   color: colorScheme.appTextMuted,
            // ),
          ],
        ),
      ),
    );
  }
}
