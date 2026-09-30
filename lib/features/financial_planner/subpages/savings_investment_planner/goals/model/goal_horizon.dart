import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/portfolio_horizon_model.dart';

extension GoalHorizonX on DateTime {
  PortfolioHorizon get portfolioHorizon {
    final years = difference(DateTime.now()).inDays / 365.25;

    if (years < 2) {
      return PortfolioHorizon.short;
    }

    if (years < 5) {
      return PortfolioHorizon.medium;
    }

    return PortfolioHorizon.long;
  }
}
