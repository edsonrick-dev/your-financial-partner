enum BudgetPeriod { weekly, fortnightly, twiceAMonth, monthly, yearly }

// Weekly
// → amount repeats every 7 days
// Fortnightly
// → amount repeats every 14 days
// Twice a month
// → amount occurs twice within each calendar month
// Monthly
// → amount repeats every calendar month
// Yearly
// → amount represents the total for the calendar year

// | Period        |           Example | Annual projection |
// | ------------- | ----------------: | ----------------: |
// | Weekly        |      ₱20,000/week |        ₱1,040,000 |
// | Fortnightly   |   ₱20,000/14 days |          ₱520,000 |
// | Twice a month | ₱20,000 × 2/month |          ₱480,000 |
// | Monthly       |     ₱40,000/month |          ₱480,000 |
// | Yearly        |     ₱480,000/year |          ₱480,000 |
extension BudgetPeriodExtension on BudgetPeriod {
  String get label {
    switch (this) {
      case BudgetPeriod.weekly:
        return 'Weekly';
      case BudgetPeriod.fortnightly:
        return 'Every 2 weeks';
      case BudgetPeriod.twiceAMonth:
        return 'Twice a month';
      case BudgetPeriod.monthly:
        return 'Monthly';
      case BudgetPeriod.yearly:
        return 'Yearly';
    }
  }

  String get shortLabel {
    switch (this) {
      case BudgetPeriod.weekly:
        return 'Week';
      case BudgetPeriod.fortnightly:
        return '2 weeks';
      case BudgetPeriod.twiceAMonth:
        return '2× / month';
      case BudgetPeriod.monthly:
        return 'Month';
      case BudgetPeriod.yearly:
        return 'Year';
    }
  }

  String get description {
    switch (this) {
      case BudgetPeriod.weekly:
        return 'Repeats every week';

      case BudgetPeriod.fortnightly:
        return 'Repeats every 2 weeks';

      case BudgetPeriod.twiceAMonth:
        return 'Occurs twice each month';

      case BudgetPeriod.monthly:
        return 'Repeats every month';

      case BudgetPeriod.yearly:
        return 'Total amount for the year';
    }
  }

  bool get supportsCustomization => switch (this) {
    BudgetPeriod.weekly => true,
    BudgetPeriod.fortnightly => true,
    BudgetPeriod.twiceAMonth => true,
    BudgetPeriod.monthly => false,
    BudgetPeriod.yearly => true,
  };
}





              //       Categories
              //           │
              //           │
              //           ▼
              //    CashFlowPlans
              //    ┌───────────────┐
              //    │ id            │
              //    │ categoryId    │
              //    │ planType      │
              //    │ amount        │
              //    │ period        │
              //    │ distribution  │
              //    │ createdAt     │
              //    │ updatedAt     │
              //    └───────┬───────┘
              //            │
              //            │ 1:N
              //            ▼
              // CashFlowPlanAllocations
              //    ┌───────────────┐
              //    │ id            │
              //    │ planId        │
              //    │ allocationKey │
              //    │ amount        │
              //    └───────────────┘

      //          CASHFLOW PLAN
      //                 │
      //     ┌───────────┼───────────┐
      //     ▼           ▼           ▼
      //  INCOME      EXPENSE     DEBT REPAYMENT
      //     │           │           │
      //  source       category      debt

// Weekly
// allocation 1–7
// Mon → Sun

// Fortnightly
// allocation 1–N
// repeating cycle pattern

// Twice a month
// allocation 1–2
// first / second occurrence

// Monthly
// no allocation rows

// Yearly
// allocation 1–12
// Jan → Dec