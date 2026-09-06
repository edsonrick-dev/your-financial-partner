import 'package:getx_drift_app/domain/scheduling/month_pattern.dart';
import 'package:getx_drift_app/domain/scheduling/month_patterns.dart';

enum BillsFrequency {
  weekly,
  biWeekly,
  fortnightly,
  monthly,
  quarterly,
  semiAnnual,
  annual,
}

extension BillsFrequencyExtension on BillsFrequency {
  String get billsLabel {
    switch (this) {
      case BillsFrequency.weekly:
        return 'Billed every week';

      case BillsFrequency.biWeekly:
        return 'Billed twice a month';

      case BillsFrequency.fortnightly:
        return 'Billed fornightly / every two weeks';

      case BillsFrequency.monthly:
        return 'Billed every month';

      case BillsFrequency.quarterly:
        return 'Billed every quarter';

      case BillsFrequency.semiAnnual:
        return 'Billed every 6 months';

      case BillsFrequency.annual:
        return 'Billed every year';
    }
  }

  String get period {
    switch (this) {
      case BillsFrequency.weekly:
        return 'week';

      case BillsFrequency.biWeekly:
        return 'twice a month';

      case BillsFrequency.fortnightly:
        return 'two weeks';

      case BillsFrequency.monthly:
        return 'month';

      case BillsFrequency.quarterly:
        return 'quarter';

      case BillsFrequency.semiAnnual:
        return '6 months';

      case BillsFrequency.annual:
        return 'year';
    }
  }

  String get initials {
    switch (this) {
      case BillsFrequency.weekly:
        return 'W';

      case BillsFrequency.biWeekly:
        return '2W';

      case BillsFrequency.fortnightly:
        return 'F';

      case BillsFrequency.monthly:
        return 'M';

      case BillsFrequency.quarterly:
        return '3M';

      case BillsFrequency.semiAnnual:
        return '6M';

      case BillsFrequency.annual:
        return 'Y';
    }
  }

  String get label {
    switch (this) {
      case BillsFrequency.weekly:
        return 'Weekly';

      case BillsFrequency.biWeekly:
        return 'Bi-Weekly';

      case BillsFrequency.fortnightly:
        return 'Fortnightly';

      case BillsFrequency.monthly:
        return 'Monthly';

      case BillsFrequency.quarterly:
        return 'Quarterly';

      case BillsFrequency.semiAnnual:
        return 'Semi-Annual';

      case BillsFrequency.annual:
        return 'Annual';
    }
  }

  bool get isSupported {
    switch (this) {
      case BillsFrequency.biWeekly:
      case BillsFrequency.fortnightly:
        return false;

      default:
        return true;
    }
  }

  bool get isCustomizable {
    switch (this) {
      case BillsFrequency.weekly:
      case BillsFrequency.annual:
        return false;
      default:
        return true;
    }
  }

  bool get requiresMonthPattern {
    switch (this) {
      case BillsFrequency.quarterly:
      case BillsFrequency.semiAnnual:
      case BillsFrequency.annual:
        return true;

      default:
        return false;
    }
  }

  bool get canBeBill {
    switch (this) {
      case BillsFrequency.monthly:
      case BillsFrequency.quarterly:
      case BillsFrequency.semiAnnual:
      case BillsFrequency.annual:
        return true;

      default:
        return false;
    }
  }

  String get patternLabel {
    switch (this) {
      case BillsFrequency.quarterly:
        return 'Quarterly Cycle';
      case BillsFrequency.semiAnnual:
        return 'Semi-Annual Cycle';
      case BillsFrequency.annual:
        return 'Month';
      default:
        return '';
    }
  }

  List<MonthPattern> get monthPatterns {
    switch (this) {
      case BillsFrequency.quarterly:
        return MonthPatterns.quarterly;
      case BillsFrequency.semiAnnual:
        return MonthPatterns.semiAnnual;
      case BillsFrequency.annual:
        return MonthPatterns.annual;

      default:
        return [];
    }
  }

  double toAnnual(double amount) {
    switch (this) {
      case BillsFrequency.weekly:
        return amount * 52;

      case BillsFrequency.biWeekly:
        return amount * 26;
      case BillsFrequency.fortnightly:
        return amount * 26;

      case BillsFrequency.monthly:
        return amount * 12;

      case BillsFrequency.quarterly:
        return amount * 4;

      case BillsFrequency.semiAnnual:
        return amount * 2;

      case BillsFrequency.annual:
        return amount;
    }
  }

  double toMonthly(double amount) {
    return toAnnual(amount) / 12;
  }
}
