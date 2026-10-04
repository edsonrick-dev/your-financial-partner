import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:get/get.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/controller/retirement_planner_engine.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/projection/retirement_projection_engine.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/portfolio_horizon_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/portfolio_recommendation/portfolio_recommendation_engine.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/risk_return/retirement_horizon_returns.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/risk_return/risk_return_range_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/risk_tolerance_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

double calculateAccumulationReturn({
  required double yearsToRetirement,
  required double shortReturn,
  required double mediumReturn,
  required double longReturn,
}) {
  if (yearsToRetirement > PortfolioHorizon.medium.minYears) {
    return longReturn;
  }

  if (yearsToRetirement > PortfolioHorizon.short.minYears) {
    return mediumReturn;
  }

  return shortReturn;
}

class RetirementDebugger extends StatelessWidget {
  const RetirementDebugger({super.key});

  void _debugRetirementHorizonReturns({
    required DateTime retirementDate,
    required int retirementAge,
    required int fundLastUntilAge,
    required double firstYearWithdrawal,
    required double inflationRate,
    required double shortReturn,
    required double mediumReturn,
    required double longReturn,
  }) {
    final withdrawals = buildRetirementWithdrawals(
      retirementDate: retirementDate,
      retirementAge: retirementAge,
      fundLastUntilAge: fundLastUntilAge,
      firstYearWithdrawal: firstYearWithdrawal,
      inflationRate: inflationRate,
    );

    debugPrint('');
    debugPrint('============================================================');
    debugPrint('              RETIREMENT HORIZON DEBUG');
    debugPrint('============================================================');

    for (var i = 0; i < withdrawals.length; i++) {
      final currentWithdrawal = withdrawals[i];

      final futureWithdrawals = withdrawals.sublist(i);

      final weights = RetirementHorizonReturns.calculateHorizonWeights(
        currentDate: currentWithdrawal.date,
        futureWithdrawals: futureWithdrawals,
      );

      final blendedReturn =
          RetirementHorizonReturns.calculateBlendedRetirementReturn(
            weights: weights,
            returns: RetirementHorizonReturns(
              short: shortReturn,
              medium: mediumReturn,
              long: longReturn,
            ),
          );

      debugPrint('');
      debugPrint(
        '-------------------- AGE ${retirementAge + i} --------------------',
      );

      debugPrint('Date:             ${currentWithdrawal.date}');

      debugPrint(
        'Withdrawal:       '
        '${currentWithdrawal.amount.toCurrency()}',
      );

      debugPrint(
        'Short weight:     '
        '${(weights[PortfolioHorizon.short]! * 100).toStringAsFixed(2)}%',
      );

      debugPrint(
        'Medium weight:    '
        '${(weights[PortfolioHorizon.medium]! * 100).toStringAsFixed(2)}%',
      );

      debugPrint(
        'Long weight:      '
        '${(weights[PortfolioHorizon.long]! * 100).toStringAsFixed(2)}%',
      );

      debugPrint(
        'Blended return:   '
        '${(blendedReturn * 100).toStringAsFixed(2)}%',
      );
    }

    debugPrint('');
    debugPrint('============================================================');
    debugPrint('            END RETIREMENT HORIZON DEBUG');
    debugPrint('============================================================');
  }

  @override
  Widget build(BuildContext context) {
    return AppSection(
      child: AppButton(
        text: 'Debug Retirement Planner',
        onTap: _debugRetirementPlanner,
      ),
    );
  }

