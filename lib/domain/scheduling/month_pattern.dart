import 'package:getx_drift_app/domain/enums/app_month.dart';

class MonthPattern {
  final List<AppMonth> months;
  // final String label;
  // final int monthMask;

  const MonthPattern({required this.months});

  String get label => months.map((e) => e.shortName).join(' | ');

  int get monthMask =>
      months.fold(0, (mask, month) => mask | (1 << (month.number - 1)));

  String shortLabel() {
    return months.map((e) => e.shortName).join(' | ');
  }

  String fullLabel() {
    return months.map((e) => e.fullName).join(' | ');
  }
}
