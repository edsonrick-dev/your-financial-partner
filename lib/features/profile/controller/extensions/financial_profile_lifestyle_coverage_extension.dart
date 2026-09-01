import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/enum/finanical_ratio_type_enum.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/lifestyle_coverage_ratio.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';

extension FinancialProfileLifestyleCoverageExtension
    on FinancialProfileController {
  // ---------------------------------------------------------------------------
  // ASSESSMENT
  // ---------------------------------------------------------------------------

  bool get canAssessLifestyleCoverage {
    return hasBudget && hasNetWorth && annualBudget > 0;
  }

  // ---------------------------------------------------------------------------
  // LIFESTYLE COVERAGE
  // ---------------------------------------------------------------------------

  double? get lifestyleCoverageRatio {
    if (!canAssessLifestyleCoverage) {
      return null;
    }

    return netWorth / annualBudget;
  }

  // double? get lifestyleCoverageRatio {
  //   if (!canAssessLifestyleCoverage) {
  //     return null;
  //   }

  //   return netWorth / annualBudget;
  // }
  double? get lifestyleCoverageMonths {
    final ratio = lifestyleCoverageRatio;

    if (ratio == null) {
      return null;
    }

    return ratio * 12;
  }

  String? get lifestyleCoverageDuration {
    final months = lifestyleCoverageMonths;

    if (months == null) {
      return null;
    }

    return calculator.formatDuration(months);
  }

  String formatLifestyleCoverage(double? months) {
    if (months == null) {
      return 'Not assessed';
    }

    if (months <= 0) {
      return 'No lifestyle coverage';
    }

    return calculator.formatDuration(months);
  }

  FinancialRatio get lifestyleCoverage {
    final value = lifestyleCoverageRatio;

    return FinancialRatio(
      type: FinancialRatioType.lifestyleCoverage,
      value: value,
      displayValue: lifestyleCoverageMonths,
      scoreBand: lifestyleCoverageBand(value),
    );
  }
}

// extension FinancialProfileLifestyleCoverageExtension1
//     on FinancialProfileController {
//   String formatLifestyleCoverage(double? months) {
//     if (months == null) {
//       return 'Not assessed';
//     }

//     if (months <= 0) {
//       return 'No lifestyle coverage';
//     }

//     return calculator.formatDuration(months);
//   }

//   double? get lifestyleCoverageRatio =>
//       calculator.calculateLifestyleCoverageRatio(
//         netWorth: netWorth,
//         plannedAnnualBudget: annualBudget,
//       );

//   String? get lifestyleCoverageDuration =>
//       calculator.formatLifestyleCoverageDuration(
//         netWorth: netWorth,
//         plannedAnnualBudget: annualBudget,
//       );
//   double? get lifestyleCoverageMonths =>
//       calculator.calculateLifestyleCoverageMonths(
//         netWorth: netWorth,
//         plannedAnnualBudget: annualBudget,
//       );

//   // FinancialRatio get lifestyleCoverage {
//   //   final value = lifestyleCoverageRatio;

//   //   return FinancialRatio(
//   //     type: FinancialRatioType.lifestyleCoverage,
//   //     value: value,
//   //     scoreBand: lifestyleCoverageBand(value),
//   //   );
//   // }
// }
