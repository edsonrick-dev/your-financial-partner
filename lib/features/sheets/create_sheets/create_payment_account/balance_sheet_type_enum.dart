enum BalanceSheetType {
  asset,
  liability;

  String get pluralLabel => switch (this) {
    BalanceSheetType.asset => 'assets',
    BalanceSheetType.liability => 'liabilities',
  };
}
