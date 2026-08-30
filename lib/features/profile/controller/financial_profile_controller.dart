import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/domain/financial_metrics_calculator.dart';
import 'package:getx_drift_app/features/profile/enum/finanical_ratio_type_enum.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/debt_load_ratio_scoring.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/lifestyle_coverage_ratio.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/wealth_building_rate_scoring.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';
import 'package:getx_drift_app/features/profile/models/financial_stability_score_model.dart';
import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details/debt_load_details.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details/emergency_fund_details.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details/lifestyle_coverage_details.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details/stability_level_details.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details/wealth_building_details_sheet.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/emergency_fund_controller_extension.dart';

class FinancialStabilityDetail {
  final String title;
  final FinancialRatioType? ratioType;
  final Widget page;

  const FinancialStabilityDetail({
    required this.title,
    this.ratioType,
    required this.page,
  });
}

extension FinancialProfileDetailsScreenExtension on FinancialProfileController {
  List<FinancialStabilityDetail> get stabilityProfileDetails => [
    FinancialStabilityDetail(
      title: 'Stability Level',
      page: StabilityLevelDetails(stability: stability),
    ),
    FinancialStabilityDetail(
      title: FinancialRatioType.debtLoad.displayName,
      ratioType: FinancialRatioType.debtLoad,
      page: DebtLoadDetails(ratio: debtLoad),
    ),
    FinancialStabilityDetail(
      title: FinancialRatioType.wealthBuilding.displayName,
      ratioType: FinancialRatioType.wealthBuilding,
      page: WealthBuildingDetailsSheet(ratio: wealthBuilding),
    ),
    FinancialStabilityDetail(
      title: FinancialRatioType.emergencyFund.displayName,
      ratioType: FinancialRatioType.emergencyFund,
      page: EmergencyFundDetails(ratio: emergencyFund),
    ),
    FinancialStabilityDetail(
      title: FinancialRatioType.lifestyleCoverage.displayName,
      ratioType: FinancialRatioType.lifestyleCoverage,
      page: LifestyleCoverageDetails(ratio: lifestyleCoverage),
    ),
  ];
  void selectRatioTab(FinancialRatioType ratioType) {
    final index = getDetailIndex(ratioType);

    if (index == -1) return;

    selectedDetailsIndex.value = index;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollSelectedTabIntoView();
    });
  }

  void selectTab(int index) {
    selectedDetailsIndex.value = index;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollSelectedTabIntoView();
    });
  }

  void scrollSelectedTabIntoView() {
    final index = selectedDetailsIndex.value;

    if (index < 0 || index >= stabilityDetailKeys.length) {
      return;
    }

    final context = stabilityDetailKeys[index].currentContext;

    if (context == null) {
      return;
    }

    Scrollable.ensureVisible(
      context,
      alignment: 0.5,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  int getDetailIndex(FinancialRatioType ratioType) {
    return stabilityProfileDetails.indexWhere(
      (detail) => detail.ratioType == ratioType,
    );
  }
}

class FinancialProfileController extends GetxController {
  // ---------------------------------------------------------------------------
  // Details Page
  // ---------------------------------------------------------------------------
  final detailsScrollController = ScrollController();
  final FinancialMetricsCalculator calculator = FinancialMetricsCalculator();

  final selectedDetailsIndex = 0.obs;

  @override
  void onClose() {
    detailsScrollController.dispose();
    super.onClose();
  }

  late final List<GlobalKey> stabilityDetailKeys;
  @override
  void onInit() {
    super.onInit();

    stabilityDetailKeys = List.generate(
      stabilityProfileDetails.length,
      (_) => GlobalKey(),
    );
  }

  // void selectTab(int index) {
  //   selectedDetailsIndex.value = index;
  // }
  // ---------------------------------------------------------------------------
  // Raw financial data
  // ---------------------------------------------------------------------------

  final annualIncome = 360000.0.obs;
  final annualDebtRepayments = 36200.0.obs;
  final annualExpenses = 7000.0.obs;

  final liquidFunds = 80000.0.obs;
  final averageDailyBalnce = 200000.0.obs;

  final annualSavingGoals = 120000.0.obs;
  final annualInvestmentGoals = 60000.0.obs;
  final netWorth = 30000.0.obs;

  // ---------------------------------------------------------------------------
  // Derived  values
  // ---------------------------------------------------------------------------
  double get annualBudget => annualDebtRepayments.value + annualExpenses.value;
  double get annualSavings => annualIncome.value - annualBudget;
  double get emergencyFundAvailable =>
      min(liquidFunds.value, averageDailyBalnce.value);
  double get monthlyIncome => annualIncome.value / 12;

  double get monthlyDebtRepayments => annualDebtRepayments.value / 12;

  double get monthlyExpenses => annualExpenses.value / 12;

  double get monthlySavingGoals => annualSavingGoals.value / 12;

  double get monthlyInvestmentGoals => annualInvestmentGoals.value / 12;

  // ---------------------------------------------------------------------------
  // Ratio calculations
  // ---------------------------------------------------------------------------

  String formatLifestyleCoverage(double? months) {
    if (months == null) {
      return 'Not assessed';
    }

    if (months <= 0) {
      return 'No lifestyle coverage';
    }

    return calculator.formatDuration(months);
  }

  // double calculateEmergencyFundRatio({
  //   required double liquidFunds,
  //   required double monthlyExpenses,
  //   required double monthlyDebtRepayments,
  //   required double monthlySavings,
  //   required double monthlyInvestments,
  // }) {
  //   final monthlyLifestyleAllocation = monthlyExpenses + monthlyDebtRepayments;

  //   final monthlyWealthAllocation = monthlySavings + monthlyInvestments;

  //   final monthlyTotalAllocation =
  //       monthlyLifestyleAllocation + monthlyWealthAllocation;

  //   if (monthlyTotalAllocation <= 0) {
  //     return 0;
  //   }

  //   final annualTotalAllocation = monthlyTotalAllocation * 12;

  //   return (liquidFunds / annualTotalAllocation) * 100;
  // }

  // double calculateWealthBuildingRate({
  //   required double monthlyIncome,
  //   required double monthlyExpenses,
  //   required double monthlyDebtRepayments,
  // }) {
  //   if (monthlyIncome <= 0) {
  //     return 0;
  //   }

  //   final wealthBuildingAmount =
  //       monthlyIncome - monthlyExpenses - monthlyDebtRepayments;

  //   final ratio = (wealthBuildingAmount / monthlyIncome) * 100;

  //   return ratio.clamp(0, 100);
  // }

  double calculateLifestyleCoverageRatio({
    required double netWorth,
    required double monthlyExpenses,
    required double monthlyDebtRepayments,
  }) {
    final monthlyLifestyleAllocation = monthlyExpenses + monthlyDebtRepayments;

    if (monthlyLifestyleAllocation <= 0) {
      return 0;
    }

    final annualLifestyleAllocation = monthlyLifestyleAllocation * 12;

    return netWorth / annualLifestyleAllocation;
  }

  // ---------------------------------------------------------------------------

  // Financial ratios score
  // ---------------------------------------------------------------------------
  double? get lifestyleCoverageRatio =>
      calculator.calculateLifestyleCoverageRatio(
        netWorth: netWorth.value,
        plannedAnnualBudget: annualBudget,
      );
  // double? get emergencyFundRatio => calculator.calculateEmergencyFundRatio(
  //   liquidFunds: emergencyFundAvailable,
  //   plannedAnnualBudget: annualBudget,
  // );
  String opportunityFundScaleLabel(double ratio) {
    final months = ratio / 100 * 12;

    return '${months.round()} mo';
  }

  double? get emergencyFundRatio {
    if (annualBudget <= 0 || emergencyFundAvailable <= 0) {
      return 0;
    }

    final requiredLiquidity = annualBudget / 0.70;

    return (emergencyFundAvailable / requiredLiquidity) * 100;
  }

  double? get lifestyleCoverageMonths =>
      calculator.calculateLifestyleCoverageMonths(
        netWorth: netWorth.value,
        plannedAnnualBudget: annualBudget,
      );
  // String? get emergencyFundDuration {
  //   final months = emergencyFundMonths;

  //   if (months == null) {
  //     return null;
  //   }

  //   return calculator.formatuDuration(months);
  // }

  String? get lifestyleCoverageDuration =>
      calculator.formatLifestyleCoverageDuration(
        netWorth: netWorth.value,
        plannedAnnualBudget: annualBudget,
      );
  double get debtLoadRatio => calculator.calculateDebtLoadRatio(
    annualDebtRepayment: annualDebtRepayments.value,
    annualIncome: annualIncome.value,
  );
  double get wealthBuildingRatio => calculator.calculateWealthBuildingRate(
    annualDebtRepayment: annualDebtRepayments.value,
    annualIncome: annualIncome.value,
    annualExpenses: annualExpenses.value,
  );
  // double? get emergencyFundMonths => calculator.calculateEmergencyFundMonths(
  //   emergencyFund: emergencyFundAvailable,
  //   plannedAnnualBudget: annualBudget,
  // );

  // ---------------------------------------------------------------------------
  // Financial ratio
  // ---------------------------------------------------------------------------
  FinancialRatio get debtLoad {
    final value = debtLoadRatio;

    return FinancialRatio(
      type: FinancialRatioType.debtLoad,
      value: value,
      scoreBand: debtLoadBand(value),
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

  FinancialRatio get lifestyleCoverage {
    final value = lifestyleCoverageRatio;

    return FinancialRatio(
      type: FinancialRatioType.lifestyleCoverage,
      value: value,
      scoreBand: lifestyleCoverageBand(value),
    );
  }

  // ---------------------------------------------------------------------------
  // Overall stability
  // ---------------------------------------------------------------------------

  List<FinancialRatio> get ratios => [
    debtLoad,
    emergencyFund,
    wealthBuilding,
    lifestyleCoverage,
  ];

  int get financialScore {
    return ratios.fold(0, (total, ratio) => total + ratio.points);
  }

  FinancialStability get stability {
    return FinancialStability.fromScore(financialScore);
  }
}
