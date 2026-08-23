import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/cashflow_planner_screen.dart';
import 'package:getx_drift_app/features/financial_planner/models/financial_planner_page_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_planner_screen.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/networth_planner_screen.dart';

class FinancialPlannerController extends GetxController {
  final selectedTabIndex = 0.obs;
  void selectTab(int index) {
    selectedTabIndex.value = index;
  }

  final financialPlannerPages = <FinancialPlannerPage>[
    FinancialPlannerPage(title: 'Net Worth', page: NetworthPlannerScreen()),
    FinancialPlannerPage(title: 'Cashflow', page: CashflowPlannerScreen()),
    FinancialPlannerPage(title: 'Insurance', page: InsurancePlannerScreen()),
    FinancialPlannerPage(title: 'Savings & Investments', page: Column()),
  ];
}
