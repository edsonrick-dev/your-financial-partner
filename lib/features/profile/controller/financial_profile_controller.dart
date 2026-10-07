import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/domain/financial_metrics_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/controller/retirement_planner_engine.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/projection/retirement_projection_engine.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/portfolio_horizon_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/portfolio_recommendation/portfolio_recommendation_engine.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/risk_tolerance_controller.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';
import 'package:getx_drift_app/features/profile/models/financial_stability_score_model.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_debt_load_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_emergency_fund_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_details_screen_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_lifestyle_coverage_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_wealth_building_extension.dart';
import 'package:intl/intl.dart';
import 'dart:isolate';

// final calculatedMonthlyContribution =
//     result['monthlyContribution'] as double;
// requiredMonthlyContribution.value = calculatedMonthlyContribution;

// final calculatedQuarterlyContribution =
//     result['quarterlyContribution'] as double;
// requiredQuarterlyContribution.value = calculatedQuarterlyContribution;

// final calculatedSemiAnnualContribution =
//     result['semiAnnualContribution'] as double;
// requiredSemiAnnualContribution.value = calculatedSemiAnnualContribution;

// final calculatedAnnualContribution =
//     result['annualContribution'] as double;
// requiredAnnualContribution.value = calculatedAnnualContribution;

class RetirementCalculationResult {
  final double futureAnnualLifestyle;
  final double retirementFundNeed;
  final List<RetirementProjection> retirementProjection;

  const RetirementCalculationResult({
    required this.futureAnnualLifestyle,
    required this.retirementFundNeed,
    required this.retirementProjection,
  });
}

Map<String, double> _calculateRetirementContributionsInIsolate({
  required DateTime birthDate,
  required double retirementFundNeed,
  required double currentSavings,
  required DateTime planDate,
  required DateTime retirementDate,
  required int retirementAge,
  required int fundLastUntilAge,
  required double firstYearWithdrawal,
  required double inflationRate,
  required double shortReturn,
  required double mediumReturn,
  required double longReturn,
}) {
  final monthlyContribution =
      RetirementPlannerEngine.calculateRequiredContribution(
        birthday: birthDate,
        retirementFundNeed: retirementFundNeed,
        currentSavings: currentSavings,
        planDate: planDate,
        retirementDate: retirementDate,
        retirementAge: retirementAge,
        fundLastUntilAge: fundLastUntilAge,
        firstYearWithdrawal: firstYearWithdrawal,
        inflationRate: inflationRate,
        frequency: BillsFrequency.monthly,
        shortReturn: shortReturn,
        mediumReturn: mediumReturn,
        longReturn: longReturn,
      );

  final quarterlyContribution =
      RetirementPlannerEngine.calculateRequiredContribution(
        birthday: birthDate,
        retirementFundNeed: retirementFundNeed,
        currentSavings: currentSavings,
        planDate: planDate,
        retirementDate: retirementDate,
        retirementAge: retirementAge,
        fundLastUntilAge: fundLastUntilAge,
        firstYearWithdrawal: firstYearWithdrawal,
        inflationRate: inflationRate,
        frequency: BillsFrequency.quarterly,
        shortReturn: shortReturn,
        mediumReturn: mediumReturn,
        longReturn: longReturn,
      );

  final semiAnnualContribution =
      RetirementPlannerEngine.calculateRequiredContribution(
        birthday: birthDate,
        retirementFundNeed: retirementFundNeed,
        currentSavings: currentSavings,
        planDate: planDate,
        retirementDate: retirementDate,
        retirementAge: retirementAge,
        fundLastUntilAge: fundLastUntilAge,
        firstYearWithdrawal: firstYearWithdrawal,
        inflationRate: inflationRate,
        frequency: BillsFrequency.semiAnnual,
        shortReturn: shortReturn,
        mediumReturn: mediumReturn,
        longReturn: longReturn,
      );

  final annualContribution =
      RetirementPlannerEngine.calculateRequiredContribution(
        birthday: birthDate,
        retirementFundNeed: retirementFundNeed,
        currentSavings: currentSavings,
        planDate: planDate,
        retirementDate: retirementDate,
        retirementAge: retirementAge,
        fundLastUntilAge: fundLastUntilAge,
        firstYearWithdrawal: firstYearWithdrawal,
        inflationRate: inflationRate,
        frequency: BillsFrequency.annual,
        shortReturn: shortReturn,
        mediumReturn: mediumReturn,
        longReturn: longReturn,
      );

  return {
    'monthlyContribution': monthlyContribution,
    'quarterlyContribution': quarterlyContribution,
    'semiAnnualContribution': semiAnnualContribution,
    'annualContribution': annualContribution,
  };
}

