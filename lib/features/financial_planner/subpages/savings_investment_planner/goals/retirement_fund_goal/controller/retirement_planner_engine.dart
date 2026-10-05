import 'dart:math' as math;

import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/projection/accumulation_projection_engine.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/projection/retirement_projection_engine.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/portfolio_horizon_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/risk_return/retirement_horizon_returns.dart';

class RetirementPlannerEngine {
  // ============================================================
  // RETIREMENT TIMELINE
  // ============================================================

  static DateTime calculateRetirementDate({
    required DateTime birthday,
    required int retirementAge,
  }) {
    return DateTime(
      birthday.year + retirementAge,
      birthday.month,
      birthday.day,
    );
  }

  static double calculateYearsToRetirement({
    required DateTime planDate,
    required DateTime retirementDate,
  }) {
    return retirementDate.difference(planDate).inDays / 365.2425;
  }

  // ============================================================
  // LIFESTYLE
  // ============================================================

  static double calculateFutureAnnualLifestyle({
    required double annualLifestyle,
    required double inflationRate,
    required double yearsToRetirement,
  }) {
    return annualLifestyle * math.pow(1 + inflationRate, yearsToRetirement);
  }

  static double calculateFutureMonthlyLifestyle({
    required double monthlyLifestyle,
    required double inflationRate,
    required double yearsToRetirement,
  }) {
    final annualLifestyle = monthlyLifestyle * 12;

    final futureAnnualLifestyle = calculateFutureAnnualLifestyle(
      annualLifestyle: annualLifestyle,
      inflationRate: inflationRate,
      yearsToRetirement: yearsToRetirement,
    );

    return futureAnnualLifestyle / 12;
  }

  // ============================================================
  // RETIREMENT FUND
  // ============================================================

  static double calculateRealRetirementReturn({
    required double retirementReturn,
    required double inflationRate,
  }) {
    return (1 + retirementReturn) / (1 + inflationRate) - 1;
  }

  static int calculateRetirementWithdrawalCount({
    required int retirementAge,
    required int fundLastUntilAge,
  }) {
    return fundLastUntilAge - retirementAge + 1;
  }

  static double calculateRetirementFundNeed({
    required double retirementAnnualLifestyle,
    required double retirementReturn,
    required double inflationRate,
    required int retirementAge,
    required int fundLastUntilAge,
  }) {
    final realReturn = calculateRealRetirementReturn(
      retirementReturn: retirementReturn,
      inflationRate: inflationRate,
    );

    final withdrawalCount = calculateRetirementWithdrawalCount(
      retirementAge: retirementAge,
      fundLastUntilAge: fundLastUntilAge,
    );

    if (withdrawalCount <= 0) {
      return 0;
    }

    if (realReturn == 0) {
      return retirementAnnualLifestyle * withdrawalCount;
    }

    return retirementAnnualLifestyle *
        (1 - math.pow(1 + realReturn, -withdrawalCount)) /
        realReturn *
        (1 + realReturn);
  }

  // ============================================================
  // INVESTMENT REQUIREMENTS
  // ============================================================

  static double calculateRequiredLumpSum({
    required double retirementFundNeed,
    required double accumulationReturn,
    required double yearsToRetirement,
  }) {
    if (yearsToRetirement <= 0) {
      return retirementFundNeed;
    }

    return retirementFundNeed /
        math.pow(1 + accumulationReturn, yearsToRetirement);
  }

  static double calculatePeriodicReturn({
    required double annualReturn,
    required BillsFrequency frequency,
  }) {
    final periodsPerYear = frequency.investmentPeriodsPerYear;

    return math.pow(1 + annualReturn, 1 / periodsPerYear) - 1;
  }

