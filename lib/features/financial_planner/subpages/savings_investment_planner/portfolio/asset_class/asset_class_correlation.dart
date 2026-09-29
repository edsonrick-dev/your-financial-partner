import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/asset_class/asset_class_enum.dart';

class AssetClassCorrelation {
  static double between(AssetClass a, AssetClass b) {
    if (a == b) {
      return 1.0;
    }

    // Temporary values only.
    // These should eventually come from your chosen methodology/data source.

    final pair = {a, b};

    if (pair.contains(AssetClass.localEquities) &&
        pair.contains(AssetClass.globalEquities)) {
      return 0.80;
    }

    if (pair.contains(AssetClass.localEquities) &&
        pair.contains(AssetClass.localBonds)) {
      return 0.20;
    }

    if (pair.contains(AssetClass.globalEquities) &&
        pair.contains(AssetClass.globalBonds)) {
      return 0.20;
    }

    if (pair.contains(AssetClass.localBonds) &&
        pair.contains(AssetClass.globalBonds)) {
      return 0.60;
    }

    if (pair.contains(AssetClass.cash)) {
      return 0.05;
    }

    return 0.30;
  }
}
