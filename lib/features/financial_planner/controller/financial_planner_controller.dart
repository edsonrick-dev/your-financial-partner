import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/cashflow_planner_page/cashflow_planner_page.dart';
import 'package:getx_drift_app/features/financial_planner/models/financial_planner_page_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/insurance_planner/insurance_planner_screen.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/views/net_worth_planner_screen/networth_planner_screen.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_planner/views/savings_planner_empty_view.dart';

class FinancialPlannerController extends GetxController {
  final selectedTabIndex = 0.obs;
  void selectTab(int index) {
    selectedTabIndex.value = index;
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
