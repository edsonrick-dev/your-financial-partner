enum FinancialStabilityLevel { unstable, early, partial, good, excellent }

extension FinancialRatioTypeExtension on FinancialStabilityLevel {
  String get shortDescription {
    return 'The level of financial resilience you have today.';
  }
}
