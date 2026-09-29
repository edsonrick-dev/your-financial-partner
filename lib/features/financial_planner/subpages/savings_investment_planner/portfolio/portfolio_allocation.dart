import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/asset_class/asset_class_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/asset_class/asset_class_profile.dart';

class PortfolioAllocation {
  final AssetClass assetClass;
  final double weight;

  const PortfolioAllocation({required this.assetClass, required this.weight})
    : assert(
        weight >= 0 && weight <= 1,
        'Allocation weight must be between 0% and 100%.',
      );

  AssetClassProfile get profile => assetClassProfiles[assetClass]!;
}
