import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';

class SavedCashflowPlanData {
  final int planId;
  final String category;
  final double amount;
  final BudgetPeriod budgetPeriod;
  final String iconKey;
  final bool isCustom;
  final String? customSummary;
  final String planType;

  const SavedCashflowPlanData({
    required this.planId,
    required this.category,
    required this.amount,
    required this.budgetPeriod,
    required this.iconKey,
    required this.isCustom,
    required this.customSummary,
    required this.planType,
  });
}
