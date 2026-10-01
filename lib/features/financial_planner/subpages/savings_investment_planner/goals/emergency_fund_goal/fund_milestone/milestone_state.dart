import 'package:getx_drift_app/features/profile/financial_ratios/emergency_fund_ratio_scoring.dart';
import 'package:getx_drift_app/features/profile/models/ratio_score_band.dart';

enum MilestoneState { completed, current, upcoming }

MilestoneState milestoneState(RatioScoreBand milestone, double currentMonths) {
  if (currentMonths >= milestone.milestoneMonths) {
    return MilestoneState.completed;
  }

  return MilestoneState.upcoming;
}
