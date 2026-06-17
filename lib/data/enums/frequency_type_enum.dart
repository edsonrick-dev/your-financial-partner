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
}
