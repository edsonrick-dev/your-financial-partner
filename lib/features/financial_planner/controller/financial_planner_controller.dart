import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/cashflow_planner_page/cashflow_planner_page.dart';
import 'package:getx_drift_app/features/financial_planner/models/financial_planner_page_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/insurance_planner/insurance_planner_screen.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/views/net_worth_planner_screen/networth_planner_screen.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_planner/views/savings_planner_empty_view.dart';

class FinancialPlannerController extends GetxController {
  late final List<GlobalKey> financialPlannerKeys;
  @override
  void onInit() {
    super.onInit();

    financialPlannerKeys = List.generate(
      financialPlannerPages.length,
      (_) => GlobalKey(),
    );
  }

  final pageScrollController = ScrollController();
  final selectedTabIndex = 0.obs;
  void selectTab(int index) {
    selectedTabIndex.value = index;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollSelectedTabIntoView();
    });
  }

  void scrollSelectedTabIntoView() {
    final index = selectedTabIndex.value;

    if (index < 0 || index >= financialPlannerKeys.length) {
      return;
    }

    final context = financialPlannerKeys[index].currentContext;

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

  final financialPlannerPages = <FinancialPlannerPage>[
    FinancialPlannerPage(title: 'Net Worth', page: NetworthPlannerScreen()),
    FinancialPlannerPage(title: 'Cashflow', page: CashflowPlannerPage()),
    FinancialPlannerPage(title: 'Insurance', page: InsurancePlannerScreen()),
    FinancialPlannerPage(
      title: 'Savings & Investments',
      page: SavingsPlannerEmptyView(),
    ),
  ];
}
