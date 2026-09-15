import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_drift_app/domain/financial_metrics_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';
import 'package:getx_drift_app/features/profile/models/financial_stability_score_model.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_debt_load_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_emergency_fund_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_details_screen_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_lifestyle_coverage_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_wealth_building_extension.dart';

class FinancialProfileController extends GetxController {
  Future<void> revealFinancialStabilityProfile() async {
    hasRevealedProfile.value = true;

    await _storage.write(_profileRevealedKey, true);
  }

  @override
  void onInit() {
    super.onInit();

    hasCompletedAssessment.value =
        _storage.read<bool>(_assessmentCompletedKey) ?? false;
    hasRevealedProfile.value =
        _storage.read<bool>(_profileRevealedKey) ?? false;
    stabilityDetailKeys = List.generate(
      stabilityProfileDetails.length,
      (_) => GlobalKey(),
    );
  }

  final GetStorage _storage = GetStorage();

  static const _assessmentCompletedKey = 'financial_assessment_completed';

  static const _profileRevealedKey = 'financial_profile_revealed';

  final hasCompletedAssessment = false.obs;
  final hasRevealedProfile = false.obs;
  Future<void> markAssessmentCompleted() async {
    hasCompletedAssessment.value = true;

    await _storage.write(_assessmentCompletedKey, true);
  }

  // final GetStorage _storage = GetStorage();

  // static const _assessmentCompletedKey = 'financial_assessment_completed';

  // final hasCompletedAssessment = false.obs;

  final CashflowController cashflowController = Get.find<CashflowController>();

  final NetWorthController netWorthController = Get.find<NetWorthController>();

  final FinancialMetricsCalculator calculator = FinancialMetricsCalculator();

  // ---------------------------------------------------------------------------
  // Raw financial data
  // ---------------------------------------------------------------------------

  double get annualIncome => cashflowController.plannedAnnualIncome.value;
  double get monthlyIncome => cashflowController.plannedAnnualIncome.value / 12;

  double get annualBudget => cashflowController.annualBudget.value;
  double get monthlyBudget => annualBudget / 12;

  double get annualExpenses => cashflowController.annualExpense.value;

  double get annualDebtRepayments =>
      cashflowController.annualDebtRepayment.value;

  double get netWorth => netWorthController.netWorth;
  double get averageMonthlyBudget => cashflowController.annualBudget.value / 12;
  // ---------------------------------------------------------------------------
  // IDEAL BUDGET TARGET
  // ---------------------------------------------------------------------------

  double get idealAnnualBudget => annualIncome * 0.70;

  double get idealMonthlyBudget => idealAnnualBudget / 12;

  bool get isBudgetAboveIncome {
    return annualBudget > annualIncome;
  }

  bool get isBudgetAboveIdeal {
    return annualBudget > idealAnnualBudget;
  }

  bool get hasIdealBudget {
    return annualBudget <= idealAnnualBudget;
  }

  double get budgetTarget {
    if (isBudgetAboveIncome) {
      return annualIncome;
    }

    return idealAnnualBudget;
  }

  double get budgetGap {
    return max(0, annualBudget - budgetTarget);
  }

  double get monthlyBudgetGap => budgetGap / 12;

  // ---------------------------------------------------------------------------
  // IDEAL INCOME TARGET
  // ---------------------------------------------------------------------------

  double? get idealAnnualIncome {
    if (annualBudget <= 0) {
      return null;
    }

    return annualBudget / 0.70;
  }

  double? get idealMonthlyIncome {
    final annual = idealAnnualIncome;

    if (annual == null) {
      return null;
    }

    return annual / 12;
  }

  bool get hasIdealIncome {
    final ideal = idealAnnualIncome;

    if (ideal == null) {
      return false;
    }

    return annualIncome >= ideal;
  }

  double? get idealIncomeGap {
    final ideal = idealAnnualIncome;

    if (ideal == null) {
      return null;
    }

    return max(0, ideal - annualIncome);
  }

  double? get monthlyIncomeGap {
    final gap = idealIncomeGap;

    if (gap == null) {
      return null;
    }

    return gap / 12;
  } // TODO: Include here Liquid Funds & Average Daily Balance

  // ---------------------------------------------------------------------------
  // Liquid funds
  // ---------------------------------------------------------------------------

  bool get hasLiquidFunds => netWorthController.hasLiquidFundAccounts;
  double get liquidFunds => netWorthController.liquidFunds;
  bool get hasNetWorth => netWorthController.hasAccounts;
  double? get averageDailyBalance =>
      null; // netWorthController.averageDailyBalance;

  double? get emergencyFundAvailable {
    final adb = averageDailyBalance;

    if (adb == null) return liquidFunds;

    return min(liquidFunds, adb);
  }

  // ---------------------------------------------------------------------------
  // Derived  values
  // ---------------------------------------------------------------------------

  bool get hasDebtRepayment => cashflowController.hasDebtRepaymentPlan;
  double get annualSavings => annualIncome - annualBudget;

  // ---------------------------------------------------------------------------
  // Details Page State
  // ---------------------------------------------------------------------------
  final detailsScrollController = ScrollController();
  final selectedDetailsIndex = 0.obs;

  @override
  void onClose() {
    detailsScrollController.dispose();
    super.onClose();
  }

  late final List<GlobalKey> stabilityDetailKeys;

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
