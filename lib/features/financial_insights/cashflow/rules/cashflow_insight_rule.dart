import 'package:getx_drift_app/features/financial_insights/cashflow/models/budget_allocation_position.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/budget_composition.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_insight_type.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_position.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_state.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_status.dart';

class CashflowInsightRule {
  final CashflowInsightType type;
  final int priority;
  final bool Function(CashflowState state) matches;

  const CashflowInsightRule({
    required this.type,
    required this.priority,
    required this.matches,
  });
}

final cashflowInsightRules = <CashflowInsightRule>[
  // ─────────────────────────────────────────────
  // Cashflow setup
  // ─────────────────────────────────────────────
  CashflowInsightRule(
    type: CashflowInsightType.cashflowEmpty,
    priority: 100,
    matches: (state) => state.status == CashflowStatus.empty,
  ),

  CashflowInsightRule(
    type: CashflowInsightType.onlyIncome,
    priority: 90,
    matches: (state) => state.status == CashflowStatus.onlyIncome,
  ),

  CashflowInsightRule(
    type: CashflowInsightType.onlyBudget,
    priority: 90,
    matches: (state) => state.status == CashflowStatus.onlyBudget,
  ),

  // ─────────────────────────────────────────────
  // Cashflow position
  // ─────────────────────────────────────────────
  CashflowInsightRule(
    type: CashflowInsightType.budgetExceedsIncome,
    priority: 80,
    matches: (state) => state.position == CashflowPosition.budgetExceedsIncome,
  ),

  CashflowInsightRule(
    type: CashflowInsightType.budgetEqualsIncome,
    priority: 70,
    matches: (state) => state.position == CashflowPosition.budgetEqualsIncome,
  ),

  // ─────────────────────────────────────────────
  // Budget allocation
  // ─────────────────────────────────────────────
  CashflowInsightRule(
    type: CashflowInsightType.budgetAboveIdeal,
    priority: 60,
    matches: (state) =>
        state.allocation == BudgetAllocationPosition.moreThanIdeal,
  ),

  CashflowInsightRule(
    type: CashflowInsightType.budgetWithinIdeal,
    priority: 50,
    matches: (state) =>
        state.allocation == BudgetAllocationPosition.withinIdeal,
  ),

  CashflowInsightRule(
    type: CashflowInsightType.budgetBelowIdeal,
    priority: 40,
    matches: (state) =>
        state.allocation == BudgetAllocationPosition.lessThanIdeal,
  ),

  // ─────────────────────────────────────────────
  // Budget composition
  // ─────────────────────────────────────────────
  CashflowInsightRule(
    type: CashflowInsightType.onlyExpenses,
    priority: 30,
    matches: (state) => state.composition == BudgetComposition.onlyExpenses,
  ),

  CashflowInsightRule(
    type: CashflowInsightType.onlyDebtRepayment,
    priority: 30,
    matches: (state) =>
        state.composition == BudgetComposition.onlyDebtRepayment,
  ),

  CashflowInsightRule(
    type: CashflowInsightType.expensesExceedDebtRepayment,
    priority: 30,
    matches: (state) =>
        state.composition == BudgetComposition.expensesExceedDebtRepayment,
  ),

  CashflowInsightRule(
    type: CashflowInsightType.expensesEqualDebtRepayment,
    priority: 30,
    matches: (state) =>
        state.composition == BudgetComposition.expensesEqualDebtRepayment,
  ),

  CashflowInsightRule(
    type: CashflowInsightType.debtRepaymentExceedsExpenses,
    priority: 30,
    matches: (state) =>
        state.composition == BudgetComposition.debtRepaymentExceedsExpenses,
  ),
];
