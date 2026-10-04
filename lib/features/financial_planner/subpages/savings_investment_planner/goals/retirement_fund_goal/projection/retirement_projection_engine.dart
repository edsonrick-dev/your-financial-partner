import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/portfolio_horizon_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/risk_return/retirement_horizon_returns.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/risk_return/risk_return_range_model.dart';

class RetirementProjection {
  final int age;
  final DateTime date;

  final double beginningBalance;
  final double withdrawal;
  final double remainingBalance;

  final double shortWeight;
  final double mediumWeight;
  final double longWeight;

  final double returnRate;
  final double interestEarned;
  final double endBalance;

  const RetirementProjection({
    required this.age,
    required this.date,
    required this.beginningBalance,
    required this.withdrawal,
    required this.remainingBalance,
    required this.shortWeight,
    required this.mediumWeight,
    required this.longWeight,
    required this.returnRate,
    required this.interestEarned,
    required this.endBalance,
  });
}

List<RetirementProjection> calculateRetirementProjection({
  required double retirementFund,
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

  final returns = RetirementHorizonReturns(
    short: shortReturn,
    medium: mediumReturn,
    long: longReturn,
  );

  final projections = <RetirementProjection>[];

  var balance = retirementFund;

  for (var i = 0; i < withdrawals.length; i++) {
    final currentWithdrawal = withdrawals[i];

    final beginningBalance = balance;

    final withdrawalAmount = currentWithdrawal.amount;

    final remainingBalance = (beginningBalance - withdrawalAmount).clamp(
      0.0,
      double.infinity,
    );

    /*
     * Everything from this withdrawal onward is considered
     * when determining the portfolio's current risk horizon.
     */
    final futureWithdrawals = withdrawals.sublist(i);

    final weights = RetirementHorizonReturns.calculateHorizonWeights(
      currentDate: currentWithdrawal.date,
      futureWithdrawals: futureWithdrawals,
    );

    final returnRate =
        RetirementHorizonReturns.calculateBlendedRetirementReturn(
          weights: weights,
          returns: returns,
        );

    final interestEarned = remainingBalance * returnRate;

    final endBalance = remainingBalance + interestEarned;

    projections.add(
      RetirementProjection(
        age: retirementAge + i,
        date: currentWithdrawal.date,
        beginningBalance: beginningBalance,
        withdrawal: withdrawalAmount,
        remainingBalance: remainingBalance,
        shortWeight: weights[PortfolioHorizon.short]!,
        mediumWeight: weights[PortfolioHorizon.medium]!,
        longWeight: weights[PortfolioHorizon.long]!,
        returnRate: returnRate,
        interestEarned: interestEarned,
        endBalance: endBalance,
      ),
    );

    balance = endBalance;
  }

  return projections;
}

List<RetirementWithdrawal> buildRetirementWithdrawals({
  required DateTime retirementDate,
  required int retirementAge,
  required int fundLastUntilAge,
  required double firstYearWithdrawal,
  required double inflationRate,
}) {
  final withdrawals = <RetirementWithdrawal>[];

  var withdrawal = firstYearWithdrawal;

  for (var age = retirementAge; age <= fundLastUntilAge; age++) {
    final date = DateTime(
      retirementDate.year + (age - retirementAge),
      retirementDate.month,
      retirementDate.day,
    );

    withdrawals.add(RetirementWithdrawal(date: date, amount: withdrawal));

    withdrawal *= 1 + inflationRate;
  }

  return withdrawals;
}

double calculateRequiredRetirementFund({
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

  var retirementFund = 0.0;
  var discountFactor = 1.0;

  for (var i = 0; i < withdrawals.length; i++) {
    final currentWithdrawal = withdrawals[i];

    // The first retirement withdrawal occurs immediately.
    retirementFund += currentWithdrawal.amount / discountFactor;

    if (i == withdrawals.length - 1) {
      break;
    }

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

    discountFactor *= 1 + blendedReturn;
  }

  return retirementFund;
}
