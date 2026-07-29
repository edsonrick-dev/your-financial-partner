import 'package:getx_drift_app/data/models/cashflow_plan_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/services/cashflow_projection_service.dart';

class MonthlyOccurrenceGenerator implements OccurrenceGenerator {
  @override
  List<Occurrence> generate({required CashFlowPlan plan, required int year}) {
    final occurrences = <Occurrence>[];

    for (int month = 1; month <= 12; month++) {
      final amount = _resolveAmount(plan, month - 1);

      if (amount == 0) continue;

      occurrences.add(
        Occurrence(date: DateTime(year, month, 1), amount: amount),
      );
    }

    return occurrences;
  }

  double _resolveAmount(CashFlowPlan plan, int index) {
    if (plan.customAmounts == null || plan.customAmounts!.isEmpty) {
      return plan.amount!;
    }

    return plan.customAmounts![index];
  }
}
