import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/risk_return/risk_return_range_model.dart';

class RiskReturnPreferenceQuestion {
  static const String question =
      'Review the chart below: We’ve outlined the most likely '
      'best-case and worst-case annual returns of five hypothetical '
      'investment plans. Which range of possible outcomes is most '
      'acceptable to you?';

  static const options = RiskReturnPreference.values;
}

enum RiskReturnPreference {
  conservative,
  moderatelyConservative,
  balanced,
  growth,
  aggressive,
}

extension RiskReturnPreferenceX on RiskReturnPreference {
  String get label {
    switch (this) {
      case RiskReturnPreference.conservative:
        return 'Conservative';

      case RiskReturnPreference.moderatelyConservative:
        return 'Moderately Conservative';

      case RiskReturnPreference.balanced:
        return 'Balanced';

      case RiskReturnPreference.growth:
        return 'Growth';

      case RiskReturnPreference.aggressive:
        return 'Aggressive';
    }
  }

  RiskReturnRange get returnRange {
    switch (this) {
      case RiskReturnPreference.conservative:
        return const RiskReturnRange(average: 2.60, standardDeviation: 2.00);

      case RiskReturnPreference.moderatelyConservative:
        return const RiskReturnRange(average: 4.40, standardDeviation: 7.10);

      case RiskReturnPreference.balanced:
        return const RiskReturnRange(average: 5.00, standardDeviation: 10.20);

      case RiskReturnPreference.growth:
        return const RiskReturnRange(average: 6.50, standardDeviation: 21.10);

      case RiskReturnPreference.aggressive:
        return const RiskReturnRange(average: 7.70, standardDeviation: 29.40);
    }
  }

  int get score {
    switch (this) {
      case RiskReturnPreference.conservative:
        return 1;

      case RiskReturnPreference.moderatelyConservative:
        return 2;

      case RiskReturnPreference.balanced:
        return 3;

      case RiskReturnPreference.growth:
        return 4;

      case RiskReturnPreference.aggressive:
        return 5;
    }
  }
}
