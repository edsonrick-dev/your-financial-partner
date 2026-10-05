import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/controller/savings_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GoalDetails {
  final GoalType type;
  final String? name;
  final String? iconKey;
  final double target;
  final double current;
  final DateTime? dueDate;
  final VoidCallback? onTap;

  GoalDetails({
    this.type = GoalType.general,
    this.name,
    this.iconKey,
    this.target = 0,
    this.current = 0,
    this.dueDate,
    this.onTap,
  });

  double get completionRate => target > 0 ? current / target : 0.0;
  double get remainingAmount => (target - current).clamp(0.0, double.infinity);
}

class GoalTargetCard extends GetView<SavingsPlannerController> {
  const GoalTargetCard({super.key, required this.goal});
  final GoalDetails goal;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final statusColor = colorScheme.appText;
    return AppCard(
      onTap: goal.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                goal.iconKey != null
                    ? AppIcons.categories.resolve(goal.iconKey!)
                    : goal.type.icon,
                size: 24,
              ),
              SizedBox(width: 8),
              Expanded(
                child: Text(
                  goal.name ?? goal.type.title,
                  style: AppTextStyle.titleL,
                ),
              ),
            ],
          ),

          SizedBox(height: 16),

          LinearProgressIndicator(
            value: goal.completionRate,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
            backgroundColor: colorScheme.appText.withAlpha(40),
            valueColor: AlwaysStoppedAnimation(statusColor),
          ),

          SizedBox(height: 8),

          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Saved',
                          style: AppTextStyle.titleS.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),
                      ],
                    ),

                    Text(
                      goal.current.toCompactCurrency(),
                      style: AppTextStyle.amountL,
                    ),
                    Text(
                      '${(goal.completionRate * 100).toStringAsFixed(1)}% complete',
                      style: AppTextStyle.bodyS.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Target',
                          style: AppTextStyle.titleS.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      goal.target.toCompactCurrency(),
                      style: AppTextStyle.amountL,
                    ),
                    Text(
                      '${goal.remainingAmount.toCompactCurrency()} remaining',
                      style: AppTextStyle.bodyS.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (goal.dueDate != null) ...[
            SizedBox(height: 12),
            Row(
              children: [
                Icon(PhosphorIconsRegular.calendarDots, size: 16),
                SizedBox(width: 8),
                Text(
                  DateFormat("MMMM d, yyyy").format(goal.dueDate!),
                  style: AppTextStyle.bodyS,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
