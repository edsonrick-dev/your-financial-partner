import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';

class SavedCashflowPlanData {
  final int planId;
  final int categoryId;
  final String category;
  final double amount;
  final BudgetPeriod budgetPeriod;
  final String iconKey;
  final bool isCustom;
  final String? customSummary;
  final String planType;

  const SavedCashflowPlanData({
    required this.planId,
    required this.categoryId,
    required this.category,
    required this.amount,
    required this.budgetPeriod,
    required this.iconKey,
    required this.isCustom,
    required this.customSummary,
    required this.planType,
  });
}

// class SavedCashflowPlanData {
//   final int planId;
//   final int categoryId;
//   final String category;
//   final double amount;
//   final BudgetPeriod budgetPeriod;

//   final CashFlowDistribution distributionType;
//   final List<double> allocations;

//   final DateTime startDate;

//   final String iconKey;
//   final bool isCustom;
//   final String? customSummary;
//   final String planType;

//   const SavedCashflowPlanData({
//     required this.planId,
//     required this.categoryId,
//     required this.category,
//     required this.amount,
//     required this.budgetPeriod,
//     required this.distributionType,
//     required this.allocations,
//     required this.startDate,
//     required this.iconKey,
//     required this.isCustom,
//     required this.customSummary,
//     required this.planType,
//   });
// }
