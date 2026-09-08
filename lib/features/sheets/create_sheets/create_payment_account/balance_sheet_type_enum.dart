enum BalanceSheetType {
  asset,
  liability;

  String get plural => switch (this) {
    BalanceSheetType.asset => 'Assets',
    BalanceSheetType.liability => 'Liabilities',
  };
}
