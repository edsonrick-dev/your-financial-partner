import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/portfolio_horizon_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/risk_return/risk_return_range_model.dart';

class RetirementHorizonReturns {
  final double short;
  final double medium;
  final double long;

  const RetirementHorizonReturns({
    required this.short,
    required this.medium,
    required this.long,
  });

  double forHorizon(PortfolioHorizon horizon) {
    switch (horizon) {
      case PortfolioHorizon.short:
        return short;
      case PortfolioHorizon.medium:
        return medium;
      case PortfolioHorizon.long:
        return long;
    }
  }

  static Map<PortfolioHorizon, double> calculateHorizonWeights({
    required DateTime currentDate,
    required List<RetirementWithdrawal> futureWithdrawals,
  }) {
    final amounts = <PortfolioHorizon, double>{
      PortfolioHorizon.short: 0,
      PortfolioHorizon.medium: 0,
      PortfolioHorizon.long: 0,
    };

    for (final withdrawal in futureWithdrawals) {
      final horizon = withdrawal.date.portfolioHorizon(from: currentDate);

      amounts[horizon] = amounts[horizon]! + withdrawal.amount;
    }

    final total = amounts.values.fold(0.0, (sum, value) => sum + value);

    if (total == 0) {
      return {
        PortfolioHorizon.short: 0,
        PortfolioHorizon.medium: 0,
        PortfolioHorizon.long: 0,
      };
    }

    return {
      PortfolioHorizon.short: amounts[PortfolioHorizon.short]! / total,
      PortfolioHorizon.medium: amounts[PortfolioHorizon.medium]! / total,
      PortfolioHorizon.long: amounts[PortfolioHorizon.long]! / total,
    };
  }

  static double calculateBlendedRetirementReturn({
    required Map<PortfolioHorizon, double> weights,
    required RetirementHorizonReturns returns,
  }) {
    return weights[PortfolioHorizon.short]! * returns.short +
        weights[PortfolioHorizon.medium]! * returns.medium +
        weights[PortfolioHorizon.long]! * returns.long;
  }
}
