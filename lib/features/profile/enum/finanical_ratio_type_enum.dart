enum FinancialRatioType {
  debtLoad,
  emergencyFund,
  wealthBuilding,
  lifestyleCoverage,
}

extension FinancialRatioTypeExtension on FinancialRatioType {
  String get displayName {
    switch (this) {
      case FinancialRatioType.debtLoad:
        return 'Debt Load Ratio';

      case FinancialRatioType.emergencyFund:
        return 'Emergency Fund Ratio';

      case FinancialRatioType.wealthBuilding:
        return 'Wealth Building Rate';

      case FinancialRatioType.lifestyleCoverage:
        return 'Lifestyle Coverage Ratio';
    }
  }

  String get shortName {
    switch (this) {
      case FinancialRatioType.debtLoad:
        return 'DLR';

      case FinancialRatioType.emergencyFund:
        return 'EFR';

      case FinancialRatioType.wealthBuilding:
        return 'WBR';

      case FinancialRatioType.lifestyleCoverage:
        return 'LCR';
    }
  }

  String formatValue(double value) {
    switch (this) {
      case FinancialRatioType.debtLoad:
        return '${value.toStringAsFixed(0)}%';

      case FinancialRatioType.emergencyFund:
        return '${value.round()} months';

      case FinancialRatioType.wealthBuilding:
        return '${value.toStringAsFixed(0)}%';

      case FinancialRatioType.lifestyleCoverage:
        return '${value.toStringAsFixed(1)}×';
    }
  }
}
