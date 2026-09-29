import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/investor_profile/investory_profile_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/asset_class/asset_class_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/portfolio_allocation.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/portfolio_horizon_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/portfolio_recommendation/portfolio_recommendation.dart';

class PortfolioRecommendationEngine {
  static PortfolioRecommendation getRecommendation({
    required InvestorProfile profile,
    required PortfolioHorizon horizon,
  }) {
    return _recommendations[profile]![horizon]!;
  }

  static final Map<
    InvestorProfile,
    Map<PortfolioHorizon, PortfolioRecommendation>
  >
  _recommendations = {
    InvestorProfile.capitalPreserver: {
      PortfolioHorizon.short: PortfolioRecommendation(
        profile: InvestorProfile.capitalPreserver,
        horizon: PortfolioHorizon.short,
        allocations: [
          PortfolioAllocation(assetClass: AssetClass.cash, weight: 0.60), // 60%
          PortfolioAllocation(
            assetClass: AssetClass.localBonds,
            weight: 0.25,
          ), // 25%
          PortfolioAllocation(
            assetClass: AssetClass.globalBonds,
            weight: 0.10,
          ), // 10%
          PortfolioAllocation(
            assetClass: AssetClass.localEquities,
            weight: 0.03,
          ), // 3%
          PortfolioAllocation(
            assetClass: AssetClass.globalEquities,
            weight: 0.02,
          ), // 2%
        ],
      ),
      PortfolioHorizon.medium: PortfolioRecommendation(
        profile: InvestorProfile.capitalPreserver,
        horizon: PortfolioHorizon.medium,
        allocations: [
          PortfolioAllocation(assetClass: AssetClass.cash, weight: 0.35), // 35%
          PortfolioAllocation(
            assetClass: AssetClass.localBonds,
            weight: 0.35,
          ), // 35%
          PortfolioAllocation(
            assetClass: AssetClass.globalBonds,
            weight: 0.20,
          ), // 20%
          PortfolioAllocation(
            assetClass: AssetClass.localEquities,
            weight: 0.05,
          ), // 5%
          PortfolioAllocation(
            assetClass: AssetClass.globalEquities,
            weight: 0.05,
          ), // 5%
        ],
      ),
      PortfolioHorizon.long: PortfolioRecommendation(
        profile: InvestorProfile.capitalPreserver,
        horizon: PortfolioHorizon.long,
        allocations: [
          PortfolioAllocation(assetClass: AssetClass.cash, weight: 0.20), // 20%
          PortfolioAllocation(
            assetClass: AssetClass.localBonds,
            weight: 0.40,
          ), // 40%
          PortfolioAllocation(
            assetClass: AssetClass.globalBonds,
            weight: 0.25,
          ), // 25%
          PortfolioAllocation(
            assetClass: AssetClass.localEquities,
            weight: 0.07,
          ), // 7%
          PortfolioAllocation(
            assetClass: AssetClass.globalEquities,
            weight: 0.08,
          ), // 8%
        ],
      ),
    },
    InvestorProfile.cautiousBuilder: {
      PortfolioHorizon.short: PortfolioRecommendation(
        profile: InvestorProfile.cautiousBuilder,
        horizon: PortfolioHorizon.short,
        allocations: [
          PortfolioAllocation(assetClass: AssetClass.cash, weight: 0.50), // 50%
          PortfolioAllocation(
            assetClass: AssetClass.localBonds,
            weight: 0.30,
          ), // 30%
          PortfolioAllocation(
            assetClass: AssetClass.globalBonds,
            weight: 0.12,
          ), // 12%
          PortfolioAllocation(
            assetClass: AssetClass.localEquities,
            weight: 0.04,
          ), // 4%
          PortfolioAllocation(
            assetClass: AssetClass.globalEquities,
            weight: 0.04,
          ), // 4%
        ],
      ),
      PortfolioHorizon.medium: PortfolioRecommendation(
        profile: InvestorProfile.cautiousBuilder,
        horizon: PortfolioHorizon.medium,
        allocations: [
          PortfolioAllocation(assetClass: AssetClass.cash, weight: 0.25), // 25%
          PortfolioAllocation(
            assetClass: AssetClass.localBonds,
            weight: 0.40,
          ), // 40%
          PortfolioAllocation(
            assetClass: AssetClass.globalBonds,
            weight: 0.20,
          ), // 20%
          PortfolioAllocation(
            assetClass: AssetClass.localEquities,
            weight: 0.07,
          ), // 7%
          PortfolioAllocation(
            assetClass: AssetClass.globalEquities,
            weight: 0.08,
          ), // 8%
        ],
      ),
      PortfolioHorizon.long: PortfolioRecommendation(
        profile: InvestorProfile.cautiousBuilder,
        horizon: PortfolioHorizon.long,
        allocations: [
          PortfolioAllocation(assetClass: AssetClass.cash, weight: 0.10), // 10%
          PortfolioAllocation(
            assetClass: AssetClass.localBonds,
            weight: 0.40,
          ), // 40%
          PortfolioAllocation(
            assetClass: AssetClass.globalBonds,
            weight: 0.25,
          ), // 25%
          PortfolioAllocation(
            assetClass: AssetClass.localEquities,
            weight: 0.10,
          ), // 10%
          PortfolioAllocation(
            assetClass: AssetClass.globalEquities,
            weight: 0.15,
          ), // 15%
        ],
      ),
    },
    InvestorProfile.balancedInvestor: {
      PortfolioHorizon.short: PortfolioRecommendation(
        profile: InvestorProfile.balancedInvestor,
        horizon: PortfolioHorizon.short,
        allocations: [
          PortfolioAllocation(assetClass: AssetClass.cash, weight: 0.45), // 45%
          PortfolioAllocation(
            assetClass: AssetClass.localBonds,
            weight: 0.30,
          ), // 30%
          PortfolioAllocation(
            assetClass: AssetClass.globalBonds,
            weight: 0.15,
          ), // 15%
          PortfolioAllocation(
            assetClass: AssetClass.localEquities,
            weight: 0.05,
          ), // 5%
          PortfolioAllocation(
            assetClass: AssetClass.globalEquities,
            weight: 0.05,
          ), // 5%
        ],
      ),
      PortfolioHorizon.medium: PortfolioRecommendation(
        profile: InvestorProfile.balancedInvestor,
        horizon: PortfolioHorizon.medium,
        allocations: [
          PortfolioAllocation(assetClass: AssetClass.cash, weight: 0.20), // 20%
          PortfolioAllocation(
            assetClass: AssetClass.localBonds,
            weight: 0.35,
          ), // 35%
          PortfolioAllocation(
            assetClass: AssetClass.globalBonds,
            weight: 0.20,
          ), // 20%
          PortfolioAllocation(
            assetClass: AssetClass.localEquities,
            weight: 0.10,
          ), // 10%
          PortfolioAllocation(
            assetClass: AssetClass.globalEquities,
            weight: 0.15,
          ), // 15%
        ],
      ),
      PortfolioHorizon.long: PortfolioRecommendation(
        profile: InvestorProfile.balancedInvestor,
        horizon: PortfolioHorizon.long,
        allocations: [
          PortfolioAllocation(assetClass: AssetClass.cash, weight: 0.10), // 10%
          PortfolioAllocation(
            assetClass: AssetClass.localBonds,
            weight: 0.30,
          ), // 30%
          PortfolioAllocation(
            assetClass: AssetClass.globalBonds,
            weight: 0.20,
          ), // 20%
          PortfolioAllocation(
            assetClass: AssetClass.localEquities,
            weight: 0.15,
          ), // 15%
          PortfolioAllocation(
            assetClass: AssetClass.globalEquities,
            weight: 0.25,
          ), // 25%
        ],
      ),
    },
    InvestorProfile.growthSeeker: {
      PortfolioHorizon.short: PortfolioRecommendation(
        profile: InvestorProfile.growthSeeker,
        horizon: PortfolioHorizon.short,
        allocations: [
          PortfolioAllocation(assetClass: AssetClass.cash, weight: 0.40), // 40%
          PortfolioAllocation(
            assetClass: AssetClass.localBonds,
            weight: 0.30,
          ), // 30%
          PortfolioAllocation(
            assetClass: AssetClass.globalBonds,
            weight: 0.15,
          ), // 15%
          PortfolioAllocation(
            assetClass: AssetClass.localEquities,
            weight: 0.07,
          ), // 7%
          PortfolioAllocation(
            assetClass: AssetClass.globalEquities,
            weight: 0.08,
          ), // 8%
        ],
      ),
      PortfolioHorizon.medium: PortfolioRecommendation(
        profile: InvestorProfile.growthSeeker,
        horizon: PortfolioHorizon.medium,
        allocations: [
          PortfolioAllocation(assetClass: AssetClass.cash, weight: 0.15), // 15%
          PortfolioAllocation(
            assetClass: AssetClass.localBonds,
            weight: 0.30,
          ), // 30%
          PortfolioAllocation(
            assetClass: AssetClass.globalBonds,
            weight: 0.20,
          ), // 20%
          PortfolioAllocation(
            assetClass: AssetClass.localEquities,
            weight: 0.15,
          ), // 15%
          PortfolioAllocation(
            assetClass: AssetClass.globalEquities,
            weight: 0.20,
          ), // 20%
        ],
      ),
      PortfolioHorizon.long: PortfolioRecommendation(
        profile: InvestorProfile.growthSeeker,
        horizon: PortfolioHorizon.long,
        allocations: [
          PortfolioAllocation(assetClass: AssetClass.cash, weight: 0.05), // 5%
          PortfolioAllocation(
            assetClass: AssetClass.localBonds,
            weight: 0.25,
          ), // 25%
          PortfolioAllocation(
            assetClass: AssetClass.globalBonds,
            weight: 0.20,
          ), // 20%
          PortfolioAllocation(
            assetClass: AssetClass.localEquities,
            weight: 0.20,
          ), // 20%
          PortfolioAllocation(
            assetClass: AssetClass.globalEquities,
            weight: 0.30,
          ), // 30%
        ],
      ),
    },
    InvestorProfile.aggressiveVisionary: {
      PortfolioHorizon.short: PortfolioRecommendation(
        profile: InvestorProfile.aggressiveVisionary,
        horizon: PortfolioHorizon.short,
        allocations: [
          PortfolioAllocation(assetClass: AssetClass.cash, weight: 0.35), // 35%
          PortfolioAllocation(
            assetClass: AssetClass.localBonds,
            weight: 0.30,
          ), // 30%
          PortfolioAllocation(
            assetClass: AssetClass.globalBonds,
            weight: 0.15,
          ), // 15%
          PortfolioAllocation(
            assetClass: AssetClass.localEquities,
            weight: 0.10,
          ), // 10%
          PortfolioAllocation(
            assetClass: AssetClass.globalEquities,
            weight: 0.10,
          ), // 10%
        ],
      ),
      PortfolioHorizon.medium: PortfolioRecommendation(
        profile: InvestorProfile.aggressiveVisionary,
        horizon: PortfolioHorizon.medium,
        allocations: [
          PortfolioAllocation(assetClass: AssetClass.cash, weight: 0.10), // 10%
          PortfolioAllocation(
            assetClass: AssetClass.localBonds,
            weight: 0.30,
          ), // 30%
          PortfolioAllocation(
            assetClass: AssetClass.globalBonds,
            weight: 0.20,
          ), // 20%
          PortfolioAllocation(
            assetClass: AssetClass.localEquities,
            weight: 0.17,
          ), // 17%
          PortfolioAllocation(
            assetClass: AssetClass.globalEquities,
            weight: 0.23,
          ), // 23%
        ],
      ),
      PortfolioHorizon.long: PortfolioRecommendation(
        profile: InvestorProfile.aggressiveVisionary,
        horizon: PortfolioHorizon.long,
        allocations: [
          PortfolioAllocation(assetClass: AssetClass.cash, weight: 0.05), // 5%
          PortfolioAllocation(
            assetClass: AssetClass.localBonds,
            weight: 0.15,
          ), // 15%
          PortfolioAllocation(
            assetClass: AssetClass.globalBonds,
            weight: 0.20,
          ), // 20%
          PortfolioAllocation(
            assetClass: AssetClass.localEquities,
            weight: 0.25,
          ), // 25%
          PortfolioAllocation(
            assetClass: AssetClass.globalEquities,
            weight: 0.35,
          ), // 35%
        ],
      ),
    },
  };
}
