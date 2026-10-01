class RetirementGlidePath {
  final List<GlidePathPoint> points;

  const RetirementGlidePath({required this.points});
}

class GlidePathPoint {
  final int yearsToRetirement;
  final double expectedReturn;

  const GlidePathPoint({
    required this.yearsToRetirement,
    required this.expectedReturn,
  });
}
