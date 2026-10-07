import 'dart:math';

import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_position.dart';
import 'package:getx_drift_app/features/financial_insights/financial_profile_cashflow_controller_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/investor_profile/investory_profile_model.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';

class SavingsPlannerController extends GetxController {
  double get monthlyGoalCapacity {
    return financialProfileController.monthlyNetCashflow.clamp(
      0.0,
      double.infinity,
    );
  }

  double get emergencyFundMonthlyAllocation {
    final goal = emergencyFundGoal.value;

    if (goal == null) {
      return 0.0;
    }

    final remainingAmount =
        (goal.targetAmount - emergencyFundReservedAmount.value).clamp(
          0.0,
          double.infinity,
        );

    if (remainingAmount <= 0) {
      return 0.0;
    }

    return [
      goal.monthlyContribution,
      remainingAmount,
      monthlyGoalCapacity,
    ].reduce(min);
  }

  double get remainingMonthlyGoalCapacity {
    return (monthlyGoalCapacity - emergencyFundMonthlyAllocation).clamp(
      0.0,
      double.infinity,
    );
  }

  double get monthlySavingsCapacity {
    return financialProfileController.annualSavings / 12;
  }

  // double remainingMonthlyCapacityForGoal(GoalsTableData goal) {
  //   final higherPriorityContributions = goals
  //       .where((item) => _hasHigherPriority(item, goal))
  //       .fold<double>(0.0, (sum, item) => sum + item.monthlyContribution);

  //   return (monthlySavingsCapacity - higherPriorityContributions).clamp(
  //     0.0,
  //     double.infinity,
  //   );
  // }

  // bool _hasHigherPriority(
  //   GoalsTableData existingGoal,
  //   GoalsTableData targetGoal,
  // ) {
  //   final existingPriority = goalPriority(
  //     GoalType.values.byName(existingGoal.type),
  //   );

  //   final targetPriority = goalPriority(
  //     GoalType.values.byName(targetGoal.type),
  //   );

  //   return existingPriority < targetPriority;
  // }

  double get emergencyFundMonthlyContribution {
    return emergencyFundGoal.value?.monthlyContribution ?? 0.0;
  }

  double get otherGoalsMonthlyContribution {
    return goals
        .where((goal) => goal.type != GoalType.emergencyFund.name)
        .fold<double>(0.0, (sum, goal) => sum + goal.monthlyContribution);
  }

  double get remainingUncommittedMonthlyReservation {
    final remaining =
        monthlySavingsCapacity -
        emergencyFundMonthlyContribution -
        otherGoalsMonthlyContribution;

    return remaining.clamp(0.0, double.infinity);
  }

  double get currentInvestment => emergencyFundReservedAmount.value;

  double get remainingMonthlyCapacity {
    return (monthlySavingsCapacity -
            emergencyFundMonthlyContribution -
            otherGoalsMonthlyContribution)
        .clamp(0.0, double.infinity);
  }

  double get totalMonthlyGoalCommitment {
    return goals.fold<double>(
      0.0,
      (sum, goal) => sum + goal.monthlyContribution,
    );
  }

  double get monthlyInvestmentCommitment {
    return emergencyFundGoal.value?.monthlyContribution ?? 0.0;
  }

  int get remainingInvestmentMonths {
    final now = DateTime.now();
    return 12 - now.month + 1;
  }

  double get investmentTarget {
    return currentInvestment +
        (monthlyInvestmentCommitment * remainingInvestmentMonths);
  }

  @override
  void onInit() {
    super.onInit();
    _loadInvestorProfile();
    database.goalsDao.watchGoalByType(GoalType.emergencyFund).listen((goal) {
      emergencyFundGoal.value = goal;

      if (goal == null) {
        emergencyFundReservedAmount.value = 0.0;
        return;
      }

      database.goalReservationsDao.watchReservationsForGoal(goal.id).listen((
        reservations,
      ) {
        emergencyFundReservedAmount.value = reservations.fold<double>(
          0.0,
          (sum, reservation) => sum + reservation.amount,
        );
      });
    });
    database.goalsDao.watchAllGoals().listen((items) {
      goals.assignAll(items);
    });
  }

  final goals = <GoalsTableData>[].obs;
  final emergencyFundReservedAmount = 0.0.obs;

  final emergencyFundGoal = Rxn<GoalsTableData>();
  final selectedPageTabIndex = 0.obs;
  void changePageTabIndex(int index) {
    selectedPageTabIndex.value = index;
  }

  void resetHorizonTab() {
    selectedHorizonTabIndex.value = 0;
  }

  final financialProfileController = Get.find<FinancialProfileController>();
  final selectedHorizonTabIndex = 0.obs;
  double get disposableIncome => financialProfileController.annualSavings;
  double get emergencyFundTarget => financialProfileController.annualBudget;
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
