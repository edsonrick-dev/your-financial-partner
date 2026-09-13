enum CashflowInsightType {
  cashflowEmpty,
  onlyIncome,
  onlyBudget,

  budgetExceedsIncome,
  budgetEqualsIncome,

  budgetAboveIdeal,
  budgetWithinIdeal,
  budgetBelowIdeal,

  onlyExpenses,
  onlyDebtRepayment,
  expensesExceedDebtRepayment,
  expensesEqualDebtRepayment,
  debtRepaymentExceedsExpenses,
}
