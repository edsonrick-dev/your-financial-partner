import 'package:getx_drift_app/domain/enums/app_day.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';

String cashflowAllocationLabel({
  required BudgetPeriod period,
  required int index,
}) {
  switch (period) {
    case BudgetPeriod.weekly:
      return AppDay.values[index].fullName;

    case BudgetPeriod.fortnightly:
      return switch (index) {
        0 => '1st Cycle',
        1 => '2nd Cycle',
        _ => 'Cycle ${index + 1}',
      };

    case BudgetPeriod.monthly:
      return switch (index) {
        0 => 'First Half',
        1 => 'Second Half',
        _ => 'Period ${index + 1}',
      };

    case BudgetPeriod.yearly:
      return AppMonth.values[index].fullName;
  }
}