  void _debugAccumulationProjection({
    required DateTime planDate,
    required DateTime retirementDate,
    required int currentAge,
    required int retirementAge,
    required int fundLastUntilAge,
    required double firstYearWithdrawal,
    required double inflationRate,
    required double currentSavings,
    required double contribution,
    required BillsFrequency frequency,
    required double shortReturn,
    required double mediumReturn,
    required double longReturn,
  }) {
    final yearsToRetirement =
        retirementDate.difference(planDate).inDays / 365.2425;

    final totalYears = yearsToRetirement.ceil();

    final periodsPerYear = frequency.investmentPeriodsPerYear;
    final withdrawals = buildRetirementWithdrawals(
      retirementDate: retirementDate,
      retirementAge: retirementAge,
      fundLastUntilAge: fundLastUntilAge,
      firstYearWithdrawal: firstYearWithdrawal,
      inflationRate: inflationRate,
    );

    final returns = RetirementHorizonReturns(
      short: shortReturn,
      medium: mediumReturn,
      long: longReturn,
    );
    final annualInvestment = contribution * periodsPerYear;

    var balance = currentSavings;
    var totalInvested = currentSavings;

    debugPrint('');
    debugPrint('============================================================');
    debugPrint('                  ACCUMULATION PROJECTION');
    debugPrint('============================================================');

    debugPrint('Starting savings:      ${currentSavings.toCurrency()}');

    debugPrint('Periodic contribution: ${contribution.toCurrency()}');

    debugPrint('Annual investment:     ${annualInvestment.toCurrency()}');

    debugPrint('');

    debugPrint(
      'AGE | BEGINNING BALANCE | ANNUAL INVESTMENT | '
      'TOTAL AMOUNT INVESTED | Short | Medium | Long | '
      'Ave. RETURN (%) | INTEREST EARNED | END BALANCE',
    );

    debugPrint('-' * 120);

    for (var year = 0; year < totalYears; year++) {
      final age = currentAge + year;

      final beginningBalance = balance;

      final accumulationDate = DateTime(
        planDate.year + year,
        planDate.month,
        planDate.day,
      );

      final weights = RetirementHorizonReturns.calculateHorizonWeights(
        currentDate: accumulationDate,
        futureWithdrawals: withdrawals,
      );

      final annualReturn =
          RetirementHorizonReturns.calculateBlendedRetirementReturn(
            weights: weights,
            returns: returns,
          );
      final periodicReturn = RetirementPlannerEngine.calculatePeriodicReturn(
        annualReturn: annualReturn,
        frequency: frequency,
      );

      var interestEarned = 0.0;

      for (var period = 0; period < periodsPerYear; period++) {
        final interest = balance * periodicReturn;

        balance += interest;
        interestEarned += interest;

        balance += contribution;
      }

      totalInvested += annualInvestment;

      debugPrint(
        '$age | '
        '${beginningBalance.toCurrency()} | '
        '${annualInvestment.toCurrency()} | '
        '${totalInvested.toCurrency()} | '
        '${((weights[PortfolioHorizon.short] ?? 0) * 100).toStringAsFixed(2)}% | '
        '${((weights[PortfolioHorizon.medium] ?? 0) * 100).toStringAsFixed(2)}% | '
        '${((weights[PortfolioHorizon.long] ?? 0) * 100).toStringAsFixed(2)}% | '
        '${(annualReturn * 100).toStringAsFixed(2)}% | '
        '${interestEarned.toCurrency()} | '
        '${balance.toCurrency()}',
      );
    }

    debugPrint('');

    debugPrint(
      'FINAL BALANCE: '
      '${balance.toCurrency()}',
    );

    debugPrint(
      'TOTAL INVESTED: '
      '${totalInvested.toCurrency()}',
    );

    debugPrint(
      'TOTAL INTEREST: '
      '${(balance - totalInvested).toCurrency()}',
    );

    debugPrint('============================================================');
  }

