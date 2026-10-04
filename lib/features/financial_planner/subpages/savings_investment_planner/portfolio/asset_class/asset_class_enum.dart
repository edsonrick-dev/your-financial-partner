import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum AssetClass { cash, localBonds, globalBonds, localEquities, globalEquities }

extension AssetClassX on AssetClass {
  String get label {
    switch (this) {
      case AssetClass.cash:
        return 'Cash';

      case AssetClass.localBonds:
        return 'Local Bonds';

      case AssetClass.globalBonds:
        return 'Global Bonds';

      case AssetClass.localEquities:
        return 'Local Equities';

      case AssetClass.globalEquities:
        return 'Global Equities';
    }
  }

  Color color(BuildContext context) {
    switch (this) {
      case AssetClass.cash:
        return context.colors.portfolioCash;

      case AssetClass.localBonds:
        return context.colors.portfolioLocalBonds;

      case AssetClass.globalBonds:
        return context.colors.portfolioGlobalBonds;

      case AssetClass.localEquities:
        return context.colors.portfolioLocalEquities;

      case AssetClass.globalEquities:
        return context.colors.portfolioGlobalEquities;
    }
  }

  IconData icon() {
    switch (this) {
      case AssetClass.cash:
        return PhosphorIconsRegular.money;

      case AssetClass.localBonds:
        return PhosphorIconsRegular.bank;

      case AssetClass.globalBonds:
        return PhosphorIconsRegular.globe;

      case AssetClass.localEquities:
        return PhosphorIconsRegular.chartLineUp;

      case AssetClass.globalEquities:
        return PhosphorIconsRegular.globeHemisphereWest;
    }
  }
}
