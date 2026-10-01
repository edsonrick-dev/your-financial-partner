import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';

class GoalTypeCard extends StatelessWidget {
  const GoalTypeCard({super.key, required this.goal, required this.onTap});

  final VoidCallback onTap;
  final GoalType goal;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(16),
          boxShadow: AppShadows.card(colorScheme.appText),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(goal.icon),
                SizedBox(width: 8),
                Text(goal.title, style: AppTextStyle.titleL),
              ],
            ),

            const SizedBox(height: 12),

            Text(
              goal.shortDescription,
              style: AppTextStyle.bodyM.copyWith(
                color: colorScheme.appTextMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
