import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/fund_milestone/milestone_state.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/emergency_fund_ratio_scoring.dart';
import 'package:getx_drift_app/features/profile/models/ratio_score_band.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FundMilestoneTile extends StatelessWidget {
  const FundMilestoneTile({
    super.key,
    required this.band,
    required this.monthlyBudget,
    required this.currentMonths,
    required this.isNextMilestone,
  });

  final RatioScoreBand band;
  final double monthlyBudget;
  final double currentMonths;
  final bool isNextMilestone;

  @override
  Widget build(BuildContext context) {
    final months = band.milestoneMonths;
    final amount = monthlyBudget * months;

    final state = milestoneState(band, currentMonths);
    final currentAmount = currentMonths * monthlyBudget;
    final monthLabel = months == 1 ? 'month' : 'months';
    final colorScheme = context.colors;

    final previousMilestoneMonths = emergencyFundBands
        .where((band) => band.threshold > 0 && band.milestoneMonths < months)
        .map((band) => band.milestoneMonths)
        .fold<double>(
          0.0,
          (previous, milestone) => milestone > previous ? milestone : previous,
        );

    final previousAmount = monthlyBudget * previousMilestoneMonths;

    final progress =
        ((currentMonths - previousMilestoneMonths) /
                (months - previousMilestoneMonths))
            .clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isNextMilestone) ...[
          EmergencyFundCurrentMarker(
            currentMonths: currentMonths,
            currentAmount: currentAmount,
            previousMonths: previousMilestoneMonths,
            previousAmount: previousAmount,
            nextMonths: months,
            nextAmount: amount,
            progress: progress,
          ),
          const SizedBox(height: 12),
        ],
        Row(
          children: [
            state == MilestoneState.completed
                ? Icon(
                    PhosphorIconsFill.checkCircle,
                    size: 20,
                    color: colorScheme.appInflow,
                  )
                : Icon(PhosphorIconsRegular.circle, size: 20),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${months.toStringAsFixed(0)} $monthLabel',
                      style: AppTextStyle.bodyM,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '(${amount.toCurrency()})',
                      style: AppTextStyle.amountM,
                    ),
                  ],
                ),
                Text(band.category, style: AppTextStyle.titleS),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class EmergencyFundCurrentMarker extends StatelessWidget {
  const EmergencyFundCurrentMarker({
    super.key,
    required this.currentMonths,
    required this.currentAmount,
    required this.previousMonths,
    required this.previousAmount,
    required this.nextMonths,
    required this.nextAmount,
    required this.progress,
  });

  final double currentMonths;
  final double currentAmount;
  final double previousMonths;
  final double previousAmount;
  final double nextMonths;
  final double nextAmount;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final remainingAmount = (nextAmount - currentAmount).clamp(
      0.0,
      double.infinity,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: colorScheme.appInfoSoft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current Progress', style: AppTextStyle.titleM),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: RichText(
              text: TextSpan(
                style: AppTextStyle.titleL.copyWith(color: colorScheme.appText),
                children: [
                  TextSpan(text: currentMonths.toStringAsFixed(1)),
                  const TextSpan(text: ' mo. ('),
                  TextSpan(
                    text: currentAmount.toCurrency(),
                    style: AppTextStyle.amountL,
                  ),
                  const TextSpan(text: ')'),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            borderRadius: BorderRadius.circular(8),
            color: colorScheme.appInfo,
            backgroundColor: colorScheme.appText.withValues(alpha: 0.2),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Text(previousAmount.toCurrency(), style: AppTextStyle.amountS),
              const Spacer(),
              Text(nextAmount.toCurrency(), style: AppTextStyle.amountS),
            ],
          ),

          const SizedBox(height: 8),

          Text(
            '${remainingAmount.toCurrency()} to reach '
            '${nextMonths.toStringAsFixed(0)} months',
            style: AppTextStyle.bodyM.copyWith(color: colorScheme.appTextMuted),
          ),
        ],
      ),
    );
  }
}
