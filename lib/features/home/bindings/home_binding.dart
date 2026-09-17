import 'package:get/get.dart';
import 'package:getx_drift_app/domain/app_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/controller/bill_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/categories/category_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/add_account/forms/credit_card_installment_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/loan_detail_sheet/loan_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_planner/views/savings_planner_screen.dart';
import 'package:getx_drift_app/features/financial_setup/financial_setup_controller.dart';
import 'package:getx_drift_app/features/main_shell/controller/main_shell_controller.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/settings/pages/notifications_page.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_category_sheet/create_category_controller.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainShellController());
    // Get.lazyPut<OnboardingController>(() => OnboardingController());

    Get.lazyPut<SettingsController>(() => SettingsController(), fenix: true);

    Get.lazyPut<BillController>(() => BillController(), fenix: true);
    Get.lazyPut<LoanController>(() => LoanController(), fenix: true);
    Get.lazyPut<HomeController>(() => HomeController(), fenix: true);
    Get.lazyPut<FinancialPlannerController>(() => FinancialPlannerController());
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.lazyPut<NetWorthController>(() => NetWorthController());
    Get.lazyPut<SavingsPlannerController>(() => SavingsPlannerController());

    Get.lazyPut<FinancialProfileController>(() => FinancialProfileController());
    Get.lazyPut<InsurancePlannerController>(() => InsurancePlannerController());
    Get.lazyPut<CategoryController>(() => CategoryController());
    Get.lazyPut<CreditCardInstallmentController>(
      () => CreditCardInstallmentController(),
      fenix: true,
    );
    Get.lazyPut<FinancialSetupController>(() => FinancialSetupController());
    Get.lazyPut<CashflowController>(() => CashflowController());
    Get.lazyPut<AccountController>(() => AccountController(), fenix: true);
    Get.lazyPut<AppCalculatorController>(
      () => AppCalculatorController(),
      fenix: true,
    );
    Get.lazyPut<TransactionController>(
      () => TransactionController(),
      fenix: true,
    );
    // Get.lazyPut<PersonalBalanceController>(() => PersonalBalanceController());
  }
}
