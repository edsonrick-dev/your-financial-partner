enum PortfolioHorizon { short, medium, long }

extension PortfolioHorizonX on PortfolioHorizon {
  String get label {
    switch (this) {
      case PortfolioHorizon.short:
        return '0–2 yrs';

      case PortfolioHorizon.medium:
        return '2–5 yrs';

      case PortfolioHorizon.long:
        return '5+ yrs';
    }
  }

  double get minYears {
    switch (this) {
      case PortfolioHorizon.short:
        return 0;
      case PortfolioHorizon.medium:
        return 2;
      case PortfolioHorizon.long:
        return 5;
    }
  }

  double? get maxYears {
    switch (this) {
      case PortfolioHorizon.short:
        return 2;
      case PortfolioHorizon.medium:
        return 5;
      case PortfolioHorizon.long:
        return null;
    }
  }

  bool contains(double years) {
    final min = minYears;
    final max = maxYears;

    if (max == null) {
      return years >= min;
    }

    return years >= min && years < max;
  }
}

PortfolioHorizon horizonForYears(double years) {
  for (final horizon in PortfolioHorizon.values) {
    final min = horizon.minYears;
    final max = horizon.maxYears;

    if (years >= min && (max == null || years < max)) {
      return horizon;
    }
  }

  return PortfolioHorizon.short;
}
