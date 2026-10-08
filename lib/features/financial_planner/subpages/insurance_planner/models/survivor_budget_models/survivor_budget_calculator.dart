import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/survivor_budget_models/survivor_budget.dart';

class SurvivorBudgetCalculator {
  double calculateMonthlyDependentExpenses({
    required List<SurvivorBudget> budgets,
  }) {
    return budgets.fold<double>(
      0,
      (total, budget) => total + budget.monthlyDependentExpense,
    );
  }
}
