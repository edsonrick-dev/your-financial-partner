class FinancialMetricsCalculator {
  String? formatLifestyleCoverageDuration({
    required double netWorth,
    required double plannedAnnualBudget,
  }) {
    final months = calculateLifestyleCoverageMonths(
      netWorth: netWorth,
      plannedAnnualBudget: plannedAnnualBudget,
    );

    if (months == null) {
      return null;
    }

    return formatDuration(months);
  }

  double? calculateLifestyleCoverageMonths({
    required double netWorth,
    required double plannedAnnualBudget,
  }) {
    final ratio = calculateLifestyleCoverageRatio(
      netWorth: netWorth,
      plannedAnnualBudget: plannedAnnualBudget,
    );

    if (ratio == null) {
      return null;
    }

    return ratio * 12;
  }

  double? calculateLifestyleCoverageRatio({
    required double netWorth,
    required double plannedAnnualBudget,
  }) {
    if (plannedAnnualBudget <= 0) {
      return null;
    }

    return netWorth / plannedAnnualBudget;
  }

  double calculateWealthBuildingRate({
    required double annualIncome,
    required double annualExpenses,
    required double annualDebtRepayment,
  }) {
    if (annualIncome <= 0) return 0;

    final wealthBuildingAmount =
        annualIncome - annualExpenses - annualDebtRepayment;
    final ratio = ((wealthBuildingAmount / annualIncome) * 100);
    return ratio.clamp(0, 100);
  }

  double calculateDebtLoadRatio({
    required double annualDebtRepayment,
    required double annualIncome,
  }) {
    if (annualIncome <= 0) return 0;

    final ratio = (annualDebtRepayment / annualIncome) * 100;

    return ratio.clamp(0, 100);
  }

  double calculateEmergencyFundMonths({
    required double emergencyFund,
    required double plannedAnnualBudget,
  }) {
    if (emergencyFund <= 0 || plannedAnnualBudget <= 0) {
      return 0;
    }

    final monthlyBudget = plannedAnnualBudget / 12;

    return emergencyFund / monthlyBudget;
  }

  bool isOpportunityFundEnabled({required double emergencyFundMonths}) {
    return emergencyFundMonths >= 12;
  }

  double calculateOpportunityFundTarget({
    required double emergencyFundTarget,
    required double plannedAnnualBudget,
  }) {
    if (emergencyFundTarget <= 0 || plannedAnnualBudget <= 0) {
      return 0;
    }

    final totalLiquidityTarget = plannedAnnualBudget / 0.70;

    return (totalLiquidityTarget - emergencyFundTarget).clamp(
      0,
      double.infinity,
    );
  }

  String formatDuration(double months) {
    if (months <= 0) {
      return '0 months';
    }

    const daysPerMonth = 365 / 12;

    final wholeMonths = months.floor();
    final years = wholeMonths ~/ 12;
    final remainingMonths = wholeMonths % 12;

    final remainingFraction = months - wholeMonths;
    var days = (remainingFraction * daysPerMonth).round();

    // Prevent outputs like "11 months and 30 days".
    var displayMonths = remainingMonths;
    var displayYears = years;

    if (days >= 30) {
      days = 0;
      displayMonths++;

      if (displayMonths >= 12) {
        displayMonths = 0;
        displayYears++;
      }
    }

    final parts = <String>[];

    if (displayYears > 0) {
      parts.add('$displayYears ${displayYears == 1 ? 'year' : 'years'}');
    }

    if (displayMonths > 0) {
      parts.add('$displayMonths ${displayMonths == 1 ? 'month' : 'months'}');
    }

    if (days > 0) {
      parts.add('$days ${days == 1 ? 'day' : 'days'}');
    }

    if (parts.length == 1) {
      return parts.first;
    }

    if (parts.length == 2) {
      return '${parts[0]} and ${parts[1]}';
    }

    return '${parts[0]}, ${parts[1]}, and ${parts[2]}';
  }
}
