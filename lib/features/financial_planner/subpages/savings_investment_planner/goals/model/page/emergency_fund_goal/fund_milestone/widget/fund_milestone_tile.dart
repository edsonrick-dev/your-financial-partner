import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/page/emergency_fund_goal/fund_milestone/milestone_state.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/emergency_fund_ratio_scoring.dart';
import 'package:getx_drift_app/features/profile/models/ratio_score_band.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class FundMilestoneTile extends StatelessWidget {
  const FundMilestoneTile({
    super.key,
    required this.band,
    required this.monthlyBudget,
    required this.currentMonths,
  });

  final RatioScoreBand band;
  final double monthlyBudget;
  final double currentMonths;

  @override
  Widget build(BuildContext context) {
    final months = band.milestoneMonths;
    final amount = monthlyBudget * months;

    final state = milestoneState(band, currentMonths);

    final monthLabel = months == 1 ? 'month' : 'months';

    return Row(
      children: [
        Icon(
          state == MilestoneState.completed
              ? PhosphorIconsRegular.checkCircle
              : PhosphorIconsRegular.circle,
          size: 20,
        ),
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
                Text('(${amount.toCurrency()})', style: AppTextStyle.amountM),
              ],
            ),
            Text(band.category, style: AppTextStyle.titleS),
          ],
        ),
      ],
    );
  }
}