Map<String, dynamic> _calculateRetirementFundInIsolate({
  required DateTime retirementDate,
  required int retirementAge,
  required int fundLastUntilAge,
  required double firstYearWithdrawal,
  required double inflationRate,
  required double shortReturn,
  required double mediumReturn,
  required double longReturn,
}) {
  final retirementFundNeed = calculateRequiredRetirementFund(
    retirementDate: retirementDate,
    retirementAge: retirementAge,
    fundLastUntilAge: fundLastUntilAge,
    firstYearWithdrawal: firstYearWithdrawal,
    inflationRate: inflationRate,
    shortReturn: shortReturn,
    mediumReturn: mediumReturn,
    longReturn: longReturn,
  );

  final retirementProjection = calculateRetirementProjection(
    retirementFund: retirementFundNeed,
    retirementDate: retirementDate,
    retirementAge: retirementAge,
    fundLastUntilAge: fundLastUntilAge,
    firstYearWithdrawal: firstYearWithdrawal,
    inflationRate: inflationRate,
    shortReturn: shortReturn,
    mediumReturn: mediumReturn,
    longReturn: longReturn,
  );

  return {
    'retirementFundNeed': retirementFundNeed,
    'retirementProjection': retirementProjection
        .map(
          (projection) => {
            'age': projection.age,
            'date': projection.date,
            'beginningBalance': projection.beginningBalance,
            'withdrawal': projection.withdrawal,
            'remainingBalance': projection.remainingBalance,
            'shortWeight': projection.shortWeight,
            'mediumWeight': projection.mediumWeight,
            'longWeight': projection.longWeight,
            'returnRate': projection.returnRate,
            'interestEarned': projection.interestEarned,
            'endBalance': projection.endBalance,
          },
        )
        .toList(),
  };
}

class FinancialProfileController extends GetxController {
  final isCalculatingRetirementContribution = false.obs;
  String? _lastRetirementContributionCalculationKey;
  String _buildRetirementContributionCalculationKey({
    required double retirementFundNeed,
    required double currentSavings,
    required DateTime retirementDate,
    required int retirementAge,
    required int fundLastUntilAge,
    required double firstYearWithdrawal,
    required double inflationRate,
    required double shortReturn,
    required double mediumReturn,
    required double longReturn,
  }) {
    return [
      retirementFundNeed,
      currentSavings,
      retirementDate.millisecondsSinceEpoch,
      retirementAge,
      fundLastUntilAge,
      firstYearWithdrawal,
      inflationRate,
      shortReturn,
      mediumReturn,
      longReturn,
    ].join('|');
  }

  String? _lastRetirementCalculationKey;
  String _buildRetirementCalculationKey({
    required double shortReturn,
    required double mediumReturn,
    required double longReturn,
  }) {
    return [
      birthday.value?.millisecondsSinceEpoch,
      retirementAge.value,
      retirementFundEndAge.value,
      retirementLifestyleShare.value,
      annualBudget,
      inflationRate,
      currentRetirementSavings.value,
      shortReturn,
      mediumReturn,
      longReturn,
    ].join('|');
  }

  final isCalculatingRetirementFund = false.obs;
  final Rxn<DateTime> birthday = Rxn<DateTime>();
  final isBirthdayLoading = true.obs;

  Future<void> loadBirthday() async {
    isBirthdayLoading.value = true;

    final profile = await database.userProfileDao.getProfile();

    birthday.value = profile?.birthday;

    isBirthdayLoading.value = false;
  }

  Future<void> setBirthday(DateTime date) async {
    birthday.value = date;

    await database.userProfileDao.updateProfile(birthday: date);
  }

