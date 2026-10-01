import 'dart:math';

import 'package:get/get.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';

class RetirementPlannerController extends GetxController {
  RetirementPlannerController({required this.financialProfileController});

  final FinancialProfileController financialProfileController;

  // ---------------------------------------------------------------------------
  // Retirement assumptions
  // ---------------------------------------------------------------------------

  /// User's current age.
  final currentAge = 28.obs;

  /// Age at which the user wants to retire.
  final retirementAge = 60.obs;

  /// Age until which the retirement fund should last.
  final retirementFundEndAge = 85.obs;

  /// Percentage of current lifestyle the user expects to need in retirement.
  final retirementSpendingRate = 0.80.obs;

  /// Expected annual inflation.
  final inflationRate = 0.03.obs;

  /// Expected annual investment return before retirement.
  final preRetirementReturn = 0.08.obs;

  /// Expected annual investment return during retirement.
  final postRetirementReturn = 0.06.obs;

  // ---------------------------------------------------------------------------
  // Financial inputs
  // ---------------------------------------------------------------------------

  double get currentMonthlyBudget => financialProfileController.monthlyBudget;

  double get currentAnnualBudget => financialProfileController.annualBudget;

  // ---------------------------------------------------------------------------
  // Retirement timeline
  // ---------------------------------------------------------------------------

  int get accumulationYears {
    return max(0, retirementAge.value - currentAge.value);
  }

  int get retirementYears {
    return max(0, retirementFundEndAge.value - retirementAge.value);
  }

  // ---------------------------------------------------------------------------
  // Retirement spending
  // ---------------------------------------------------------------------------

  double get estimatedCurrentRetirementMonthlyBudget {
    return currentMonthlyBudget * retirementSpendingRate.value;
  }

  double get estimatedRetirementMonthlyBudget {
    return _futureValue(
      presentValue: estimatedCurrentRetirementMonthlyBudget,
      annualRate: inflationRate.value,
      years: accumulationYears,
    );
  }

  double get estimatedRetirementAnnualIncome {
    return estimatedRetirementMonthlyBudget * 12;
  }

  // ---------------------------------------------------------------------------
  // Retirement fund requirement
  // ---------------------------------------------------------------------------

  double get requiredRetirementFund {
    return _presentValueGrowingAnnuity(
      firstPayment: estimatedRetirementAnnualIncome,
      growthRate: inflationRate.value,
      returnRate: postRetirementReturn.value,
      years: retirementYears,
    );
  }

  // ---------------------------------------------------------------------------
  // Helpers
  // ---------------------------------------------------------------------------

  double _futureValue({
    required double presentValue,
    required double annualRate,
    required int years,
  }) {
    return presentValue * pow(1 + annualRate, years);
  }

  double _presentValueGrowingAnnuity({
    required double firstPayment,
    required double growthRate,
    required double returnRate,
    required int years,
  }) {
    if (years <= 0) {
      return 0;
    }

    if (returnRate == growthRate) {
      return firstPayment * years / (1 + returnRate);
    }

    return firstPayment *
        (1 - pow((1 + growthRate) / (1 + returnRate), years)) /
        (returnRate - growthRate);
  }
}
