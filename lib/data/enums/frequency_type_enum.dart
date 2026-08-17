import 'package:getx_drift_app/domain/scheduling/month_pattern.dart';
import 'package:getx_drift_app/domain/scheduling/month_patterns.dart';

enum FrequencyType {
  daily,
  weekly,
  biWeekly,
  fortnightly,
  monthly,
  quarterly,
  semiAnnual,
  annual,
}

extension FrequencyTypeExtension on FrequencyType {
  String get period {
    switch (this) {
      case FrequencyType.daily:
        return 'day';

      case FrequencyType.weekly:
        return 'week';

      case FrequencyType.biWeekly:
        return 'twice a month';

      case FrequencyType.fortnightly:
        return 'two weeks';

      case FrequencyType.monthly:
        return 'month';

      case FrequencyType.quarterly:
        return 'quarter';

      case FrequencyType.semiAnnual:
        return '6 months';

      case FrequencyType.annual:
        return 'year';
    }
  }

  String get label {
    switch (this) {
      case FrequencyType.daily:
        return 'Daily';

      case FrequencyType.weekly:
        return 'Weekly';

      case FrequencyType.biWeekly:
        return 'Bi-Weekly';

      case FrequencyType.fortnightly:
        return 'Fortnightly';

      case FrequencyType.monthly:
        return 'Monthly';

      case FrequencyType.quarterly:
        return 'Quarterly';

      case FrequencyType.semiAnnual:
        return 'Semi-Annual';

      case FrequencyType.annual:
        return 'Annual';
    }
  }

  bool get isSupported {
    switch (this) {
      case FrequencyType.biWeekly:
      case FrequencyType.fortnightly:
        return false;

      default:
        return true;
    }
  }

  bool get isCustomizable {
    switch (this) {
      case FrequencyType.weekly:
      case FrequencyType.annual:
        return false;
      default:
        return true;
    }
  }

  bool get requiresMonthPattern {
    switch (this) {
      case FrequencyType.quarterly:
      case FrequencyType.semiAnnual:
      case FrequencyType.annual:
        return true;

      default:
        return false;
    }
  }

  bool get canBeBill {
    switch (this) {
      case FrequencyType.monthly:
      case FrequencyType.quarterly:
      case FrequencyType.semiAnnual:
      case FrequencyType.annual:
        return true;

      default:
        return false;
    }
  }

  String get patternLabel {
    switch (this) {
      case FrequencyType.quarterly:
        return 'Quarterly Cycle';
      case FrequencyType.semiAnnual:
        return 'Semi-Annual Cycle';
      case FrequencyType.annual:
        return 'Month';
      default:
        return '';
    }
  }

  List<MonthPattern> get monthPatterns {
    switch (this) {
      case FrequencyType.quarterly:
        return MonthPatterns.quarterly;
      case FrequencyType.semiAnnual:
        return MonthPatterns.semiAnnual;
      case FrequencyType.annual:
        return MonthPatterns.annual;

      default:
        return [];
    }
  }

  double toAnnual(double amount) {
    switch (this) {
      case FrequencyType.daily:
        return amount * 365;
      case FrequencyType.weekly:
        return amount * 52;

      case FrequencyType.biWeekly:
        return amount * 26;
      case FrequencyType.fortnightly:
        return amount * 26;

      case FrequencyType.monthly:
        return amount * 12;

      case FrequencyType.quarterly:
        return amount * 4;

      case FrequencyType.semiAnnual:
        return amount * 2;

      case FrequencyType.annual:
        return amount;
    }
  }

  double toMonthly(double amount) {
    return toAnnual(amount) / 12;
  }
}
