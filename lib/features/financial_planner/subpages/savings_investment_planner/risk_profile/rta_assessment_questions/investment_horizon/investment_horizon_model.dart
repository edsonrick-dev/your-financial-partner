import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/risk_tolerance_controller.dart';

class InvestmentHorizonQuestion {
  static const String question =
      'I plan to begin withdrawing money from my investments in:';

  static const String description = '';

  static const options = InvestmentHorizon.values;
}

enum InvestmentHorizon {
  lessThan3Years,
  threeTo5Years,
  sixTo10Years,
  elevenYearsOrMore,
}

extension InvestmentHorizonX on InvestmentHorizon {
  String get label {
    switch (this) {
      case InvestmentHorizon.lessThan3Years:
        return 'Less than 3 Years';

      case InvestmentHorizon.threeTo5Years:
        return '3–5 Years';

      case InvestmentHorizon.sixTo10Years:
        return '6–10 Years';

      case InvestmentHorizon.elevenYearsOrMore:
        return '11 Years or more';
    }
  }

  int get score {
    switch (this) {
      case InvestmentHorizon.lessThan3Years:
        return 1;

      case InvestmentHorizon.threeTo5Years:
        return 3;

      case InvestmentHorizon.sixTo10Years:
        return 7;

      case InvestmentHorizon.elevenYearsOrMore:
        return 10;
    }
  }
}

extension InvestmentHorizonC on RiskToleranceController {
  int get investmentHorizonScore {
    return investmentHorizon.value?.score ?? 0;
  }

  void setInvestmentHorizon(InvestmentHorizon value) {
    investmentHorizon.value = value;
  }
}
