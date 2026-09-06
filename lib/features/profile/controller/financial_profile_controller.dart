import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  final CashflowController cashflowController = Get.find<CashflowController>();

  final NetWorthController netWorthController = Get.find<NetWorthController>();

  final FinancialMetricsCalculator calculator = FinancialMetricsCalculator();

  // ---------------------------------------------------------------------------
  // Raw financial data
  // ---------------------------------------------------------------------------

  double get annualIncome => cashflowController.plannedAnnualIncome.value;

  double get annualBudget => cashflowController.annualBudget.value;

  double get annualExpenses => cashflowController.annualExpense.value;

  double get annualDebtRepayments =>
      cashflowController.annualDebtRepayment.value;

  double get netWorth => netWorthController.netWorth;

  // TODO: Include here Liquid Funds & Average Daily Balance

  // ---------------------------------------------------------------------------
  // Liquid funds
  // ---------------------------------------------------------------------------

  bool get hasLiquidFunds => netWorthController.hasLiquidFundAccounts;
  double get liquidFunds => netWorthController.liquidFunds;
  bool get hasNetWorth => netWorthController.hasAccounts;
  double? get averageDailyBalance => netWorthController.averageDailyBalance;

  double? get emergencyFundAvailable {
    final adb = averageDailyBalance;

    if (adb == null) return liquidFunds;

    return min(liquidFunds, adb);
  }

  // ---------------------------------------------------------------------------
  // Derived  values
  // ---------------------------------------------------------------------------
  bool get hasIncome => cashflowController.hasIncomePlan;
  bool get hasBudget => cashflowController.hasBudgetPlan;
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
  @override
  void onInit() {
    super.onInit();

    stabilityDetailKeys = List.generate(
      stabilityProfileDetails.length,
      (_) => GlobalKey(),
    );
  }

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
