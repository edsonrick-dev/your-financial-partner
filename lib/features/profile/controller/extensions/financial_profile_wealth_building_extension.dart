import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/enum/finanical_ratio_type_enum.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/wealth_building_rate_scoring.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';

extension FinancialProfileWealthBuildingExtension
    on FinancialProfileController {
  bool get canAssessWealthBuilding {
    return hasIncome && hasBudget && annualIncome > 0;
  }

  double? calculateWealthBuildingRatio({
    required double annualIncome,
    required double annualExpenses,
    required double annualDebtRepayment,
  }) {
    if (annualIncome <= 0) return null;

    final annualSurplus = annualIncome - annualExpenses - annualDebtRepayment;

    final ratio = (annualSurplus / annualIncome) * 100;

    return ratio.clamp(0, 100);
  }

  double? get wealthBuildingRatio {
    if (!hasIncome || !hasBudget) {
      return null;
    }

    return calculateWealthBuildingRatio(
      annualIncome: annualIncome,
      annualExpenses: annualExpenses,
      annualDebtRepayment: annualDebtRepayments,
    );
  }

  FinancialRatio get wealthBuilding {
    final value = wealthBuildingRatio;

    return FinancialRatio(
      type: FinancialRatioType.wealthBuilding,
      value: value,
      scoreBand: wealthBuildingBand(value),
    );
  }
}