  String get formattedBirthday {
    final date = birthday.value;

    if (date == null) {
      return '';
    }

    return DateFormat('MMMM d, yyyy').format(date);
  }

  int? get currentAge {
    final birthDate = birthday.value;

    if (birthDate == null) {
      return null;
    }

    final today = DateTime.now();

    var age = today.year - birthDate.year;

    if (today.month < birthDate.month ||
        (today.month == birthDate.month && today.day < birthDate.day)) {
      age--;
    }

    return age;
  }

  final retirementStep = 0.obs;
  final requiredMonthlyContribution = 0.0.obs;
  final requiredQuarterlyContribution = 0.0.obs;
  final requiredSemiAnnualContribution = 0.0.obs;
  final currentRetirementSavings = 0.0.obs;
  final requiredAnnualContribution = 0.0.obs;
  // final accumulationProjection = <AccumulationProjection>[].obs;

  final retirementProjection = <RetirementProjection>[].obs;
  final retirementFundNeed = 0.0.obs;
  final futureAnnualLifestyle = 0.0.obs;
  Future<bool> calculateRequiredRetirementContributions() async {
    if (isCalculatingRetirementContribution.value) {
      return false;
    }

    final birthDate = birthday.value;

    if (birthDate == null) {
      return false;
    }

    // Resolve all inputs needed by the calculation.
    final riskToleranceController = Get.isRegistered<RiskToleranceController>()
        ? Get.find<RiskToleranceController>()
        : Get.put(RiskToleranceController());

    await riskToleranceController.initialization;

    final profile = riskToleranceController.investorProfile.value;

    if (profile == null) {
      return false;
    }

    final shortRecommendation = PortfolioRecommendationEngine.getRecommendation(
      profile: profile,
      horizon: PortfolioHorizon.short,
    );

    final mediumRecommendation =
        PortfolioRecommendationEngine.getRecommendation(
          profile: profile,
          horizon: PortfolioHorizon.medium,
        );

    final longRecommendation = PortfolioRecommendationEngine.getRecommendation(
      profile: profile,
      horizon: PortfolioHorizon.long,
    );

    final shortReturn = shortRecommendation.returnRange.average;

    final mediumReturn = mediumRecommendation.returnRange.average;

    final longReturn = longRecommendation.returnRange.average;

    final retirementAgeValue = retirementAge.value;

    final fundLastUntilAgeValue = retirementFundEndAge.value;

    final retirementFundNeedValue = retirementFundNeed.value;

    final currentSavingsValue = currentRetirementSavings.value;

    final firstYearWithdrawalValue = futureAnnualLifestyle.value;

    final inflationRateValue = inflationRate;

    final retirementDate = RetirementPlannerEngine.calculateRetirementDate(
      birthday: birthDate,
      retirementAge: retirementAgeValue,
    );

    final calculationKey = _buildRetirementContributionCalculationKey(
      retirementFundNeed: retirementFundNeedValue,
      currentSavings: currentSavingsValue,
      retirementDate: retirementDate,
      retirementAge: retirementAgeValue,
      fundLastUntilAge: fundLastUntilAgeValue,
      firstYearWithdrawal: firstYearWithdrawalValue,
      inflationRate: inflationRateValue,
      shortReturn: shortReturn,
      mediumReturn: mediumReturn,
      longReturn: longReturn,
    );

    // Nothing affecting the contribution calculation changed.
    if (_lastRetirementContributionCalculationKey == calculationKey) {
      debugPrint(
        'Retirement contribution calculation unchanged. '
        'Reusing existing result.',
      );

      return true;
    }

    // Only show loading when calculation is actually required.
    isCalculatingRetirementContribution.value = true;

    try {
      final planDateValue = DateTime.now();

      final result = await Isolate.run(
        () => _calculateRetirementContributionsInIsolate(
          birthDate: birthDate,
          retirementFundNeed: retirementFundNeedValue,
          currentSavings: currentSavingsValue,
          planDate: planDateValue,
          retirementDate: retirementDate,
          retirementAge: retirementAgeValue,
          fundLastUntilAge: fundLastUntilAgeValue,
          firstYearWithdrawal: firstYearWithdrawalValue,
          inflationRate: inflationRateValue,
          shortReturn: shortReturn,
          mediumReturn: mediumReturn,
          longReturn: longReturn,
        ),
      );

      requiredMonthlyContribution.value = result['monthlyContribution']!;

      requiredQuarterlyContribution.value = result['quarterlyContribution']!;

      requiredSemiAnnualContribution.value = result['semiAnnualContribution']!;

      requiredAnnualContribution.value = result['annualContribution']!;

      _lastRetirementContributionCalculationKey = calculationKey;

      return true;
    } finally {
      isCalculatingRetirementContribution.value = false;
    }
  }

