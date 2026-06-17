import 'package:getx_drift_app/data/models/cashflow_plan_model.dart';
import 'package:getx_drift_app/features/financial_planner/cashflow_planner/services/cashflow_projection_service.dart';

class DailyOccurrenceGenerator implements OccurrenceGenerator {
  @override
  List<Occurrence> generate({required CashFlowPlan plan, required int year}) {
    final occurrences = <Occurrence>[];

    for (int month = 1; month <= 12; month++) {
      final daysInMonth = DateTime(year, month + 1, 0).day;

      for (int day = 1; day <= daysInMonth; day++) {
        final date = DateTime(year, month, day);

        final amount = _resolveDailyAmount(plan, date.weekday);

        if (amount == 0) continue;

        occurrences.add(Occurrence(date: date, amount: amount));
      }
    }

    return occurrences;
  }

  double _resolveDailyAmount(CashFlowPlan plan, int weekday) {
    if (plan.isUniform) {
      return plan.amount!;
    }

    return plan.customAmounts![weekday - 1];
  }
}
