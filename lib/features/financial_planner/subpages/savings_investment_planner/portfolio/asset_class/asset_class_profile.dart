import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/asset_class/asset_class_enum.dart';

class AssetClassProfile {
  final double expectedReturn;
  final double volatility;

  const AssetClassProfile({
    required this.expectedReturn,
    required this.volatility,
  });
}

final assetClassProfiles = {
  AssetClass.cash: const AssetClassProfile(
    expectedReturn: 0.025,
    volatility: 0.005,
  ),

  AssetClass.localBonds: const AssetClassProfile(
    expectedReturn: 0.050,
    volatility: 0.040,
  ),

  AssetClass.globalBonds: const AssetClassProfile(
    expectedReturn: 0.045,
    volatility: 0.060,
  ),

  AssetClass.localEquities: const AssetClassProfile(
    expectedReturn: 0.090,
    volatility: 0.150,
  ),

  AssetClass.globalEquities: const AssetClassProfile(
    expectedReturn: 0.100,
    volatility: 0.180,
  ),
};