  // Future<bool> calculateRequiredRetirementContributions() async {
  //   final birthDate = birthday.value;

  //   if (birthDate == null) {
  //     return false;
  //   }

  //   final riskToleranceController = Get.isRegistered<RiskToleranceController>()
  //       ? Get.find<RiskToleranceController>()
  //       : Get.put(RiskToleranceController());

  //   await riskToleranceController.initialization;

  //   final profile = riskToleranceController.investorProfile.value;

  //   if (profile == null) {
  //     return false;
  //   }

  //   final shortRecommendation = PortfolioRecommendationEngine.getRecommendation(
  //     profile: profile,
  //     horizon: PortfolioHorizon.short,
  //   );

  //   final mediumRecommendation =
  //       PortfolioRecommendationEngine.getRecommendation(
  //         profile: profile,
  //         horizon: PortfolioHorizon.medium,
  //       );

  //   final longRecommendation = PortfolioRecommendationEngine.getRecommendation(
  //     profile: profile,
  //     horizon: PortfolioHorizon.long,
  //   );

  //   final shortReturn = shortRecommendation.returnRange.average;

  //   final mediumReturn = mediumRecommendation.returnRange.average;

  //   final longReturn = longRecommendation.returnRange.average;

  //   final retirementAgeValue = retirementAge.value;

  //   final fundLastUntilAgeValue = retirementFundEndAge.value;

  //   final retirementFundNeedValue = retirementFundNeed.value;

  //   final currentSavingsValue = currentRetirementSavings.value;

  //   final firstYearWithdrawalValue = futureAnnualLifestyle.value;

  //   final inflationRateValue = inflationRate;

  //   final planDateValue = DateTime.now();

  //   final retirementDate = RetirementPlannerEngine.calculateRetirementDate(
  //     birthday: birthDate,
  //     retirementAge: retirementAgeValue,
  //   );

  //   final result = await Isolate.run(
  //     () => _calculateRetirementContributionsInIsolate(
  //       birthDate: birthDate,
  //       retirementFundNeed: retirementFundNeedValue,
  //       currentSavings: currentSavingsValue,
  //       planDate: planDateValue,
  //       retirementDate: retirementDate,
  //       retirementAge: retirementAgeValue,
  //       fundLastUntilAge: fundLastUntilAgeValue,
  //       firstYearWithdrawal: firstYearWithdrawalValue,
  //       inflationRate: inflationRateValue,
  //       shortReturn: shortReturn,
  //       mediumReturn: mediumReturn,
  //       longReturn: longReturn,
  //     ),
  //   );

  //   requiredMonthlyContribution.value = result['monthlyContribution']!;

  //   requiredQuarterlyContribution.value = result['quarterlyContribution']!;

  //   requiredSemiAnnualContribution.value = result['semiAnnualContribution']!;

  //   requiredAnnualContribution.value = result['annualContribution']!;

  //   return true;
  // }
  //  Future<bool> calculateRequiredRetirementContributions({
  //   required double retirementFundNeed,
  //   required double currentSavings,
  //   required DateTime planDate,
  //   required DateTime retirementDate,
  //   required int retirementAge,
  //   required int fundLastUntilAge,
  //   required double firstYearWithdrawal,
  //   required double inflationRate,
  //   required double shortReturn,
  //   required double mediumReturn,
  //   required double longReturn,
  // }) async {
  //     final birthDate = birthday.value;

  //     if (birthDate == null) {
  //       return false;
  //     }

