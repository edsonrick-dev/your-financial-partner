import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/domain/scheduling/month_pattern.dart';

class MonthPatterns {
  static const quarterly = [
    MonthPattern(
      months: [AppMonth.jan, AppMonth.apr, AppMonth.jul, AppMonth.oct],
    ),
    MonthPattern(
      months: [AppMonth.feb, AppMonth.may, AppMonth.aug, AppMonth.nov],
    ),
    MonthPattern(
      months: [AppMonth.mar, AppMonth.jun, AppMonth.sep, AppMonth.dec],
    ),
  ];
  static const semiAnnual = [
    MonthPattern(months: [AppMonth.jan, AppMonth.jul]),
    MonthPattern(months: [AppMonth.feb, AppMonth.aug]),
    MonthPattern(months: [AppMonth.mar, AppMonth.sep]),
    MonthPattern(months: [AppMonth.apr, AppMonth.oct]),
    MonthPattern(months: [AppMonth.may, AppMonth.nov]),
    MonthPattern(months: [AppMonth.jun, AppMonth.dec]),
  ];
  static final annual = AppMonth.values
      .map((month) => MonthPattern(months: [month]))
      .toList();
}
