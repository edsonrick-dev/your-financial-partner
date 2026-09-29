class RiskReturnRange {
  final double average;
  final double standardDeviation;

  const RiskReturnRange({
    required this.average,
    required this.standardDeviation,
  });

  double get bestCase => average + standardDeviation;

  double get worstCase => average - standardDeviation;
}