  //     final result = await Isolate.run(
  //       () => _calculateRetirementContributionsInIsolate(
  //         birthDate: birthDate,
  //         retirementFundNeed: retirementFundNeed,
  //         currentSavings: currentSavings,
  //         planDate: planDate,
  //         retirementDate: retirementDate,
  //         retirementAge: retirementAge,
  //         fundLastUntilAge: fundLastUntilAge,
  //         firstYearWithdrawal: firstYearWithdrawal,
  //         inflationRate: inflationRate,
  //         shortReturn: shortReturn,
  //         mediumReturn: mediumReturn,
  //         longReturn: longReturn,
  //       ),
  //     );

  //     requiredMonthlyContribution.value = result['monthlyContribution']!;

  //     requiredQuarterlyContribution.value = result['quarterlyContribution']!;

  //     requiredSemiAnnualContribution.value = result['semiAnnualContribution']!;

  //     requiredAnnualContribution.value = result['annualContribution']!;

  //     return true;
  //   }

  double get futureAnnualRetirementLifestyle =>
      RetirementPlannerEngine.calculateFutureAnnualLifestyle(
        annualLifestyle: retirementAnnualLifestyle,
        inflationRate: inflationRate,
        yearsToRetirement: yearsToRetirement,
      );

  List<RetirementProjection> _parseRetirementProjection(List<dynamic> rows) {
    return rows.map((row) {
      return RetirementProjection(
        age: row['age'] as int,
        date: row['date'] as DateTime,
        beginningBalance: row['beginningBalance'] as double,
        withdrawal: row['withdrawal'] as double,
        remainingBalance: row['remainingBalance'] as double,
        shortWeight: row['shortWeight'] as double,
        mediumWeight: row['mediumWeight'] as double,
        longWeight: row['longWeight'] as double,
        returnRate: row['returnRate'] as double,
        interestEarned: row['interestEarned'] as double,
        endBalance: row['endBalance'] as double,
      );
    }).toList();
  }

  Future<bool> calculateRetirementFundNeed() async {
    if (isCalculatingRetirementFund.value) {
      return false;
    }

    try {
      final birthDate = birthday.value;

      if (birthDate == null) {
        debugPrint('Birthday is required before calculating retirement.');
        return false;
      }

      final riskToleranceController =
          Get.isRegistered<RiskToleranceController>()
          ? Get.find<RiskToleranceController>()
          : Get.put(RiskToleranceController());

      await riskToleranceController.initialization;

      final profile = riskToleranceController.investorProfile.value;

      if (profile == null) {
        debugPrint('Investor profile is incomplete.');
        return false;
      }

      final shortRecommendation =
          PortfolioRecommendationEngine.getRecommendation(
            profile: profile,
            horizon: PortfolioHorizon.short,
          );

      final mediumRecommendation =
          PortfolioRecommendationEngine.getRecommendation(
            profile: profile,
            horizon: PortfolioHorizon.medium,
          );

      final longRecommendation =
          PortfolioRecommendationEngine.getRecommendation(
            profile: profile,
            horizon: PortfolioHorizon.long,
          );

      final shortReturn = shortRecommendation.returnRange.average;

      final mediumReturn = mediumRecommendation.returnRange.average;

      final longReturn = longRecommendation.returnRange.average;

      final retirementDate = RetirementPlannerEngine.calculateRetirementDate(
        birthday: birthDate,
        retirementAge: retirementAge.value,
      );

      final calculationKey = _buildRetirementCalculationKey(
        shortReturn: shortReturn,
        mediumReturn: mediumReturn,
        longReturn: longReturn,
      );

      if (_lastRetirementCalculationKey == calculationKey) {
        debugPrint('Retirement fund calculation unchanged.');
        return true;
      }

      isCalculatingRetirementFund.value = true;

      final yearsToRetirement =
          RetirementPlannerEngine.calculateYearsToRetirement(
            planDate: DateTime.now(),
            retirementDate: retirementDate,
          );

      final calculatedFutureAnnualLifestyle =
          RetirementPlannerEngine.calculateFutureAnnualLifestyle(
            annualLifestyle: retirementAnnualLifestyle,
            inflationRate: inflationRate,
            yearsToRetirement: yearsToRetirement,
          );

      final retirementAgeValue = retirementAge.value;
      final retirementFundEndAgeValue = retirementFundEndAge.value;
      final inflationRateValue = inflationRate;
      final shortReturnValue = shortReturn;
      final mediumReturnValue = mediumReturn;
      final longReturnValue = longReturn;

      final result = await Isolate.run(
        () => _calculateRetirementFundInIsolate(
          retirementDate: retirementDate,
          retirementAge: retirementAgeValue,
          fundLastUntilAge: retirementFundEndAgeValue,
          firstYearWithdrawal: calculatedFutureAnnualLifestyle,
          inflationRate: inflationRateValue,
          shortReturn: shortReturnValue,
          mediumReturn: mediumReturnValue,
          longReturn: longReturnValue,
        ),
      );
      retirementFundNeed.value = result['retirementFundNeed'] as double;

      futureAnnualLifestyle.value = calculatedFutureAnnualLifestyle;

      retirementProjection.value = _parseRetirementProjection(
        result['retirementProjection'] as List<dynamic>,
      );

      _lastRetirementCalculationKey = calculationKey;

      return true;
    } finally {
      isCalculatingRetirementFund.value = false;
    }
  }
  // Future<bool> calculateRetirementFundNeed() async {
  //   if (isCalculatingRetirementFund.value) {
  //     return false;
  //   }

