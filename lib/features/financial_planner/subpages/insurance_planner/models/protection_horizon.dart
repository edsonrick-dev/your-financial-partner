import 'dart:math' as math;

enum ProtectionHorizon {
  zero(0, 'Choose No Ongoing Support'),
  one(1, 'Choose 1 Year of Support'),
  two(2, 'Choose 2 Years of Support'),
  three(3, 'Choose 3 Years of Support'),
  five(5, 'Choose 5 Years of Support'),
  ten(10, 'Choose 10 Years of Support'),
  fifteen(15, 'Choose 15 Years of Support'),
  twenty(20, 'Choose 20 Years of Support'),
  untilRetirement(null, 'Choose Support Until Retirement');

  final int? years;
  final String actionLabel;

  const ProtectionHorizon(this.years, this.actionLabel);
}

extension ProtectionHorizonX on ProtectionHorizon {
  bool get isUntilRetirement => this == ProtectionHorizon.untilRetirement;

  int resolveYears({required int currentAge, required int retirementAge}) {
    if (isUntilRetirement) {
      return math.max(0, retirementAge - currentAge);
    }

    return years!;
  }

  String get horizonLabel => switch (this) {
    ProtectionHorizon.zero => 'No ongoing support',
    ProtectionHorizon.one => '1 year',
    ProtectionHorizon.two => '2 years',
    ProtectionHorizon.three => '3 years',
    ProtectionHorizon.five => '5 years',
    ProtectionHorizon.ten => '10 years',
    ProtectionHorizon.fifteen => '15 years',
    ProtectionHorizon.twenty => '20 years',
    ProtectionHorizon.untilRetirement => 'Until retirement',
  };
}