  static double calculateAccumulationReturn({
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

  static double calculateAccumulationProjection({
    required DateTime birthday,
    required double currentSavings,
    required double contribution,
    required DateTime planDate,
    required DateTime retirementDate,
    required int retirementAge,
    required int fundLastUntilAge,
    required double firstYearWithdrawal,
    required double inflationRate,
    required BillsFrequency frequency,
    required double shortReturn,
    required double mediumReturn,
    required double longReturn,
  }) {
    final projections = buildAccumulationProjection(
      birthday: birthday,
      currentSavings: currentSavings,
      contribution: contribution,
      planDate: planDate,
      retirementDate: retirementDate,
      retirementAge: retirementAge,
      fundLastUntilAge: fundLastUntilAge,
      firstYearWithdrawal: firstYearWithdrawal,
      inflationRate: inflationRate,
      frequency: frequency,
      shortReturn: shortReturn,
      mediumReturn: mediumReturn,
      longReturn: longReturn,
    );

    if (projections.isEmpty) {
      return currentSavings;
    }

    return projections.last.endingBalance;
  }
  // static double calculateAccumulationProjection({
  //   required double currentSavings,
  //   required double contribution,
  //   required DateTime planDate,
  //   required DateTime retirementDate,
  //   required int retirementAge,
  //   required int fundLastUntilAge,
  //   required double firstYearWithdrawal,
  //   required double inflationRate,
  //   required BillsFrequency frequency,
  //   required double shortReturn,
  //   required double mediumReturn,
  //   required double longReturn,
  // }) {
  //   final yearsToRetirement =
  //       retirementDate.difference(planDate).inDays / 365.2425;

  //   if (yearsToRetirement <= 0) {
  //     return currentSavings;
  //   }

  //   final totalYears = yearsToRetirement.ceil();

  //   final periodsPerYear = frequency.investmentPeriodsPerYear;

  //   final withdrawals = buildRetirementWithdrawals(
  //     retirementDate: retirementDate,
  //     retirementAge: retirementAge,
  //     fundLastUntilAge: fundLastUntilAge,
  //     firstYearWithdrawal: firstYearWithdrawal,
  //     inflationRate: inflationRate,
  //   );

  //   final returns = RetirementHorizonReturns(
  //     short: shortReturn,
  //     medium: mediumReturn,
  //     long: longReturn,
  //   );

  //   var balance = currentSavings;

  //   for (var year = 0; year < totalYears; year++) {
  //     final accumulationDate = DateTime(
  //       planDate.year + year,
  //       planDate.month,
  //       planDate.day,
  //     );

  //     final weights = RetirementHorizonReturns.calculateHorizonWeights(
  //       currentDate: accumulationDate,
  //       futureWithdrawals: withdrawals,
  //     );

  //     final annualReturn =
  //         RetirementHorizonReturns.calculateBlendedRetirementReturn(
  //           weights: weights,
  //           returns: returns,
  //         );

  //     final periodicReturn = calculatePeriodicReturn(
  //       annualReturn: annualReturn,
  //       frequency: frequency,
  //     );

  //     for (var period = 0; period < periodsPerYear; period++) {
  //       final interest = balance * periodicReturn;

  //       balance += interest;
  //       balance += contribution;
  //     }
  //   }

  //   return balance;
  // }

  static List<AccumulationProjection> buildAccumulationProjection({
    required DateTime birthday,
    required double currentSavings,
    required double contribution,
    required DateTime planDate,
    required DateTime retirementDate,
    required int retirementAge,
    required int fundLastUntilAge,
    required double firstYearWithdrawal,
    required double inflationRate,
    required BillsFrequency frequency,
    required double shortReturn,
    required double mediumReturn,
    required double longReturn,
  }) {
    if (!retirementDate.isAfter(planDate)) {
      return [
        AccumulationProjection(
          age: retirementAge,
          date: retirementDate,
          beginningBalance: currentSavings,
          contributions: 0,
          returnRate: 0,
          interestEarned: 0,
          endingBalance: currentSavings,
        ),
      ];
    }

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

    var balance = currentSavings;
    var periodDate = planDate;

    final projections = <AccumulationProjection>[];

    var projectionYear = planDate.year;
    var beginningBalance = balance;
    var totalContributions = 0.0;
    var totalInterest = 0.0;
    var annualReturn = 0.0;

    while (periodDate.isBefore(retirementDate)) {
      final nextPeriodDate = switch (frequency) {
        BillsFrequency.monthly => DateTime(
          periodDate.year,
          periodDate.month + 1,
          periodDate.day,
        ),
        BillsFrequency.quarterly => DateTime(
          periodDate.year,
          periodDate.month + 3,
          periodDate.day,
        ),
        BillsFrequency.semiAnnual => DateTime(
          periodDate.year,
          periodDate.month + 6,
          periodDate.day,
        ),
        BillsFrequency.annual => DateTime(
          periodDate.year + 1,
          periodDate.month,
          periodDate.day,
        ),
        _ => throw UnsupportedError(
          '${frequency.label} is not supported for retirement contributions.',
        ),
      };

      final periodEnd = nextPeriodDate.isAfter(retirementDate)
          ? retirementDate
          : nextPeriodDate;

      // Determine the retirement-liability mix for this period.
      final weights = RetirementHorizonReturns.calculateHorizonWeights(
        currentDate: periodDate,
        futureWithdrawals: withdrawals,
      );

      annualReturn = RetirementHorizonReturns.calculateBlendedRetirementReturn(
        weights: weights,
        returns: returns,
      );

      final periodicReturn = calculatePeriodicReturn(
        annualReturn: annualReturn,
        frequency: frequency,
      );

      // Grow the existing balance.
      final interest = balance * periodicReturn;

      balance += interest;

      // Contribution is made at the end of the period.
      balance += contribution;

      totalInterest += interest;
      totalContributions += contribution;

      final isRetirement = periodEnd == retirementDate;
      final isYearEnd = periodEnd.year != projectionYear || isRetirement;

      if (isYearEnd) {
        final age =
            periodEnd.year -
            birthday.year -
            ((periodEnd.month < birthday.month ||
                    (periodEnd.month == birthday.month &&
                        periodEnd.day < birthday.day))
                ? 1
                : 0);

        projections.add(
          AccumulationProjection(
            age: isRetirement ? retirementAge : age,
            date: isRetirement
                ? retirementDate
                : DateTime(projectionYear, planDate.month, planDate.day),
            beginningBalance: beginningBalance,
            contributions: totalContributions,
            returnRate: annualReturn,
            interestEarned: totalInterest,
            endingBalance: balance,
          ),
        );

        if (!isRetirement) {
          projectionYear = periodEnd.year;
          beginningBalance = balance;
          totalContributions = 0.0;
          totalInterest = 0.0;
        }
      }

      periodDate = periodEnd;
    }

    return projections;
  }

  static double calculateRequiredContribution({
    required DateTime birthday,
    required double retirementFundNeed,
    required double currentSavings,
    required DateTime planDate,
    required DateTime retirementDate,
    required int retirementAge,
    required int fundLastUntilAge,
    required double firstYearWithdrawal,
    required double inflationRate,
    required BillsFrequency frequency,
    required double shortReturn,
    required double mediumReturn,
    required double longReturn,
  }) {
    // ------------------------------------------------------------
    // PROJECT RETIREMENT VALUE FOR A GIVEN CONTRIBUTION
    // ------------------------------------------------------------

    double project(double contribution) {
      return calculateAccumulationProjection(
        birthday: birthday,
        currentSavings: currentSavings,
        contribution: contribution,
        planDate: planDate,
        retirementDate: retirementDate,
        retirementAge: retirementAge,
        fundLastUntilAge: fundLastUntilAge,
        firstYearWithdrawal: firstYearWithdrawal,
        inflationRate: inflationRate,
        frequency: frequency,
        shortReturn: shortReturn,
        mediumReturn: mediumReturn,
        longReturn: longReturn,
      );
    }

    // ------------------------------------------------------------
    // ALREADY FUNDED
    // ------------------------------------------------------------

    if (project(0) >= retirementFundNeed) {
      return 0;
    }

    // ------------------------------------------------------------
    // SOLVE CONTRIBUTION USING BINARY SEARCH
    // ------------------------------------------------------------

    var low = 0.0;
    var high = retirementFundNeed;

    while (project(high) < retirementFundNeed) {
      high *= 2;
    }

    for (var i = 0; i < 100; i++) {
      final mid = (low + high) / 2;

      if (project(mid) < retirementFundNeed) {
        low = mid;
      } else {
        high = mid;
      }
    }

    return high;
  } // ============================================================
  // CURRENT SAVINGS
  // ============================================================

  static double calculateProjectedRetirementSavings({
    required double currentSavings,
    required double annualReturn,
    required double yearsToRetirement,
  }) {
    if (yearsToRetirement <= 0) {
      return currentSavings;
    }

    return currentSavings * math.pow(1 + annualReturn, yearsToRetirement);
  }

  static double calculateRetirementSurplusDeficit({
    required double projectedRetirementSavings,
    required double retirementFundNeed,
  }) {
    return projectedRetirementSavings - retirementFundNeed;
  }

  // ============================================================
  // SAVINGS PLAN
  // ============================================================

  static double calculateRetirementValueFromSavingsPlan({
    required double currentSavings,
    required double contribution,
    required double annualReturn,
    required double yearsOfSaving,
    required double yearsToRetirement,
    required BillsFrequency frequency,
  }) {
    if (yearsToRetirement <= 0) {
      return currentSavings;
    }

    final periodsPerYear = frequency.investmentPeriodsPerYear;

    final periodicReturn = calculatePeriodicReturn(
      annualReturn: annualReturn,
      frequency: frequency,
    );

    final retirementPeriods = yearsToRetirement * periodsPerYear;

    // Contributions cannot continue beyond retirement.
    final effectiveYearsOfSaving = math.min(yearsOfSaving, yearsToRetirement);

    final contributionPeriods = effectiveYearsOfSaving * periodsPerYear;

    // ----------------------------------------------------------
    // ZERO RETURN
    // ----------------------------------------------------------

    if (periodicReturn == 0) {
      return currentSavings + contribution * contributionPeriods;
    }

    // ----------------------------------------------------------
    // CURRENT SAVINGS
    // ----------------------------------------------------------

    final currentSavingsAtRetirement =
        currentSavings * math.pow(1 + periodicReturn, retirementPeriods);

    // ----------------------------------------------------------
    // CONTRIBUTIONS
    // ----------------------------------------------------------

    if (contribution == 0 || contributionPeriods <= 0) {
      return currentSavingsAtRetirement;
    }

    final contributionValueAtEnd =
        contribution *
        ((math.pow(1 + periodicReturn, contributionPeriods) - 1) /
            periodicReturn) *
        (1 + periodicReturn);

    // ----------------------------------------------------------
    // GROW CONTRIBUTIONS AFTER SAVING STOPS
    // ----------------------------------------------------------

    final remainingPeriods = retirementPeriods - contributionPeriods;

    final contributionValueAtRetirement =
        contributionValueAtEnd * math.pow(1 + periodicReturn, remainingPeriods);

    return currentSavingsAtRetirement + contributionValueAtRetirement;
  }
}

class RetirementProjectionPeriod {
  final DateTime startDate;
  final DateTime endDate;
  final int age;
  final double years;

  const RetirementProjectionPeriod({
    required this.startDate,
    required this.endDate,
    required this.age,
    required this.years,
  });
}

extension BillsFrequencyInvestmentExtension on BillsFrequency {
  int get investmentPeriodsPerYear {
    switch (this) {
      case BillsFrequency.monthly:
        return 12;

      case BillsFrequency.quarterly:
        return 4;

      case BillsFrequency.semiAnnual:
        return 2;

      case BillsFrequency.annual:
        return 1;

      default:
        throw UnsupportedError(
          '$label is not supported for retirement contributions.',
        );
    }
  }

  bool get canBeInvestmentContribution {
    switch (this) {
      case BillsFrequency.monthly:
      case BillsFrequency.quarterly:
      case BillsFrequency.semiAnnual:
      case BillsFrequency.annual:
        return true;

      default:
        return false;
    }
  }
}
