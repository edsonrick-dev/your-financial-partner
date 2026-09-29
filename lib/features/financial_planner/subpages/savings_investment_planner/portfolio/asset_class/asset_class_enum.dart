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
}
