import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/bills_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/details/cashflow_details_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/beneficiaries/views/beneficiaries_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/critical_illness_benefit_gap/views/critical_illness_details_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/death_benefit_gap/views/death_benefit_details_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/disability_benefit_gap/views/disability_details_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/insurance_policies/views/insurance_policies_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_page/net_worth_details_page.dart';
import 'package:getx_drift_app/features/balances/views/people_balances_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/charts/views/networth_charts_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/checks/views/checks_management_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/exports/views/file_export_view.dart';
import 'package:getx_drift_app/features/home/views/home_view.dart';
import 'package:getx_drift_app/features/main_shell/views/main_shell_view.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_ascend_intro/onboarding_ascend_intro_view.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_financial_stability_score_intro/onboarding_financial_stability_preview.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_financial_stability_score_intro/onboarding_financial_stability_score_intro.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_learn_with_ascend/onboarding_learn_with_ascend_intro.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_learn_with_ascend/onboarding_learn_with_ascend_preview.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_questions/onboarding_fifth_question.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_questions/onboarding_first_question.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_questions/onboarding_fourth_question.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_questions/onboarding_second_question.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_questions/onboarding_seventh_question.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_questions/onboarding_sixth_question.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_questions/onboarding_third_question.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_view.dart';
import 'package:getx_drift_app/features/paywall/paywall_page.dart';
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
    // GetPage(
    //   name: Routes.PERSONALBALANCE,
    //   page: () => const PersonalBalanceDetailsPage(),
    //   binding: PersonalBalanceBinding(),
    // ),
    GetPage(
      name: Routes.ONBOARDING,
      page: () => const OnboardingView(),
      // binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.ONBOARDING_FIRST_QUESTION,
      page: () => const OnboardingFirstQuestionView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: Routes.ONBOARDING_SECOND_QUESTION,
      page: () => const OnboardingSecondQuestionView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: Routes.ONBOARDING_THIRD_QUESTION,
      page: () => const OnboardingThirdQuestionView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: Routes.ONBOARDING_FOURTH_QUESTION,
      page: () => const OnboardingFourthQuestionView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: Routes.ONBOARDING_FIFTH_QUESTION,
      page: () => const OnboardingFifthQuestion(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: Routes.ONBOARDING_SIXTH_QUESTION,
      page: () => const OnboardingSixthQuestion(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: Routes.ONBOARDING_SEVENTH_QUESTION,
      page: () => const OnboardingSeventhQuestion(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: Routes.ONBOARDING_ASCEND_INTRO_VIEW,
      page: () => const OnboardingAscendIntroView(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: Routes.ONBOARDING_ASCEND_STABILITY_SCORE_VIEW,
      page: () => const OnboardingFinancialStabilityScoreIntro(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: Routes.ONBOARDING_ASCEND_STABILITY_PREVIEW_VIEW,
      page: () => const OnboardingFinancialStabilityPreview(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: Routes.ONBOARDING_LEARN_WITH_ASCEND_INTRO,
      page: () => const OnboardingLearnWithAscendIntro(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: Routes.ONBOARDING_LEARN_WITH_ASCEND_INTRO,
      page: () => const OnboardingLearnWithAscendIntro(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: Routes.ONBOARDING_LEARN_WITH_ASCEND_PREVIEW,
      page: () => const OnboardingLearnWithAscendPreview(),
      binding: BindingsBuilder(() {
        Get.lazyPut<OnboardingController>(() => OnboardingController());
      }),
    ),
    GetPage(
      name: Routes.PAYWALL,
      page: () => const PaywallPage(),
      binding: BindingsBuilder(() {
        Get.lazyPut<PaywallController>(() => PaywallController());
      }),
    ),

    GetPage(
      name: Routes.MAINVIEW,
      page: () => const MainShell(),
      binding: HomeBinding(),
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
      page: () => const CashflowDetailsPage(),
      // binding: TransactionBinding(),
    ),

    GetPage(
      name: Routes.BILLS,
      page: () => const BillsPage(),
      // binding: TransactionBinding(),
    ),

    //NET WORTH PAGE
    GetPage(
      name: Routes.NETWORTHDETAILS,
      page: () => const NetWorthDetailsPage(),
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
