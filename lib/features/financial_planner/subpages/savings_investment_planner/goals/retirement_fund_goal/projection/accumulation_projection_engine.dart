class AccumulationProjection {
  final int age;
  final DateTime date;
  final double beginningBalance;
  final double contributions;
  final double returnRate;
  final double interestEarned;
  final double endingBalance;

  const AccumulationProjection({
    required this.age,
    required this.date,
    required this.beginningBalance,
    required this.contributions,
    required this.returnRate,
    required this.interestEarned,
    required this.endingBalance,
  });
}
