import 'package:getx_drift_app/features/financial_insights/cashflow/models/budget_allocation_position.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/budget_composition.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_position.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_status.dart';

class CashflowState {
  final CashflowStatus status;
  final CashflowPosition? position;
  final BudgetAllocationPosition? allocation;
  final BudgetComposition? composition;

  const CashflowState({
    required this.status,
    this.position,
    this.allocation,
    this.composition,
  });
}
