import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/controller/risk_profile_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/risk_tolerance_controller.dart';

class InvestmentExperienceQuestion {
  static const String question =
      'Select the investments you currently own or have owned:';

  static const options = InvestmentExperience.values;
}

enum InvestmentExperience {
  moneyMarketOrCash,
  bondsOrBondFunds,
  stocksOrStockFunds,
  internationalSecuritiesOrFunds,
}

extension InvestmentExperienceX on InvestmentExperience {
  String get label {
    switch (this) {
      case InvestmentExperience.moneyMarketOrCash:
        return 'Money market funds or cash investments.';

      case InvestmentExperience.bondsOrBondFunds:
        return 'Bonds and/or bond funds';

      case InvestmentExperience.stocksOrStockFunds:
        return 'Stocks and/or stock funds.';

      case InvestmentExperience.internationalSecuritiesOrFunds:
        return 'International Securities and/or International Funds';
    }
  }

  int get score {
    switch (this) {
      case InvestmentExperience.moneyMarketOrCash:
        return 1;

      case InvestmentExperience.bondsOrBondFunds:
        return 2;

      case InvestmentExperience.stocksOrStockFunds:
        return 3;

      case InvestmentExperience.internationalSecuritiesOrFunds:
        return 4;
    }
  }
}

extension InvestmentExperienceC on RiskToleranceController {
  void toggleInvestmentExperience(InvestmentExperience value) {
    if (investmentExperience.contains(value)) {
      investmentExperience.remove(value);
    } else {
      investmentExperience.add(value);
    }
  }

  int get investmentExperienceScore {
    if (investmentExperience.isEmpty) {
      return 0;
    }

    return investmentExperience
        .map((experience) => experience.score)
        .reduce((a, b) => a > b ? a : b);
  }
}
