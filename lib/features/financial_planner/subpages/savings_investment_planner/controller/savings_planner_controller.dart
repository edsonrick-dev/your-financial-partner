import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_position.dart';
import 'package:getx_drift_app/features/financial_insights/financial_profile_cashflow_controller_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/investor_profile/investory_profile_model.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';

class SavingsPlannerController extends GetxController {
  final financialProfileController = Get.find<FinancialProfileController>();
  final selectedHorizonTabIndex = 0.obs;

  final isUnderConstruction = true.obs;
  final isRiskToleranceAssessmentFinished = false.obs;
  final isLoading = true.obs;
  final investorProfile = Rxn<InvestorProfile>();
  bool get hasNetWorth => financialProfileController.hasNetWorth;

  bool get hasBudget => financialProfileController.hasBudget;

  bool get hasIncome => financialProfileController.hasIncome;

  bool get isCashflowComplete => hasIncome && hasBudget;

  bool get hasCashflowDeficit {
    return hasIncome &&
        hasBudget &&
        financialProfileController.cashflowPosition ==
            CashflowPosition.budgetExceedsIncome;
  }

  bool get hasPositiveNetCashflow {
    return financialProfileController.cashflowPosition ==
        CashflowPosition.budgetBelowIncome;
  }

  bool get canSetUpGoals =>
      hasNetWorth && isCashflowComplete && hasPositiveNetCashflow;
  String get financialSetupCta {
    if (!hasNetWorth) {
      return 'Set up net worth';
    }

    if (!hasIncome) {
      return 'Set up income plan';
    }

    if (!hasBudget) {
      return 'Set up budget plan';
    }

    if (hasCashflowDeficit) {
      return 'Fix cash flow';
    }

    return '';
  }

  void goToFinancialSetup() {
    if (!hasNetWorth) {
      Get.toNamed(Routes.NETWORTHDETAILS);
      // Go to Net Worth
      return;
    }

    if (!hasIncome) {
      financialProfileController
              .cashflowController
              .seletectedDetailsTabIndex
              .value =
          0;
      Get.toNamed(Routes.CASHFLOWDETAILS);
      // Go to Income Plan
      return;
    }

    if (!hasBudget) {
      financialProfileController
              .cashflowController
              .seletectedDetailsTabIndex
              .value =
          1;
      Get.toNamed(Routes.CASHFLOWDETAILS);
      // Go to Income Plan

      // Go to Budget Plan
      return;
    }

    if (hasCashflowDeficit) {
      financialProfileController
              .cashflowController
              .seletectedDetailsTabIndex
              .value =
          0;
      Get.toNamed(Routes.CASHFLOWDETAILS);
      // Go to Cash Flow / Budget Plan
      return;
    }
  }

  @override
  void onInit() {
    super.onInit();
    _loadInvestorProfile();
  }

  void selectHorizonTab(int index) {
    selectedHorizonTabIndex.value = index;
  }

  void completeRiskToleranceAssessment(InvestorProfile profile) {
    investorProfile.value = profile;
    isRiskToleranceAssessmentFinished.value = true;
  }

  Future<void> _loadInvestorProfile() async {
    final data = await database.investorProfileDao.getProfile();

    if (data?.investorProfile != null) {
      final profile = InvestorProfile.values.firstWhere(
        (value) => value.name == data!.investorProfile,
      );

      investorProfile.value = profile;
      isRiskToleranceAssessmentFinished.value = true;
    }

    isLoading.value = false;
  }
}