  //   try {
  //     final birthDate = birthday.value;

  //     if (birthDate == null) {
  //       debugPrint('Birthday is required before calculating retirement.');
  //       return false;
  //     }

  //     final riskToleranceController =
  //         Get.isRegistered<RiskToleranceController>()
  //         ? Get.find<RiskToleranceController>()
  //         : Get.put(RiskToleranceController());

  //     await riskToleranceController.initialization;

  //     final profile = riskToleranceController.investorProfile.value;

  //     if (profile == null) {
  //       debugPrint('Investor profile is incomplete.');
  //       return false;
  //     }

  //     final shortRecommendation =
  //         PortfolioRecommendationEngine.getRecommendation(
  //           profile: profile,
  //           horizon: PortfolioHorizon.short,
  //         );

  //     final mediumRecommendation =
  //         PortfolioRecommendationEngine.getRecommendation(
  //           profile: profile,
  //           horizon: PortfolioHorizon.medium,
  //         );

  //     final longRecommendation =
  //         PortfolioRecommendationEngine.getRecommendation(
  //           profile: profile,
  //           horizon: PortfolioHorizon.long,
  //         );

  //     final shortReturn = shortRecommendation.returnRange.average;
  //     final mediumReturn = mediumRecommendation.returnRange.average;
  //     final longReturn = longRecommendation.returnRange.average;

  //     final retirementDate = RetirementPlannerEngine.calculateRetirementDate(
  //       birthday: birthDate,
  //       retirementAge: retirementAge.value,
  //     );
  //     // Nothing changed since the last calculation.
  //     final calculationKey = _buildRetirementCalculationKey(
  //       shortReturn: shortReturn,
  //       mediumReturn: mediumReturn,
  //       longReturn: longReturn,
  //     );

  //     // Reuse the existing result if nothing affecting
  //     // the calculation has changed.
  //     if (_lastRetirementCalculationKey == calculationKey) {
  //       debugPrint(
  //         'Retirement calculation unchanged. Reusing existing result.',
  //       );
  //       return true;
  //     }

  //     // Only show loading when an actual calculation is required.
  //     isCalculatingRetirementFund.value = true;

  //     final yearsToRetirement =
  //         RetirementPlannerEngine.calculateYearsToRetirement(
  //           planDate: DateTime.now(),
  //           retirementDate: retirementDate,
  //         );

