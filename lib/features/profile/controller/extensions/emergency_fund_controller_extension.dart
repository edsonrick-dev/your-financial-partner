import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/enum/finanical_ratio_type_enum.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/emergency_fund_ratio_scoring.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';

extension EmergencyFundControllerExtension on FinancialProfileController {
  double? get opportunityFundMonths {
    final months = emergencyFundMonths;

    if (months == null || months <= 12) {
      return null;
    }

    return months - 12;
  }

  double get maxEmergencyFundBandValue => emergencyFundBands
      .map((band) => band.threshold)
      .reduce((a, b) => a > b ? a : b);

  double get maxEmergencyFundValue =>
      (emergencyFundRatio ?? 0) >= 100 ? maxEmergencyFundBandValue : 100.0;

  double calculateEmergencyFundMonths({
    required double liquidFunds,
    required double monthlyExpenses,
    required double monthlyDebtRepayments,
  }) {
    final monthlyLifestyleAllocation = monthlyExpenses + monthlyDebtRepayments;

    if (monthlyLifestyleAllocation <= 0) {
      return 0;
    }

    return liquidFunds / monthlyLifestyleAllocation;
  }

  String emergencyFundScaleLabel(double percentage) {
    final months = percentage / 100 * 12;

    if (months == 0) {
      return '0';
    }
    // n '${months.round()} mo';
    return '${months.round()} mo';
  }

  double? get emergencyFundMonths {
    if (annualBudget <= 0 || emergencyFundAvailable <= 0) {
      return 0;
    }

    final requiredLiquidity = annualBudget / 0.70;
    final months = emergencyFundAvailable / (requiredLiquidity / 12);

    return months;
  }

  bool get isOpportunityFundEnabled => calculator.isOpportunityFundEnabled(
    emergencyFundMonths: emergencyFundMonths,
  );
  String? get emergencyFundDuration {
    final months = emergencyFundMonths;

    if (months == null) {
      return null;
    }

    return calculator.formatDuration(months);
  }

  FinancialRatio get emergencyFund {
    final ratio = emergencyFundRatio;

    final months = emergencyFundMonths;
    return FinancialRatio(
      type: FinancialRatioType.emergencyFund,
      value: ratio,
      displayValue: months,
      scoreBand: fundBand(ratio),
    );
  }

  // String emergencyFundScaleLabel(double percentage) {
  //   final months = percentage / 100 * 12;

  //   if (months == 0) {
  //     return '0';
  //   }
  //   // n '${months.round()} mo';
  //   return '${months.round()} mo';
  // }
}
