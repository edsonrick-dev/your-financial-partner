import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/bills/views/bills_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/budgets/views/budgets_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/cashflow_details_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/beneficiaries/views/beneficiaries_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/critical_illness_benefit_gap/views/critical_illness_details_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/death_benefit_gap/views/death_benefit_details_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/disability_benefit_gap/views/disability_details_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/insurance_policies/views/insurance_policies_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/net_worth_details_view.dart';
import 'package:getx_drift_app/features/balances/views/people_balances_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/charts/views/networth_charts_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/checks/views/checks_management_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/exports/views/file_export_view.dart';
import 'package:getx_drift_app/features/home/views/home_view.dart';
import 'package:getx_drift_app/features/main_shell/views/main_shell_view.dart';
import 'package:getx_drift_app/features/personal_balance/binding/personal_balance_binding.dart';
import 'package:getx_drift_app/features/personal_balance/screen/personal_balance_details_page.dart';
import 'package:getx_drift_app/features/settings/pages/notifications_page.dart';
import 'package:getx_drift_app/features/settings/pages/preferences_page.dart';
import '../../features/home/bindings/home_binding.dart';
import '../../features/root/bindings/root_binding.dart';
import '../../features/root/views/root_view.dart';
import '../../features/transaction/bindings/transaction_binding.dart';
import '../../features/transaction/views/transaction_view.dart';
import 'app_routes.dart';

class AppPages {
  static final netWorth = [];
  static final pages = [
    GetPage(
      name: Routes.PERSONALBALANCE,
      page: () => const PersonalBalanceDetailsPage(),
      binding: PersonalBalanceBinding(),
    ),
    GetPage(
      name: Routes.MAINVIEW,
      page: () => const MainShell(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.ROOT,
      page: () => const RootView(),
      binding: RootBinding(),
    ),
    GetPage(
      name: Routes.TRANSACTION,
      page: () => const TransactionView(),
      binding: TransactionBinding(),
    ),

    //Settings
    GetPage(name: Routes.preferences, page: () => const PreferencesPage()),
    GetPage(name: Routes.notifications, page: () => const NotificationsPage()),

    //INSURANCE PAGE
    GetPage(
      name: Routes.DEATHBENEFITGAP,
      page: () => const DeathBenefitDetailsView(),
      // binding: TransactionBinding(),
    ),
    GetPage(
      name: Routes.CRITICALILLNESSBENEFITGAP,
      page: () => const CriticalIllnessDetailsView(),
      // binding: TransactionBinding(),
    ),
    GetPage(
      name: Routes.DISABILITYBENEFITGAP,
      page: () => const DisabilityDetailsView(),
      // binding: TransactionBinding(),
    ),
    GetPage(
      name: Routes.INSURANCEPOLICIES,
      page: () => const InsurancePoliciesView(),
      // binding: TransactionBinding(),
    ),
    GetPage(
      name: Routes.BENEFICIARIES,
      page: () => const BeneficiariesView(),
      // binding: TransactionBinding(),
    ),

    //CASHFLOW PAGE
    GetPage(
      name: Routes.CASHFLOWDETAILS,
      page: () => const CashflowDetailsView(),
      // binding: TransactionBinding(),
    ),
    GetPage(
      name: Routes.BUDGETS,
      page: () => const BudgetsView(),
      // binding: TransactionBinding(),
    ),
    GetPage(
      name: Routes.BILLS,
      page: () => const BillsView(),
      // binding: TransactionBinding(),
    ),

    //NET WORTH PAGE
    GetPage(
      name: Routes.NETWORTHDETAILS,
      page: () => const NetWorthDetailsView(),
      // binding: TransactionBinding(),
    ),
    GetPage(
      name: Routes.NETWORTHCHARTS,
      page: () => const NetworthChartsView(),
      // binding: TransactionBinding(),
    ),
    GetPage(
      name: Routes.PEOPLEBALANCES,
      page: () => const PeopleBalancesView(),
      // binding: TransactionBinding(),
    ),
    GetPage(
      name: Routes.CHECKMANAGEMENTS,
      page: () => const ChecksManagementView(),
      // binding: TransactionBinding(),
    ),
    GetPage(
      name: Routes.NETWORTHEXPORT,
      page: () => const FileExportView(),
      // binding: TransactionBinding(),
    ),
  ];
}
