enum BudgetPeriod { weekly, fortnightly, monthly, yearly }

// Weekly
// → amount repeats every 7 days
// Fortnightly
// → amount repeats every 14 days
// Monthly
// → amount repeats every calendar month
// Yearly
// → amount represents the total for the calendar year

// | Period        |           Example | Annual projection |
// | ------------- | ----------------: | ----------------: |
// | Weekly        |      ₱20,000/week |        ₱1,040,000 |
// | Fortnightly   |   ₱20,000/14 days |          ₱520,000 |
// | Monthly       |     ₱40,000/month |          ₱480,000 |
// | Yearly        |     ₱480,000/year |          ₱480,000 |
extension BudgetPeriodExtension on BudgetPeriod {
  /// User-facing name of the budget period.
  String get label => switch (this) {
    BudgetPeriod.weekly => 'Weekly',
    BudgetPeriod.fortnightly => 'Fortnightly',
    BudgetPeriod.monthly => 'Monthly',
    BudgetPeriod.yearly => 'Yearly',
  };

  /// Short user-facing representation of the budget period.
  String get shortLabel => switch (this) {
    BudgetPeriod.weekly => 'Week',
    BudgetPeriod.fortnightly => '2 weeks',
    BudgetPeriod.monthly => 'Month',
    BudgetPeriod.yearly => 'Year',
  };

  /// Describes how the planned amount repeats over time.
  String get description => switch (this) {
    BudgetPeriod.weekly => 'Repeats every week',
    BudgetPeriod.fortnightly => 'Repeats every 14 days or 2 weeks',
    BudgetPeriod.monthly => 'Repeats every calendar month',
    BudgetPeriod.yearly => 'Total amount for the calendar year',
  };

  /// Number of times the base plan amount occurs within one calendar year.
  ///
  /// This is used when the plan uses an even distribution.
  ///
  /// Examples:
  /// - ₱20,000 weekly → ₱20,000 × 52
  /// - ₱20,000 fortnightly → ₱20,000 × 26
  /// - ₱40,000 monthly → ₱40,000 × 12
  /// - ₱480,000 yearly → ₱480,000 × 1
  int get occurrencesPerYear => switch (this) {
    BudgetPeriod.weekly => 52,
    BudgetPeriod.fortnightly => 26,
    BudgetPeriod.monthly => 12,
    BudgetPeriod.yearly => 1,
  };

  /// Number of times the complete custom allocation pattern repeats
  /// within one calendar year.
  ///
  /// A custom pattern may span multiple occurrences of the base period.
  ///
  /// Examples:
  /// - Weekly: 7 daily allocations form one week, repeated 52 times.
  /// - Fortnightly: 2 fortnightly allocations form a 4-week pattern,
  ///   repeated 13 times.
  /// - Monthly: 2 allocations represent the two occurrences within
  ///   each calendar month, repeated 12 times.
  /// - Yearly: 12 monthly allocations form the entire year, repeated once.
  int get customPatternsPerYear => switch (this) {
    BudgetPeriod.weekly => 52,
    BudgetPeriod.fortnightly => 13,
    BudgetPeriod.monthly => 12,
    BudgetPeriod.yearly => 1,
  };

  /// Number of allocation values required to fully customize the period.
  ///
  /// These allocations redistribute the plan's amount within its
  /// recurring period or custom pattern. They do not change the
  /// underlying budget period.
  ///
  /// Examples:
  /// - Weekly: 7 allocations for Monday through Sunday.
  /// - Fortnightly: 2 allocations for the first and second fortnight.
  /// - Monthly: 2 allocations for the first and second occurrence.
  /// - Yearly: 12 allocations for January through December.
  int get allocationCount => switch (this) {
    BudgetPeriod.weekly => 7,
    BudgetPeriod.fortnightly => 2,
    BudgetPeriod.monthly => 2,
    BudgetPeriod.yearly => 12,
  };
  int get customPatternLength => switch (this) {
    BudgetPeriod.weekly => 1,
    BudgetPeriod.fortnightly => 2,
    BudgetPeriod.monthly => 1,
    BudgetPeriod.yearly => 1,
  };

  /// Whether the budget period supports custom allocation.
  ///
  /// All currently supported budget periods can be customized.
  bool get supportsCustomization => true;

  /// Label used when describing the number of base-period occurrences
  /// used to calculate the annual projection.
  String get annualizationLabel => switch (this) {
    BudgetPeriod.weekly => 'Weeks',
    BudgetPeriod.fortnightly => 'Fortnights',
    BudgetPeriod.monthly => 'Months',
    BudgetPeriod.yearly => 'Year',
  };
}
