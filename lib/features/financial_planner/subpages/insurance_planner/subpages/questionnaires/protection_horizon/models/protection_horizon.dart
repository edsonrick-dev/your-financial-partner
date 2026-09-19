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
