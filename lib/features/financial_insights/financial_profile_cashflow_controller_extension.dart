import 'package:getx_drift_app/features/financial_insights/cashflow/models/budget_allocation_position.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/budget_composition.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_position.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_state.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_status.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';

extension FinancialProfileCashflowControllerExtension
    on FinancialProfileController {
  bool get hasBudget => cashflowController.hasBudgetPlan;
  bool get hasIncome => cashflowController.hasIncomePlan;
  bool get isCashflowComplete => hasIncome && hasBudget;
  CashflowPosition? get cashflowPosition {
    if (!isCashflowComplete) return null;

    if (annualBudget > annualIncome) {
      return CashflowPosition.budgetExceedsIncome;
    }

    if (annualBudget == annualIncome) {
      return CashflowPosition.budgetEqualsIncome;
    }

    return CashflowPosition.budgetBelowIncome;
  }

  BudgetAllocationPosition? get budgetAllocationPosition {
    if (!isCashflowComplete) return null;

    if (annualBudget > idealAnnualBudget) {
      return BudgetAllocationPosition.moreThanIdeal;
    }

    if (annualBudget == idealAnnualBudget) {
      return BudgetAllocationPosition.withinIdeal;
    }

    return BudgetAllocationPosition.lessThanIdeal;
  }

  BudgetComposition? get budgetComposition {
    if (!isCashflowComplete) return null;

    if (annualExpenses > 0 && annualDebtRepayments == 0) {
      return BudgetComposition.onlyExpenses;
    }

    if (annualExpenses == 0 && annualDebtRepayments > 0) {
      return BudgetComposition.onlyDebtRepayment;
    }

    if (annualExpenses > annualDebtRepayments) {
      return BudgetComposition.expensesExceedDebtRepayment;
    }

    if (annualExpenses == annualDebtRepayments) {
      return BudgetComposition.expensesEqualDebtRepayment;
    }

    return BudgetComposition.debtRepaymentExceedsExpenses;
  }

  CashflowStatus get cashflowStatus {
    if (!hasIncome && !hasBudget) {
      return CashflowStatus.empty;
    }

    if (hasIncome && !hasBudget) {
      return CashflowStatus.onlyIncome;
    }

    if (!hasIncome && hasBudget) {
      return CashflowStatus.onlyBudget;
    }

    return CashflowStatus.complete;
  }

  CashflowState get cashflowState {
    final status = cashflowStatus;

    if (status != CashflowStatus.complete) {
      return CashflowState(status: status);
    }

    return CashflowState(
      status: status,
      position: cashflowPosition,
      allocation: budgetAllocationPosition,
      composition: budgetComposition,
    );
  }

  // /// SCENARIO || No income and no budget
  // /// WHAT IT MEANS || You don't have recorded income and no expenses yet.
  // /// RECOMMENDED ACTION || Start by adding your income and expenses to get your
  // /// cash flow overview
  // bool get isCashflowEmpty => !hasBudget && !hasIncome;

  // /// SCENARIO || No income, but has budget
  // /// WHAT IT MEANS || You have expenses, but no income. This will lead to a deficit.
  // /// RECOMMENDED ACTION || Add your income or reduce your expenses to avoid
  // /// going into debt.
  // bool get onlyBudget => hasBudget && !hasIncome;

  // /// SCENARIO || Has income, but no budget
  // /// WHAT IT MEANS || You have income, but no recorded budget. This gives
  // /// you full flexibility, but no guidance.
  // /// RECOMMENDED ACTION || Set a budget. Start with 70% of your income for
  // /// expenses and 30% for savings and investments
  // bool get onlyIncome => !hasBudget && hasIncome;

  // /// SCENARIO || Budget greater than income
  // /// WHAT IT MEANS || Your planned expenses exceed your income. This
  // /// will result in a deficit and likely debt.
  // /// RECOMMENDED ACTION || Reduce your budget to bring it within
  // /// your income. Then work toward the 70% target.
  // bool get budgetExceedsIncome =>
  //     isCashflowComplete && annualBudget > annualIncome;

  // /// SCENARIO || Budget equal to income
  // /// WHAT IT MEANS || All of your income is allocated to expenses.
  // /// You have no room for savings or investments.
  // /// RECOMMENDED ACTION || Reduce your budget to 70% of your income
  // /// to create room for wealth building.
  // bool get budgetEqualsIncome =>
  //     isCashflowComplete && annualBudget == annualIncome;

  // /// SCENARIO || Budget less than income
  // /// WHAT IT MEANS || Your expenses are within your income.
  // /// You have a surplus, which you can save or invest.
  // /// RECOMMENDED ACTION || Continue managing your budget and work
  // /// toward the 70% target for more consistent savings.
  // bool get budgetBelowIncome =>
  //     isCashflowComplete && annualBudget < annualIncome;

  // /// SCENARIO || Budget greater than 70% of income
  // /// WHAT IT MEANS || Your expenses are within your income, but
  // /// higher than the 70% target, leaving less than 30% for savings and investments.
  // /// RECOMMENDED ACTION || Reduce your budget to 70% of your income to create
  // /// more room for wealth building.
  // bool get budgetIsMoreThanIdeal =>
  //     isCashflowComplete && annualBudget > idealAnnualBudget;

  // /// SCENARIO || Budget equal to 70% of income
  // /// WHAT IT MEANS || You are at the ideal 70/30 allocation. Your expenses
  // /// are 70% of income, leaving 30% for savings and investments
  // /// RECOMMENDED ACTION || Maintain this allocation and look for
  // /// opportunities to increase your income over time.
  // bool get budgetIsWithinIdeal =>
  //     isCashflowComplete && annualBudget == idealAnnualBudget;

  // /// SCENARIO || Budget less than 70% of income
  // /// WHAT IT MEANS || Your expenses are below the 70% target. Your
  // /// are saving and investing more than 30% of your income.
  // /// RECOMMENDED ACTION || Keep it up! Continue managing your budget
  // /// and consider investing the additional surplus
  // bool get budgetIsLessThanIdeal =>
  //     isCashflowComplete && annualBudget < idealAnnualBudget;

  // // ============================================================
  // // BUDGET COMPOSITION
  // // ============================================================

  // /// SCENARIO || Expenses greater than debt repayment
  // ///
  // /// WHAT IT MEANS || Most of your budget is allocated to expenses
  // /// rather than debt repayment.
  // ///
  // /// RECOMMENDED ACTION || Continue managing your expenses while
  // /// prioritizing any high-cost debt.
  // bool get expensesExceedDebtRepayment =>
  //     isCashflowComplete && annualExpenses > annualDebtRepayments;

  // /// SCENARIO || Expenses equal debt repayment
  // ///
  // /// WHAT IT MEANS || Your budget is evenly divided between
  // /// expenses and debt repayment.
  // ///
  // /// RECOMMENDED ACTION || Maintain your expenses while working
  // /// toward reducing your debt.

  // bool get expensesEqualDebtRepayment =>
  //     isCashflowComplete && annualExpenses == annualDebtRepayments;

  // /// SCENARIO || Expenses less than debt repayment
  // ///
  // /// WHAT IT MEANS || More of your budget is allocated to debt
  // /// repayment than to expenses.
  // ///
  // /// RECOMMENDED ACTION || Continue prioritizing debt repayment
  // /// while keeping your expenses sustainable.

  // bool get expensesBelowDebtRepayment =>
  //     isCashflowComplete && annualExpenses < annualDebtRepayments;

  // /// Only debt repayment is allocated in the budget.
  // bool get onlyDebtRepayment =>
  //     isCashflowComplete && annualExpenses == 0 && annualDebtRepayments > 0;

  // /// Only expenses are allocated in the budget.
  // bool get onlyExpenses =>
  //     isCashflowComplete && annualExpenses > 0 && annualDebtRepayments == 0;
}
