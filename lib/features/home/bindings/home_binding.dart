import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/cashflow_planner_screen.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/main_shell/controller/main_shell_controller.dart';
import 'package:getx_drift_app/features/profile/controller/profile_controller.dart';
import 'package:getx_drift_app/features/settings/pages/notifications_page.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainShellController());

    Get.lazyPut<SettingsController>(() => SettingsController(), fenix: true);
    Get.lazyPut<FinancialPlannerController>(() => FinancialPlannerController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<ProfileController>(() => ProfileController());
    Get.lazyPut<InsurancePlannerController>(() => InsurancePlannerController());
    Get.lazyPut<NetWorthController>(() => NetWorthController());
    Get.lazyPut<CashflowController>(() => CashflowController());
    Get.lazyPut<TransactionController>(
      () => TransactionController(),
      fenix: true,
    );
  }
}
