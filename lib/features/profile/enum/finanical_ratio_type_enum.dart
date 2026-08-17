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
        return 'Debt Load';

      case FinancialRatioType.emergencyFund:
        return 'Emergency Fund';

      case FinancialRatioType.wealthBuilding:
        return 'Wealth Building';

      case FinancialRatioType.lifestyleCoverage:
        return 'Lifestyle Coverage';
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

  String get shortDescription {
    switch (this) {
      case FinancialRatioType.debtLoad:
        return 'The financial weight of your debt payments.';

      case FinancialRatioType.emergencyFund:
        return 'The financial safety net you have for emergencies.';

      case FinancialRatioType.wealthBuilding:
        return 'The pace at which you are building wealth.';

      case FinancialRatioType.lifestyleCoverage:
        return 'How well your wealth can support your lifestyle.';
    }
  }

  String get longDescription {
    switch (this) {
      case FinancialRatioType.debtLoad:
        return 'Debt Load Ratio measures the portion of your income allocated to required debt repayments, indicating the level of cash-flow pressure created by debt and how much income remains available for lifestyle needs and wealth building.';

      case FinancialRatioType.emergencyFund:
        return 'Emergency Fund Ratio evaluates the adequacy of your readily accessible liquid funds relative to your total allocation requirements.';

      case FinancialRatioType.wealthBuilding:
        return 'Wealth Building Rate measures how much of your income is consistently directed toward long-term financial growth, such as savings, investments, retirement funds, and other future-oriented goals.';

      case FinancialRatioType.lifestyleCoverage:
        return 'Lifestyle Coverage Ratio evaluates how strongly your accumulated net worth can sustain your lifestyle allocation, which includes living expenses and required debt repayments.';
    }
  }
}
