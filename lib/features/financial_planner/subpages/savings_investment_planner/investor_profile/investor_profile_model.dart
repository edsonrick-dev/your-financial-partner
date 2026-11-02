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

  String get description {
    switch (this) {
      case InvestorProfile.capitalPreserver:
        return 'You place a strong priority on protecting your money and avoiding large fluctuations. You tend to prefer stability and are more comfortable with lower-risk investments, even when that means accepting more modest growth.';

      case InvestorProfile.cautiousBuilder:
        return 'You value stability while still wanting your money to grow. You are generally comfortable taking some investment risk, but prefer a more cautious balance between protecting your capital and pursuing higher returns.';

      case InvestorProfile.balancedInvestor:
        return 'You are comfortable balancing growth with stability. You can accept some market fluctuations in exchange for the opportunity for higher long-term returns, while still keeping part of your portfolio in more defensive investments.';

      case InvestorProfile.growthSeeker:
        return 'You are comfortable taking above-average investment risk in pursuit of greater long-term growth. You can generally tolerate larger market fluctuations when you have enough time for your investments to recover.';

      case InvestorProfile.aggressiveVisionary:
        return 'You are comfortable accepting significant investment risk and larger market swings in pursuit of higher long-term growth. You are generally more willing to prioritize growth over short-term stability.';
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
