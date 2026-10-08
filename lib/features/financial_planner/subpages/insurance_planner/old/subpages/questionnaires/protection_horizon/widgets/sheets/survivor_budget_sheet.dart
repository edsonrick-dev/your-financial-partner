import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';

class SurvivorBudgetSheet extends StatefulWidget {
  const SurvivorBudgetSheet({
    super.key,
    required this.plan,
    required this.survivorShare,
    required this.onShareChanged,
  });

  final SavedCashflowPlanData plan;
  final double survivorShare;
  final ValueChanged<double> onShareChanged;

  @override
  State<SurvivorBudgetSheet> createState() => _SurvivorBudgetSheetState();
}

class _SurvivorBudgetSheetState extends State<SurvivorBudgetSheet> {
  late double survivorShare;

  @override
  void initState() {
    super.initState();
    survivorShare = widget.survivorShare;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final annualAmount = widget.plan.budgetPeriod.toAnnual(widget.plan.amount);

    final survivorAnnualAmount = annualAmount * survivorShare;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 12,
          bottom: context.bottomPaddingSub,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: colorScheme.appTextMuted,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Category
            Row(
              children: [
                Icon(
                  AppIcons.categories.resolve(widget.plan.iconKey),
                  size: 22,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(widget.plan.category, style: AppTextStyle.titleL),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              'How much of this expense would remain?',
              style: AppTextStyle.headlineM,
            ),

            const SizedBox(height: 8),

            Text(
              'Choose the portion your family would still need to cover.',
              style: AppTextStyle.bodyM.copyWith(color: colorScheme.appText),
            ),

            const SizedBox(height: 28),

            // Percentage
            Center(
              child: Text(
                '${(survivorShare * 100).round()}%',
                style: AppTextStyle.amountXL,
              ),
            ),

            const SizedBox(height: 4),

            Center(
              child: Text(
                survivorAnnualAmount.toCurrency(),
                style: AppTextStyle.amountL.copyWith(
                  color: colorScheme.appTextMuted,
                ),
              ),
            ),

            const SizedBox(height: 24),

            Slider(
              padding: EdgeInsets.all(0),
              value: survivorShare,
              min: 0,
              max: 1,
              divisions: 20,
              onChanged: (value) {
                setState(() {
                  survivorShare = value;
                });
              },
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('0%', style: AppTextStyle.labelM),
                Text('100%', style: AppTextStyle.labelM),
              ],
            ),

            const SizedBox(height: 28),
            AppButton(
              text: 'Done',
              onTap: () {
                widget.onShareChanged(survivorShare);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
