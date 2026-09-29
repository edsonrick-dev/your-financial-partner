import 'dart:math';

import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/investor_profile/investory_profile_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/asset_class/asset_class_correlation.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/portfolio_allocation.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/portfolio_horizon_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/risk_return/risk_return_range_model.dart';

class PortfolioRecommendation {
  final InvestorProfile profile;
  final PortfolioHorizon horizon;
  final List<PortfolioAllocation> allocations;

  PortfolioRecommendation({
    required this.profile,
    required this.horizon,
    required this.allocations,
  }) : assert(
         allocations.isNotEmpty &&
             _isValidAllocationTotal(allocations) &&
             _hasUniqueAssetClasses(allocations),
         'Portfolio recommendation contains invalid allocations.',
       );

  static bool _isValidAllocationTotal(List<PortfolioAllocation> allocations) {
    final total = allocations.fold<double>(
      0,
      (sum, allocation) => sum + allocation.weight,
    );

    return (total - 1.0).abs() < 0.000001;
  }

  static bool _hasUniqueAssetClasses(List<PortfolioAllocation> allocations) {
    final assetClasses = allocations.map((allocation) => allocation.assetClass);

    return assetClasses.length == assetClasses.toSet().length;
  }

  double get totalWeight {
    return allocations.fold(0.0, (sum, allocation) => sum + allocation.weight);
  }

  double get totalPercentage => totalWeight * 100;

  double get expectedReturn {
    return allocations.fold<double>(
      0,
      (sum, allocation) =>
          sum + allocation.weight * allocation.profile.expectedReturn,
    );
  }

  double get volatility {
    double variance = 0.0;

    for (final allocationA in allocations) {
      for (final allocationB in allocations) {
        final weightA = allocationA.weight;
        final weightB = allocationB.weight;

        final volatilityA = allocationA.profile.volatility;
        final volatilityB = allocationB.profile.volatility;

        final correlation = AssetClassCorrelation.between(
          allocationA.assetClass,
          allocationB.assetClass,
        );

        final covariance = volatilityA * volatilityB * correlation;

        variance += weightA * weightB * covariance;
      }
    }

    // Protect against tiny floating-point negative values.
    return sqrt(variance.clamp(0.0, double.infinity));
  }

  RiskReturnRange get returnRange {
    return RiskReturnRange(
      average: expectedReturn,
      standardDeviation: volatility,
    );
  }
}
