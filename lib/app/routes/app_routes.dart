// ignore_for_file: constant_identifier_names

abstract class Routes {
  Routes._();
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
