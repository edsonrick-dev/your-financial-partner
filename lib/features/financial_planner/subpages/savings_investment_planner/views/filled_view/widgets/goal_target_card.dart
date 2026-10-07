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
  final double requiredMonthlyContribution;
  final double currentMonthlyAllocation;
  final DateTime? dueDate;
  final VoidCallback? onTap;

  GoalDetails({
    this.type = GoalType.general,
    this.name,
    this.iconKey,
    this.target = 0,
    this.current = 0,
    this.requiredMonthlyContribution = 0,
    this.currentMonthlyAllocation = 0,
    this.dueDate,
    this.onTap,
  });

  double get completionRate {
    if (target <= 0) return 0.0;

    return (current / target).clamp(0.0, 1.0);
  }

  double get remainingAmount {
    return (target - current).clamp(0.0, double.infinity);
  }

  bool get isFullyFunded {
    return requiredMonthlyContribution > 0 &&
        currentMonthlyAllocation >= requiredMonthlyContribution;
  }

  bool get isPartiallyFunded {
    return currentMonthlyAllocation > 0 &&
        currentMonthlyAllocation < requiredMonthlyContribution;
  }

  bool get isWaiting {
    return currentMonthlyAllocation <= 0 && requiredMonthlyContribution > 0;
  }

  bool get targetAchieved {
    return target > 0 && current >= target;
  }

  String get fundingStatus {
    if (targetAchieved) {
      return 'Completed';
    }

    if (isFullyFunded) {
      return 'Fully Funded';
    }

    if (isPartiallyFunded) {
      return 'Partially Funded';
    }

    return 'Unfunded';
  }

  IconData get fundingStatusIcon {
    if (targetAchieved) {
      return PhosphorIconsRegular.checkCircle;
    }

    if (isFullyFunded) {
      return PhosphorIconsRegular.checkCircle;
    }

    if (isPartiallyFunded) {
      return PhosphorIconsRegular.circleHalf;
    }

    return PhosphorIconsRegular.clock;
  }
}

class GoalTargetCard extends GetView<SavingsPlannerController> {
  const GoalTargetCard({super.key, required this.goal});

  final GoalDetails goal;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppCard(
      onTap: goal.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Goal title
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                goal.iconKey != null
                    ? AppIcons.categories.resolve(goal.iconKey!)
                    : goal.type.icon,
                size: 24,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  goal.name ?? goal.type.title,
                  style: AppTextStyle.titleL,
                ),
              ),
              const SizedBox(width: 12),
              SizedBox(
                height: 24,
                child: Row(
                  children: [
                    Text(goal.fundingStatus, style: AppTextStyle.labelM),
                    SizedBox(width: 4),
                    Icon(goal.fundingStatusIcon, size: 16),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Progress
          LinearProgressIndicator(
            value: goal.completionRate,
            minHeight: 8,
            borderRadius: BorderRadius.circular(10),
            backgroundColor: colorScheme.appText.withAlpha(40),
            valueColor: AlwaysStoppedAnimation(colorScheme.appText),
          ),

          const SizedBox(height: 8),

          // Saved / Target
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Saved',
                      style: AppTextStyle.titleS.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
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
                    Text(
                      'Target',
                      style: AppTextStyle.titleS.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
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

          const SizedBox(height: 16),

          // Required monthly contribution
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: colorScheme.appText.withAlpha(12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              spacing: 8,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Required allocation', style: AppTextStyle.titleS),
                      const SizedBox(height: 2),
                      Text(
                        '${goal.requiredMonthlyContribution.toCurrency()}/mo.',
                        style: AppTextStyle.amountL,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Current allocation', style: AppTextStyle.titleS),
                      const SizedBox(height: 2),
                      Text(
                        '${goal.currentMonthlyAllocation.toCurrency()}/mo.',
                        style: AppTextStyle.amountL,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Target date
          if (goal.dueDate != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(PhosphorIconsRegular.calendarDots, size: 16),
                const SizedBox(width: 8),
                Text(
                  DateFormat('MMMM d, yyyy').format(goal.dueDate!),
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
