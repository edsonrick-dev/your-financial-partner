enum CashFlowDistribution { defaultDistribution, custom }

extension CashFlowDistributionExtension on CashFlowDistribution {
  String get label => switch (this) {
    CashFlowDistribution.defaultDistribution => 'Even',
    CashFlowDistribution.custom => 'Custom',
  };

  String get description => switch (this) {
    CashFlowDistribution.defaultDistribution =>
      'Use the same amount for each period.',
    CashFlowDistribution.custom =>
      'Distribute the amount differently across periods.',
  };
}
