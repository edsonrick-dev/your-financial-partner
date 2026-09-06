// ignore_for_file: constant_identifier_names

abstract class Routes {
  Routes._();
  static const PAYWALL = '/paywall';
  static const ONBOARDING = '/onboarding';
  static const ONBOARDING_FIRST_QUESTION = '/onboarding/first-question';
  static const ONBOARDING_SECOND_QUESTION = '/onboarding/second-question';
  static const ONBOARDING_THIRD_QUESTION = '/onboarding/third-question';
  static const ONBOARDING_FOURTH_QUESTION = '/onboarding/fourth-question';
  static const ONBOARDING_FIFTH_QUESTION = '/onboarding/fifth-question';
  static const ONBOARDING_SIXTH_QUESTION = '/onboarding/sixth-question';
  static const ONBOARDING_SEVENTH_QUESTION = '/onboarding/seventh-question';
  static const ONBOARDING_ASCEND_INTRO_VIEW = '/onboarding/ascend-intro-view';
  static const ONBOARDING_ASCEND_STABILITY_SCORE_VIEW =
      '/onboarding/ascend-stability-score-intro-view';
  static const ONBOARDING_ASCEND_STABILITY_PREVIEW_VIEW =
      '/onboarding/ascend-stability-score-preview-view';
  static const ONBOARDING_LEARN_WITH_ASCEND_INTRO =
      '/onboarding/learn-with-asecnd-intro';
  static const ONBOARDING_LEARN_WITH_ASCEND_PREVIEW =
      '/onboarding/learn-with-asecnd-preview';

  static const MAINVIEW = '/';
  static const HOME = '/home';

  static const ROOT = '/root';
  static const TRANSACTION = '/transaction';
  static const PERSONALBALANCE = '/personal-balance';
  static const preferences = '/settings/preferences';
  static const notifications = '/settings/notifications';

  //INSURANCE
  static const DEATHBENEFITGAP =
      '/financial-planner/insurance/death-benefit-gap';
  static const CRITICALILLNESSBENEFITGAP =
      '/financial-planner/insurance/critical-illness-benefit-gap';
  static const DISABILITYBENEFITGAP =
      '/financial-planner/insurance/disability-benefit-gap';
  static const INSURANCEPOLICIES =
      '/financial-planner/insurance/insurance-policies';
  static const BENEFICIARIES = '/financial-planner/insurance/beneficiaries';

  //CASHFLOW
  static const CASHFLOWDETAILS = '/financial-planner/cashflow/details';
  static const BUDGETS = '/financial-planner/cashflow/budgets';
  static const BILLS = '/financial-planner/cashflow/bills';

  //NET WORTH
  static const NETWORTHDETAILS = '/financial-planner/networth/details';
  static const PEOPLEBALANCES = '/financial-planner/networth/people-balances';
  static const NETWORTHEXPORT = '/financial-planner/networth/export';
  static const NETWORTHCHARTS = '/financial-planner/networth/charts';
  static const CHECKMANAGEMENTS =
      '/financial-planner/networth/checks-management';
}
