import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/risk_tolerance_controller.dart';

enum InvestorProfile {
  capitalPreserver,
  cautiousBuilder,
  balancedInvestor,
  growthSeeker,
  aggressiveVisionary,
}

extension InvestorProfileX on InvestorProfile {
  String get label {
    switch (this) {
      case InvestorProfile.capitalPreserver:
        return 'Capital Preserver';

      case InvestorProfile.cautiousBuilder:
        return 'Cautious Builder';

      case InvestorProfile.balancedInvestor:
        return 'Balanced Investor';

      case InvestorProfile.growthSeeker:
        return 'Growth Seeker';

      case InvestorProfile.aggressiveVisionary:
        return 'Aggressive Visionary';
    }
  }
}

extension InvestorProfileC on RiskToleranceController {
  InvestorProfile? get investorProfile {
    if (!isComplete) {
      return null;
    }

    final score = totalScore;

    if (score <= 10) {
      return InvestorProfile.capitalPreserver;
    }

    if (score <= 17) {
      return InvestorProfile.cautiousBuilder;
    }

    if (score <= 25) {
      return InvestorProfile.balancedInvestor;
    }

    if (score <= 32) {
      return InvestorProfile.growthSeeker;
    }

    return InvestorProfile.aggressiveVisionary;
  }
}