  //     final calculatedFutureAnnualLifestyle =
  //         RetirementPlannerEngine.calculateFutureAnnualLifestyle(
  //           annualLifestyle: retirementAnnualLifestyle,
  //           inflationRate: inflationRate,
  //           yearsToRetirement: yearsToRetirement,
  //         );
  // final retirementAgeValue = retirementAge.value;
  // final retirementFundEndAgeValue = retirementFundEndAge.value;
  // final inflationRateValue = inflationRate;
  // final shortReturnValue = shortReturn;
  // final mediumReturnValue = mediumReturn;
  // final longReturnValue = longReturn;
  // final currentSavingsValue = currentRetirementSavings.value;
  //     // Run the expensive retirement math away from the UI isolate.
  //     final result = await Isolate.run(
  //       () => _calculateRetirementInIsolate(
  //         birthDate: birthDate,
  //         retirementDate: retirementDate,
  //         retirementAge: retirementAgeValue,
  //         fundLastUntilAge: retirementFundEndAgeValue,
  //         firstYearWithdrawal: calculatedFutureAnnualLifestyle,
  //         inflationRate: inflationRateValue,
  //         currentSavings: currentSavingsValue,
  //         shortReturn: shortReturnValue,
  //         mediumReturn: mediumReturnValue,
  //         longReturn: longReturnValue,
  //       ),
  //     );
  //     final calculatedRetirementFundNeed =
  //         result['retirementFundNeed'] as double;
  //     retirementFundNeed.value = calculatedRetirementFundNeed;

  //     final calculatedRetirementProjection = _parseRetirementProjection(
  //       result['retirementProjection'] as List<dynamic>,
  //     );

  //     futureAnnualLifestyle.value = calculatedFutureAnnualLifestyle;

  //     retirementProjection.value = calculatedRetirementProjection;

  //     // ADD THIS
  //     _lastRetirementCalculationKey = calculationKey;
  //     return true;
  //   } finally {
  //     isCalculatingRetirementFund.value = false;
  //   }
  // }

  final retirementLifestyleShare = 1.0.obs;
  final inflationRate = 0.041;
  final retirementReturn = 0.07;

  final retirementAge = 60.obs;
  final retirementFundEndAge = 80.obs;

  double get yearsToRetirement {
    final age = currentAge;

    if (age == null) {
      return 0;
    }

    return (retirementAge.value - age).toDouble();
  }

  double get retirementAnnualLifestyle =>
      annualBudget * retirementLifestyleShare.value;

  // DateTime get birthday {
  //   final today = DateTime.now();

  //   var birthYear = today.year - currentAge.value;

  //   final assumedBirthday = DateTime(birthYear, birthMonth, birthDay);

  //   if (assumedBirthday.isAfter(today)) {
  //     birthYear--;
  //   }

  //   return DateTime(birthYear, birthMonth, birthDay);
  // }

  Future<void> revealFinancialStabilityProfile() async {
    hasRevealedProfile.value = true;

    await _storage.write(_profileRevealedKey, true);
  }

  @override
  void onInit() {
    super.onInit();
    loadBirthday();
    hasCompletedAssessment.value =
        _storage.read<bool>(_assessmentCompletedKey) ?? false;
    hasRevealedProfile.value =
        _storage.read<bool>(_profileRevealedKey) ?? false;
    stabilityDetailKeys = List.generate(
      stabilityProfileDetails.length,
      (_) => GlobalKey(),
    );
  }

  final GetStorage _storage = GetStorage();

  static const _assessmentCompletedKey = 'financial_assessment_completed';

  static const _profileRevealedKey = 'financial_profile_revealed';

  final hasCompletedAssessment = false.obs;
  final hasRevealedProfile = false.obs;
  Future<void> markAssessmentCompleted() async {
    hasCompletedAssessment.value = true;

    await _storage.write(_assessmentCompletedKey, true);
  }

  // final GetStorage _storage = GetStorage();

  // static const _assessmentCompletedKey = 'financial_assessment_completed';

  // final hasCompletedAssessment = false.obs;

  final CashflowController cashflowController = Get.find<CashflowController>();

  final NetWorthController netWorthController = Get.find<NetWorthController>();

  final FinancialMetricsCalculator calculator = FinancialMetricsCalculator();

  // ---------------------------------------------------------------------------
  // Raw financial data
  // ---------------------------------------------------------------------------
  bool get hasAssets => netWorthController.hasAssets;
  bool get hasLiabilities => netWorthController.hasLiabilities;
  double get annualIncome => cashflowController.plannedAnnualIncome.value;
  double get monthlyIncome => cashflowController.plannedAnnualIncome.value / 12;