  void _debugRetirementPlanner() {
    Get.put<RiskToleranceController>(RiskToleranceController());
    final riskToleranceController = Get.find<RiskToleranceController>();

    final profile = riskToleranceController.investorProfile.value;
    if (profile == null) {
      debugPrint('Investor profile is incomplete.');
      return;
    }
    // Get profile-specific portfolio returns.
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

    // ============================================================
    // INPUTS
    // ============================================================

    const retirementAge = 60;
    const fundLastUntilAge = 80;

    final birthday = DateTime(1997, 12, 6);
    final now = DateTime.now();
    final planDate = DateTime(now.year, now.month, now.day);

    const annualLifestyle = 240000.00;

    const inflationRate = 0.041;

    const currentSavings = 1000000.00;

    // Current retirement savings plan
    const monthlyBudget = 15000.00;
    const yearsOfSaving = 15.0;
    const savingsFrequency = BillsFrequency.monthly;

    // ============================================================
    // RETIREMENT DATES
    // ============================================================

    final retirementDate = RetirementPlannerEngine.calculateRetirementDate(
      birthday: birthday,
      retirementAge: retirementAge,
    );

    final yearsToRetirement =
        RetirementPlannerEngine.calculateYearsToRetirement(
          planDate: planDate,
          retirementDate: retirementDate,
        );
    final accumulationReturn = calculateAccumulationReturn(
      yearsToRetirement: yearsToRetirement,
      shortReturn: shortReturn,
      mediumReturn: mediumReturn,
      longReturn: longReturn,
    );

    // ============================================================
    // LIFESTYLE AT RETIREMENT
    // ============================================================

    final retirementAnnualLifestyle =
        RetirementPlannerEngine.calculateFutureAnnualLifestyle(
          annualLifestyle: annualLifestyle,
          inflationRate: inflationRate,
          yearsToRetirement: yearsToRetirement,
        );

    final retirementMonthlyLifestyle =
        RetirementPlannerEngine.calculateFutureMonthlyLifestyle(
          monthlyLifestyle: annualLifestyle / 12,
          inflationRate: inflationRate,
          yearsToRetirement: yearsToRetirement,
        );
    _debugRetirementHorizonReturns(
      retirementDate: retirementDate,
      retirementAge: retirementAge,
      fundLastUntilAge: fundLastUntilAge,
      firstYearWithdrawal: retirementAnnualLifestyle,
      inflationRate: inflationRate,
      shortReturn: shortReturn,
      mediumReturn: mediumReturn,
      longReturn: longReturn,
    );

    // ============================================================
    // RETIREMENT FUND NEED
    // ============================================================

    // final realRetirementReturn =
    //     RetirementPlannerEngine.calculateRealRetirementReturn(
    //       retirementReturn: retirementReturn,
    //       inflationRate: inflationRate,
    //     );

    final withdrawalCount =
        RetirementPlannerEngine.calculateRetirementWithdrawalCount(
          retirementAge: retirementAge,
          fundLastUntilAge: fundLastUntilAge,
        );
    final retirementFundNeed = calculateRequiredRetirementFund(
      retirementDate: retirementDate,
      retirementAge: retirementAge,
      fundLastUntilAge: fundLastUntilAge,
      firstYearWithdrawal: retirementAnnualLifestyle,
      inflationRate: inflationRate,
      shortReturn: shortReturn,
      mediumReturn: mediumReturn,
      longReturn: longReturn,
    );

    // ============================================================
    // INVESTMENT REQUIREMENTS
    // ============================================================

    final requiredLumpSum = RetirementPlannerEngine.calculateRequiredLumpSum(
      retirementFundNeed: retirementFundNeed,
      accumulationReturn: accumulationReturn,
      yearsToRetirement: yearsToRetirement,
    );

    // final requiredMonthlyContribution =
    //     RetirementPlannerEngine.calculateRequiredContribution(
    //       retirementFundNeed: retirementFundNeed,
    //       currentSavings: currentSavings,
    //       planDate: planDate,
    //       retirementDate: retirementDate,
    //       frequency: BillsFrequency.monthly,
    //       shortReturn: shortReturn,
    //       mediumReturn: mediumReturn,
    //       longReturn: longReturn,
    //     );

    final futureAnnualLifestyle =
        RetirementPlannerEngine.calculateFutureAnnualLifestyle(
          annualLifestyle: annualLifestyle,
          inflationRate: inflationRate,
          yearsToRetirement: yearsToRetirement,
        );
    // _debugAccumulationProjection(
    //   currentAge:
    //       now.year -
    //       birthday.year -
    //       ((now.month < birthday.month ||
    //               (now.month == birthday.month && now.day < birthday.day))
    //           ? 1
    //           : 0),

    //   planDate: planDate,
    //   retirementDate: retirementDate,

    //   retirementAge: retirementAge,
    //   fundLastUntilAge: fundLastUntilAge,
    //   firstYearWithdrawal: futureAnnualLifestyle,
    //   inflationRate: inflationRate,

    //   currentSavings: currentSavings,
    //   contribution: requiredMonthlyContribution,
    //   frequency: BillsFrequency.monthly,

    //   shortReturn: shortReturn,
    //   mediumReturn: mediumReturn,
    //   longReturn: longReturn,
    // );
    // // final projectedWithRequiredContribution =
    //     RetirementPlannerEngine.calculateAccumulationProjection(
    //       currentSavings: currentSavings,
    //       contribution: requiredMonthlyContribution,
    //       planDate: planDate,
    //       retirementDate: retirementDate,
    //       retirementAge: retirementAge,
    //       fundLastUntilAge: fundLastUntilAge,
    //       firstYearWithdrawal: retirementAnnualLifestyle,
    //       inflationRate: inflationRate,
    //       frequency: BillsFrequency.monthly,
    //       shortReturn: shortReturn,
    //       mediumReturn: mediumReturn,
    //       longReturn: longReturn,
    //     );
    debugPrint('');
    debugPrint(
      '-------------------- ACCUMULATION VALIDATION --------------------',
    );

    debugPrint(
      'Required retirement fund:       '
      '${retirementFundNeed.toCurrency()}',
    );

    // debugPrint(
    //   'Required monthly contribution:  '
    //   '${requiredMonthlyContribution.toCurrency()}',
    // );

    // debugPrint(
    //   'Projected retirement balance:   '
    //   '${projectedWithRequiredContribution.toCurrency()}',
    // );

    // debugPrint(
    //   'Accumulation difference:        '
    //   '${(projectedWithRequiredContribution - retirementFundNeed).toCurrency()}',
    // );
    // final requiredQuarterlyContribution =
    //     RetirementPlannerEngine.calculateRequiredContribution(
    //       retirementFundNeed: retirementFundNeed,
    //       currentSavings: currentSavings,
    //       planDate: planDate,
    //       retirementDate: retirementDate,
    //       frequency: BillsFrequency.quarterly,
    //       shortReturn: shortReturn,
    //       mediumReturn: mediumReturn,
    //       longReturn: longReturn,
    //     );
    // final requiredSemiAnnualContribution =
    //     RetirementPlannerEngine.calculateRequiredContribution(
    //       retirementFundNeed: retirementFundNeed,
    //       currentSavings: currentSavings,
    //       planDate: planDate,
    //       retirementDate: retirementDate,
    //       frequency: BillsFrequency.semiAnnual,
    //       shortReturn: shortReturn,
    //       mediumReturn: mediumReturn,
    //       longReturn: longReturn,
    //     );

    // final requiredAnnualContribution =
    //     RetirementPlannerEngine.calculateRequiredContribution(
    //       retirementFundNeed: retirementFundNeed,
    //       currentSavings: currentSavings,
    //       planDate: planDate,
    //       retirementDate: retirementDate,
    //       frequency: BillsFrequency.annual,
    //       shortReturn: shortReturn,
    //       mediumReturn: mediumReturn,
    //       longReturn: longReturn,
    //     );
    // // ============================================================
    // CURRENT SAVINGS — NO FUTURE CONTRIBUTIONS
    // ============================================================

    final projectedCurrentSavings =
        RetirementPlannerEngine.calculateProjectedRetirementSavings(
          currentSavings: currentSavings,
          annualReturn: accumulationReturn,
          yearsToRetirement: yearsToRetirement,
        );

    final currentSavingsSurplusDeficit =
        RetirementPlannerEngine.calculateRetirementSurplusDeficit(
          projectedRetirementSavings: projectedCurrentSavings,
          retirementFundNeed: retirementFundNeed,
        );

    // ============================================================
    // CURRENT SAVINGS + CONTRIBUTION PLAN
    // ============================================================

    final retirementValueFromSavingsPlan =
        RetirementPlannerEngine.calculateRetirementValueFromSavingsPlan(
          currentSavings: currentSavings,
          contribution: monthlyBudget,
          annualReturn: accumulationReturn,
          yearsOfSaving: yearsOfSaving,
          yearsToRetirement: yearsToRetirement,
          frequency: savingsFrequency,
        );

    final savingsPlanSurplusDeficit =
        RetirementPlannerEngine.calculateRetirementSurplusDeficit(
          projectedRetirementSavings: retirementValueFromSavingsPlan,
          retirementFundNeed: retirementFundNeed,
        );
    final retirementProjection = calculateRetirementProjection(
      retirementFund: retirementFundNeed,
      retirementDate: retirementDate,
      retirementAge: retirementAge,
      fundLastUntilAge: fundLastUntilAge,
      firstYearWithdrawal: retirementAnnualLifestyle,
      inflationRate: inflationRate,
      shortReturn: shortReturn,
      mediumReturn: mediumReturn,
      longReturn: longReturn,
    );

    // ============================================================
    // DEBUG OUTPUT
    // ============================================================
    debugPrint('');
    debugPrint('============================================================');
    debugPrint('              RETIREMENT PROJECTION');
    debugPrint('============================================================');

    for (final row in retirementProjection) {
      debugPrint('');
      debugPrint('-------------------- AGE ${row.age} --------------------');

      debugPrint(
        'Beginning balance: '
        '${row.beginningBalance.toCurrency()}',
      );

      debugPrint(
        'Withdrawal:        '
        '${row.withdrawal.toCurrency()}',
      );

      debugPrint(
        'Remaining balance: '
        '${row.remainingBalance.toCurrency()}',
      );

      debugPrint(
        'Short weight:      '
        '${(row.shortWeight * 100).toStringAsFixed(2)}%',
      );

      debugPrint(
        'Medium weight:     '
        '${(row.mediumWeight * 100).toStringAsFixed(2)}%',
      );

      debugPrint(
        'Long weight:       '
        '${(row.longWeight * 100).toStringAsFixed(2)}%',
      );

      debugPrint(
        'Return:            '
        '${(row.returnRate * 100).toStringAsFixed(2)}%',
      );

      debugPrint(
        'Interest earned:   '
        '${row.interestEarned.toCurrency()}',
      );

      debugPrint(
        'End balance:       '
        '${row.endBalance.toCurrency()}',
      );
    }

    debugPrint('');
    debugPrint(
      'FINAL BALANCE: '
      '${retirementProjection.last.endBalance.toCurrency()}',
    );

    debugPrint('============================================================');
    debugPrint('');
    debugPrint('============================================================');
    debugPrint('                 RETIREMENT PLANNER DEBUG');
    debugPrint('============================================================');

    // ------------------------------------------------------------
    // PLAN
    // ------------------------------------------------------------

    debugPrint('');
    debugPrint('-------------------- PLAN --------------------');

    debugPrint('Plan date:              $planDate');
    debugPrint('Birthday:               $birthday');
    debugPrint('Retirement age:         $retirementAge');
    debugPrint('Retirement date:        $retirementDate');

    debugPrint(
      'Years to retirement:    '
      '${yearsToRetirement.toStringAsFixed(4)}',
    );

    // ------------------------------------------------------------
    // ASSUMPTIONS
    // ------------------------------------------------------------

    debugPrint('');
    debugPrint('-------------------- ASSUMPTIONS --------------------');

    debugPrint(
      'Inflation rate:         '
      '${(inflationRate * 100).toStringAsFixed(2)}%',
    );

    debugPrint(
      'Accumulation return:    '
      '${(accumulationReturn * 100).toStringAsFixed(2)}%',
    );

    debugPrint(
      'Fund lasts until age:   '
      '$fundLastUntilAge',
    );

    // ------------------------------------------------------------
    // LIFESTYLE
    // ------------------------------------------------------------

    debugPrint('');
    debugPrint('-------------------- LIFESTYLE --------------------');

    debugPrint(
      'Annual lifestyle today: '
      '${annualLifestyle.toCurrency()}',
    );

    debugPrint(
      'Monthly lifestyle today: '
      '${(annualLifestyle / 12).toCurrency()}',
    );

    debugPrint(
      'Annual lifestyle @ $retirementAge: '
      '${retirementAnnualLifestyle.toCurrency()}',
    );

    debugPrint(
      'Monthly lifestyle @ $retirementAge: '
      '${retirementMonthlyLifestyle.toCurrency()}',
    );

    // ------------------------------------------------------------
    // RETIREMENT FUND
    // ------------------------------------------------------------

    debugPrint('');
    debugPrint('-------------------- RETIREMENT FUND --------------------');

    debugPrint(
      'Withdrawal count:      '
      '$withdrawalCount',
    );

    debugPrint(
      'Retirement fund need:  '
      '${retirementFundNeed.toCurrency()}',
    );

    // ------------------------------------------------------------
    // INVESTMENT REQUIREMENTS
    // ------------------------------------------------------------

    debugPrint('');
    debugPrint(
      '-------------------- INVESTMENT REQUIREMENTS --------------------',
    );

    debugPrint(
      'Required lump sum:     '
      '${requiredLumpSum.toCurrency()}',
    );

    // debugPrint(
    //   'Required monthly:      '
    //   '${requiredMonthlyContribution.toCurrency()}',
    // );

    // debugPrint(
    //   'Required quarterly:    '
    //   '${requiredQuarterlyContribution.toCurrency()}',
    // );

    // debugPrint(
    //   'Required semi-annual:  '
    //   '${requiredSemiAnnualContribution.toCurrency()}',
    // );

    // debugPrint(
    //   'Required annual:       '
    //   '${requiredAnnualContribution.toCurrency()}',
    // );

    // ------------------------------------------------------------
    // CURRENT SAVINGS
    // ------------------------------------------------------------

    debugPrint('');
    debugPrint('-------------------- CURRENT SAVINGS --------------------');

    debugPrint(
      'Current savings:       '
      '${currentSavings.toCurrency()}',
    );

    debugPrint(
      'Projected @ $retirementAge '
      '(savings only): '
      '${projectedCurrentSavings.toCurrency()}',
    );

    debugPrint(
      'Surplus / deficit:     '
      '${currentSavingsSurplusDeficit.toCurrency()}',
    );

    // ------------------------------------------------------------
    // SAVINGS PLAN
    // ------------------------------------------------------------

    debugPrint('');
    debugPrint('-------------------- SAVINGS PLAN --------------------');

    debugPrint(
      'Contribution amount:   '
      '${monthlyBudget.toCurrency()}',
    );

    debugPrint(
      'Contribution frequency:'
      ' ${savingsFrequency.label}',
    );

    debugPrint(
      'Years of saving:       '
      '${yearsOfSaving.toStringAsFixed(2)}',
    );

    debugPrint(
      'Projected @ $retirementAge '
      '(with savings plan): '
      '${retirementValueFromSavingsPlan.toCurrency()}',
    );

    debugPrint(
      'Surplus / deficit:     '
      '${savingsPlanSurplusDeficit.toCurrency()}',
    );

    // ------------------------------------------------------------
    // COMPARISON
    // ------------------------------------------------------------

    debugPrint('');
    debugPrint('-------------------- COMPARISON --------------------');

    debugPrint(
      'Additional value from contributions: '
      '${(retirementValueFromSavingsPlan - projectedCurrentSavings).toCurrency()}',
    );

    debugPrint(
      'Fund need:                           '
      '${retirementFundNeed.toCurrency()}',
    );

    debugPrint(
      'Savings-only gap:                    '
      '${currentSavingsSurplusDeficit.toCurrency()}',
    );

    debugPrint(
      'Savings-plan gap:                    '
      '${savingsPlanSurplusDeficit.toCurrency()}',
    );

    debugPrint('');
    debugPrint('============================================================');
    debugPrint('                 END RETIREMENT DEBUG');
    debugPrint('============================================================');
    debugPrint('');
  }
}
