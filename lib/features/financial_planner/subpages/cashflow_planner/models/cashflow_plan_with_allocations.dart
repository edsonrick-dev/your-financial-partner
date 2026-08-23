import 'package:getx_drift_app/data/app_database.dart';

class CashflowPlanWithAllocations {
  final CashFlowPlan plan;
  final List<CashFlowPlanAllocation> allocations;

  const CashflowPlanWithAllocations({
    required this.plan,
    required this.allocations,
  });
}
