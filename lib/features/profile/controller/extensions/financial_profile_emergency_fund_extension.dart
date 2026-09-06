import 'dart:math';

import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/enum/finanical_ratio_type_enum.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/emergency_fund_ratio_scoring.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';

extension FinancialProfileEmergencyFundExtension on FinancialProfileController {
  // ---------------------------------------------------------------------------
  // ASSESSMENT
  // ---------------------------------------------------------------------------

  bool get canAssessEmergencyFund {
    return hasIncome && hasBudget && hasLiquidFunds;
    // && averageDailyBalance != null;
  }

  // ---------------------------------------------------------------------------
  // EMERGENCY FUND
  // ---------------------------------------------------------------------------

  double? get emergencyFundRatio {
    if (!canAssessEmergencyFund) {
      return null;
    }

    final available = emergencyFundAvailable;

    if (available == null || annualBudget <= 0) {
      return null;
    }

    final requiredLiquidity = annualBudget / 0.70;

    return (available / requiredLiquidity) * 100;
  }

  double? get emergencyFundMonths {
    final ratio = emergencyFundRatio;

    if (ratio == null) {
      return null;
    }

    return ratio / 100 * 12;
  }

  String? get emergencyFundDuration {
    final months = emergencyFundMonths;

    if (months == null) {
      return null;
    }

    return calculator.formatDuration(months);
  }

  String emergencyFundScaleLabel(double percentage) {
    final months = percentage / 100 * 12;

    if (months == 0) {
      return '0';
    }

    return '${months.round()} mo';
  }

  double get maxEmergencyFundBandValue {
    return emergencyFundBands
        .map((band) => band.threshold)
        .reduce((a, b) => a > b ? a : b);
  }

  double get maxEmergencyFundValue {
    final ratio = emergencyFundRatio;

    if (ratio == null) {
      return 100;
    }

    return ratio >= 100 ? maxEmergencyFundBandValue : 100.0;
  }

  // ---------------------------------------------------------------------------
  // OPPORTUNITY FUND
  // ---------------------------------------------------------------------------

  double? get opportunityFundAvailable {
    if (!canAssessEmergencyFund) {
      return null;
    }

    final available = emergencyFundAvailable;

    if (available == null || annualBudget <= 0) {
      return null;
    }

    final requiredEmergencyFund = annualBudget / 0.70;

    return max(0, available - requiredEmergencyFund);
  }

  double? get opportunityFundMonths {
    final months = emergencyFundMonths;

    if (months == null) {
      return null;
    }

    return max(0, months - 12);
  }

  bool get isOpportunityFundEnabled {
    return calculator.isOpportunityFundEnabled(
      emergencyFundMonths: emergencyFundMonths,
    );
  }

  String opportunityFundScaleLabel(double ratio) {
    final months = ratio / 100 * 12;

    return '${months.round()} mo';
  }

  // ---------------------------------------------------------------------------
  // EMERGENCY FUND RATIO MODEL
  // ---------------------------------------------------------------------------

  FinancialRatio get emergencyFund {
    final ratio = emergencyFundRatio;

    return FinancialRatio(
      type: FinancialRatioType.emergencyFund,
      value: ratio,
      displayValue: emergencyFundMonths,
      scoreBand: emergencyFundBand(ratio),
    );
  }
}