  double get annualBudget => cashflowController.annualBudget.value;
  double get monthlyBudget => annualBudget / 12;

  double get annualExpenses => cashflowController.annualExpense.value;

  double get annualDebtRepayments =>
      cashflowController.annualDebtRepayment.value;
  double get annualNetCashflow => cashflowController.annualCashflowDifference;
  double get monthlyNetCashflow => annualNetCashflow / 12;
  double get netWorth => netWorthController.netWorth;
  double get liabilities => netWorthController.totalLiabilities;
  double get assets => netWorthController.totalAssets;
  double get averageMonthlyBudget => cashflowController.annualBudget.value / 12;
  // ---------------------------------------------------------------------------
  // IDEAL BUDGET TARGET
  // ---------------------------------------------------------------------------

  double get idealAnnualBudget => annualIncome * 0.70;

  double get idealMonthlyBudget => idealAnnualBudget / 12;

  bool get isBudgetAboveIncome {
    return annualBudget > annualIncome;
  }

  bool get isBudgetAboveIdeal {
    return annualBudget > idealAnnualBudget;
  }

  bool get hasIdealBudget {
    return annualBudget <= idealAnnualBudget;
  }

  double get budgetTarget {
    if (isBudgetAboveIncome) {
      return annualIncome;
    }

    return idealAnnualBudget;
  }

  double get budgetGap {
    return max(0, annualBudget - budgetTarget);
  }

  double get monthlyBudgetGap => budgetGap / 12;

  // ---------------------------------------------------------------------------
  // IDEAL INCOME TARGET
  // ---------------------------------------------------------------------------

  double? get idealAnnualIncome {
    if (annualBudget <= 0) {
      return null;
    }

    return annualBudget / 0.70;
  }

  double? get idealMonthlyIncome {
    final annual = idealAnnualIncome;

    if (annual == null) {
      return null;
    }

    return annual / 12;
  }

  bool get hasIdealIncome {
    final ideal = idealAnnualIncome;

    if (ideal == null) {
      return false;
    }

    return annualIncome >= ideal;
  }

  double? get idealIncomeGap {
    final ideal = idealAnnualIncome;

    if (ideal == null) {
      return null;
    }

    return max(0, ideal - annualIncome);
  }

  double? get monthlyIncomeGap {
    final gap = idealIncomeGap;

    if (gap == null) {
      return null;
    }

    return gap / 12;
  } // TODO: Include here Liquid Funds & Average Daily Balance

  // ---------------------------------------------------------------------------
  // Liquid funds
  // ---------------------------------------------------------------------------

  bool get hasLiquidFunds => netWorthController.hasLiquidFundAccounts;
  double get liquidFunds => netWorthController.liquidFunds;
  bool get hasNetWorth => netWorthController.hasAccounts;
  double? get averageDailyBalance =>
      null; // netWorthController.averageDailyBalance;

  double? get emergencyFundAvailable {
    final adb = averageDailyBalance;

    if (adb == null) return liquidFunds;

    return min(liquidFunds, adb);
  }

  // ---------------------------------------------------------------------------
  // Derived  values
  // ---------------------------------------------------------------------------

  bool get hasDebtRepayment => cashflowController.hasDebtRepaymentPlan;
  double get annualSavings => annualIncome - annualBudget;

  // ---------------------------------------------------------------------------
  // Details Page State
  // ---------------------------------------------------------------------------
  final detailsScrollController = ScrollController();
  final selectedDetailsIndex = 0.obs;

  @override
  void onClose() {
    detailsScrollController.dispose();
    super.onClose();
  }

  late final List<GlobalKey> stabilityDetailKeys;

  List<FinancialRatio> get ratios => [
    debtLoad,
    emergencyFund,
    wealthBuilding,
    lifestyleCoverage,
  ];

  int get financialScore {
    return ratios.fold(0, (total, ratio) => total + ratio.points);
  }

  FinancialStability get stability {
    return FinancialStability.fromScore(financialScore);
  }
}
