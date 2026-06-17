import 'package:getx_drift_app/data/models/cashflow_plan_model.dart';
import 'package:getx_drift_app/features/financial_planner/cashflow_planner/services/cashflow_projection_service.dart';

class AnnualOccurrenceGenerator implements OccurrenceGenerator {
  @override
  List<Occurrence> generate({required CashFlowPlan plan, required int year}) {
    final months = selectedMonths(plan.monthMask!);

    if (months.isEmpty) {
      return [];
    }

    return [
      Occurrence(date: DateTime(year, months.first, 1), amount: plan.amount!),
    ];
  }
}
