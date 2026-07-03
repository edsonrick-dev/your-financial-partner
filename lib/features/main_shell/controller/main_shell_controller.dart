import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/financial_planner_screen.dart';
import 'package:getx_drift_app/features/home/views/home_view.dart';
import 'package:getx_drift_app/features/settings/settings_page_view.dart';
import 'package:getx_drift_app/features/transaction/views/transaction_view.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';

class MainShellController extends GetxController {
  final selectedTabIndex = 0.obs;
  final isAddSheetOpen = false.obs;

  void changeTab(int index) {
    selectedTabIndex.value = index;
  }

  String get currentTitle {
    switch (selectedTabIndex.value) {
      case 0:
        return 'Home';
      case 1:
        return 'Transactions';
      case 2:
        return 'Budgets';
      case 3:
        return 'Settings';

      default:
        return '';
    }
  }

  final pages = <Widget>[
    HomeView(),
    TransactionView(),
    FinancialPlannerScreen(),
    SettingsPageView(),
  ];

  // void openAddTransaction() {
  //   // Open transaction sheet
  //   AppSheets.addTransactionSheet();
  // }
  Future<void> openAddTransaction() async {
    isAddSheetOpen.value = true;

    await AppSheets.addTransactionSheet();
    isAddSheetOpen.value = false;
  }
}
