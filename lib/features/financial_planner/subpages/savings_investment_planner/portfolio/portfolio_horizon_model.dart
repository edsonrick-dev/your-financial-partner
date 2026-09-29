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
}
