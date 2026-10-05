class EmergencyFundCalculator {
  const EmergencyFundCalculator({
    required this.currentAmount,
    required this.monthlyBudget,
    required this.netMonthlyCashFlow,
  });

  final double currentAmount;
  final double monthlyBudget;
  final double netMonthlyCashFlow;

  static const double firstMilestoneMonths = 3.0;
  static const double secondMilestoneMonths = 6.0;
  static const double targetMonths = 12.0;

  double get currentMonths {
    if (monthlyBudget <= 0) return 0;
    return currentAmount / monthlyBudget;
  }

  double get targetAmount {
    return monthlyBudget * targetMonths;
  }

  double get emergencyFundRate {
    if (currentMonths < 3) return 1.0;
    if (currentMonths < 6) return 0.75;
    if (currentMonths < 12) return 0.50;
    return 0.0;
  }

  double get otherGoalsRate {
    if (currentMonths < 3) return 0.0;
    if (currentMonths < 6) return 0.25;
    if (currentMonths < 12) return 0.50;
    return 0.95;
  }

  double get opportunityFundRate {
    return currentMonths >= 12 ? 0.05 : 0.0;
  }

  double get monthlyEmergencyFundContribution {
    if (netMonthlyCashFlow <= 0) return 0;
    return netMonthlyCashFlow * emergencyFundRate;
  }

  double get monthlyOtherGoalsContribution {
    if (netMonthlyCashFlow <= 0) return 0;
    return netMonthlyCashFlow * otherGoalsRate;
  }

  double get monthlyOpportunityFundContribution {
    if (netMonthlyCashFlow <= 0) return 0;
    return netMonthlyCashFlow * opportunityFundRate;
  }

  String get currentStage {
    if (currentMonths < 3) return 'Less than 3 mo.';
    if (currentMonths < 6) return '3 – 6 mo.';
    if (currentMonths < 12) return '6 – 12 mo.';
    return '12 mo. and beyond';
  }

  double? get nextMilestoneMonths {
    if (currentMonths < firstMilestoneMonths) {
      return firstMilestoneMonths;
    }

    if (currentMonths < secondMilestoneMonths) {
      return secondMilestoneMonths;
    }

    if (currentMonths < targetMonths) {
      return targetMonths;
    }

    return null;
  }

  double? get nextMilestoneAmount {
    final milestone = nextMilestoneMonths;

    if (milestone == null) return null;

    return monthlyBudget * milestone;
  }

  double? get remainingToNextMilestone {
    final target = nextMilestoneAmount;

    if (target == null) return null;

    return (target - currentAmount).clamp(0.0, double.infinity);
  }

  double? get monthsToNextMilestone {
    final remaining = remainingToNextMilestone;
    final contribution = monthlyEmergencyFundContribution;

    if (remaining == null) return null;
    if (remaining <= 0) return 0;
    if (contribution <= 0) return null;

    return remaining / contribution;
  }

  double? get monthsToTarget {
    final remaining = targetAmount - currentAmount;

    if (remaining <= 0) return 0;
    if (monthlyEmergencyFundContribution <= 0) return null;

    return remaining / monthlyEmergencyFundContribution;
  }

  double get remainingToTarget {
    return (targetAmount - currentAmount).clamp(0.0, double.infinity);
  }
}
