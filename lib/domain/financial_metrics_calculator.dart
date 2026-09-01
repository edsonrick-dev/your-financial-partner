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

  double? calculateEmergencyFundMonths({
    required double emergencyFund,
    required double plannedAnnualBudget,
  }) {
    if (plannedAnnualBudget <= 0) {
      return null;
    }

    if (emergencyFund <= 0) {
      return 0;
    }

    final monthlyBudget = plannedAnnualBudget / 12;

    return emergencyFund / monthlyBudget;
  }

  bool isOpportunityFundEnabled({required double? emergencyFundMonths}) {
    return emergencyFundMonths != null && emergencyFundMonths >= 12;
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

  double? calculateEmergencyFundRatio({
    required double liquidFunds,
    required double plannedAnnualBudget,
  }) {
    if (liquidFunds <= 0 || plannedAnnualBudget <= 0) {
      return 0;
    }

    final requiredLiquidity = plannedAnnualBudget / 0.70;

    return (liquidFunds / requiredLiquidity) * 100;
  }

  String? formatEmergencyFundDuration({
    required double emergencyFund,
    required double plannedAnnualBudget,
  }) {
    final months = calculateEmergencyFundMonths(
      emergencyFund: emergencyFund,
      plannedAnnualBudget: plannedAnnualBudget,
    );

    if (months == null) {
      return null;
    }

    return formatDuration(months);
  }

  String formatDuration(double months) {
    if (months <= 0) {
      return '0 months';
    }

    const daysPerMonth = 365 / 12;

    final wholeMonths = months.floor();
    final fractionalMonths = months - wholeMonths;

    final days = (fractionalMonths * daysPerMonth).round();

    // Less than 1 month → days only
    if (wholeMonths == 0) {
      return '$days ${days == 1 ? 'day' : 'days'}';
    }

    // Less than 1 year → months + days
    if (wholeMonths < 12) {
      final parts = <String>[
        '$wholeMonths ${wholeMonths == 1 ? 'month' : 'months'}',
      ];

      if (days > 0) {
        parts.add('$days ${days == 1 ? 'day' : 'days'}');
      }

      if (parts.length == 1) {
        return parts.first;
      }

      return '${parts[0]} and ${parts[1]}';
    }

    // 1 year or more → years + months, no days
    final years = wholeMonths ~/ 12;
    final remainingMonths = wholeMonths % 12;

    final parts = <String>['$years ${years == 1 ? 'year' : 'years'}'];

    if (remainingMonths > 0) {
      parts.add(
        '$remainingMonths '
        '${remainingMonths == 1 ? 'month' : 'months'}',
      );
    }

    if (parts.length == 1) {
      return parts.first;
    }

    return '${parts[0]} and ${parts[1]}';
  }
}
