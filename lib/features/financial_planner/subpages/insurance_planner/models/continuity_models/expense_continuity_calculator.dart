import 'dart:math' as math;

import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_result.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_year.dart';

class ExpenseContinuityCalculator {
  ExpenseContinuityResult calculate({
    required double monthlyExpense,
    required int planValidityYears,
    required int supportYears,
    required double inflationRate,
    required double portfolioReturn,
  }) {
    final startingMonthlyExpense =
        monthlyExpense * math.pow(1 + inflationRate, planValidityYears);

    var uninvestedNeed = 0.0;
    var investedNeed = 0.0;

    final withdrawals = <double>[];

    // ------------------------------------------------------------
    // Determine the withdrawal required for each support year.
    // Support Year 1 = Year 6 in a 5-year plan.
    // ------------------------------------------------------------

    for (var year = 0; year < supportYears; year++) {
      final monthlyExpenseForYear =
          startingMonthlyExpense * math.pow(1 + inflationRate, year);

      final annualExpense = monthlyExpenseForYear * 12;

      withdrawals.add(annualExpense.toDouble());

      // No investment scenario.
      uninvestedNeed += annualExpense;
    }

    // ------------------------------------------------------------
    // Determine the initial lump sum required if invested.
    //
    // First withdrawal happens immediately at the beginning
    // of Support Year 1.
    // ------------------------------------------------------------

    for (var year = 0; year < supportYears; year++) {
      investedNeed += withdrawals[year] / math.pow(1 + portfolioReturn, year);
    }

    // ------------------------------------------------------------
    // Simulate the invested fund.
    // ------------------------------------------------------------

    var balance = investedNeed;

    final projection = <ExpenseContinuityYear>[];

    for (var year = 0; year < supportYears; year++) {
      final beginningBalance = balance;

      final withdrawal = withdrawals[year];

      final balanceAfterWithdrawal = beginningBalance - withdrawal;

      final investmentGrowth = balanceAfterWithdrawal * portfolioReturn;

      final endingBalance = balanceAfterWithdrawal + investmentGrowth;

      balance = endingBalance;

      projection.add(
        ExpenseContinuityYear(
          year: year + 1,
          withdrawal: withdrawal,
          investedBeginningBalance: beginningBalance,
          investmentGrowth: investmentGrowth,
          investedEndingBalance: endingBalance,
        ),
      );
    }

    return ExpenseContinuityResult(
      uninvestedNeed: uninvestedNeed,
      investedNeed: investedNeed,
      projection: projection,
    );
  }
}
