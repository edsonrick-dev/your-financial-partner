import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_insight.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_insight_type.dart';

final cashflowInsights = <CashflowInsightType, CashflowInsight>{
  // ─────────────────────────────────────────────
  // Cashflow setup
  // ─────────────────────────────────────────────
  CashflowInsightType.cashflowEmpty: CashflowInsight(
    type: CashflowInsightType.cashflowEmpty,
    title: 'Start with your cashflow',
    interpretation: (controller) {
      return 'Your cashflow is not set up yet, so Ascend cannot interpret how your income and budget work together.';
    },
    recommendedAction: (controller) {
      return 'Add your income and create a budget to start understanding your cashflow.';
    },
  ),

  CashflowInsightType.onlyIncome: CashflowInsight(
    type: CashflowInsightType.onlyIncome,
    title: 'Your income is set',
    interpretation: (controller) {
      return 'You have an income plan, but without a budget Ascend cannot determine how much of your income is being allocated to your lifestyle.';
    },
    recommendedAction: (controller) {
      return 'Create a budget so you can see how your income is being used and what remains for savings and investments.';
    },
  ),

  CashflowInsightType.onlyBudget: CashflowInsight(
    type: CashflowInsightType.onlyBudget,
    title: 'Your budget is set',
    interpretation: (controller) {
      return 'You have a budget, but without an income plan Ascend cannot determine whether your budget is sustainable.';
    },
    recommendedAction: (controller) {
      return 'Add your income so you can compare your budget against what you earn.';
    },
  ),

  // ─────────────────────────────────────────────
  // Cashflow position
  // ─────────────────────────────────────────────
  CashflowInsightType.budgetExceedsIncome: CashflowInsight(
    type: CashflowInsightType.budgetExceedsIncome,
    title: 'Your budget is higher than your income',

    interpretation: (controller) {
      final income = controller.annualIncome;
      final budget = controller.annualBudget;
      final gap = budget - income;

      return 'Your annual budget is ${budget.toCurrency()}, '
          'while your annual income is ${income.toCurrency()}. '
          'You are currently budgeting ${gap.toCurrency()} more '
          'than you earn.';
    },

    recommendedAction: (controller) {
      final gap = controller.budgetGap;

      return 'Start by reducing your budget by '
          '${gap.toCurrency()} per year to bring it within your income. '
          'Once your cashflow is sustainable, work toward your '
          '70% budget target.';
    },
  ),
  CashflowInsightType.budgetEqualsIncome: CashflowInsight(
    type: CashflowInsightType.budgetEqualsIncome,
    title: 'Your budget uses all of your income',

    interpretation: (controller) {
      return 'Your current budget is fully consuming your planned income, '
          'leaving no planned surplus for savings and investments.';
    },

    recommendedAction: (controller) {
      return 'First create some room between your income and budget. Then '
          'work toward your 70% budget target to build a consistent surplus.';
    },
  ),

  // ─────────────────────────────────────────────
  // Budget allocation
  // ─────────────────────────────────────────────
  CashflowInsightType.budgetAboveIdeal: CashflowInsight(
    type: CashflowInsightType.budgetAboveIdeal,
    title: 'Your budget is above the 70% target',

    interpretation: (controller) {
      return 'Your budget is sustainable because it is below your '
          'income, but it currently uses more than the 70% allocation '
          'Ascend recommends for your lifestyle.';
    },

    recommendedAction: (controller) {
      return 'Look for opportunities to reduce your budget so you can consistently keep at least 30% of your income available for savings and investments.';
    },
  ),

  CashflowInsightType.budgetWithinIdeal: CashflowInsight(
    type: CashflowInsightType.budgetWithinIdeal,
    title: 'Your budget is on target',

    interpretation: (controller) {
      return 'Your budget is at 70% of your income, giving you a planned 30% '
          'surplus for savings and investments.';
    },

    recommendedAction: (controller) {
      return 'Maintain this allocation and put your surplus to work toward '
          'your financial goals.';
    },
  ),

  CashflowInsightType.budgetBelowIdeal: CashflowInsight(
    type: CashflowInsightType.budgetBelowIdeal,
    title: 'You have room to build wealth',

    interpretation: (controller) {
      return 'Your budget is below 70% of your income, giving you more '
          'than the 30% surplus targeted by Ascend.';
    },

    recommendedAction: (controller) {
      return 'Keep your lifestyle sustainable and consider directing '
          'the additional surplus toward savings, debt repayment, and investments.';
    },
  ),

  // // ─────────────────────────────────────────────
  // // Budget composition
  // // ─────────────────────────────────────────────
  // CashflowInsightType.onlyExpenses: CashflowInsight(
  //   type: CashflowInsightType.onlyExpenses,
  //   title: 'Your budget is focused on expenses',
  //   interpretation:
  //       'Your current budget consists of lifestyle expenses without planned debt repayments.',
  //   recommendedAction:
  //       'Review your expenses and make sure your surplus is being intentionally directed toward your financial goals.',
  // ),

  // CashflowInsightType.onlyDebtRepayment: CashflowInsight(
  //   type: CashflowInsightType.onlyDebtRepayment,
  //   title: 'Your budget is focused on debt repayment',
  //   interpretation:
  //       'Your current budget is entirely allocated to debt repayment rather than regular lifestyle expenses.',
  //   recommendedAction:
  //       'Review your debt repayment plan and make sure your budget also reflects the cost of maintaining your lifestyle.',
  // ),

  // CashflowInsightType.expensesExceedDebtRepayment: CashflowInsight(
  //   type: CashflowInsightType.expensesExceedDebtRepayment,
  //   title: 'Most of your budget goes to expenses',
  //   interpretation:
  //       'Your lifestyle expenses currently make up more of your budget than your debt repayments.',
  //   recommendedAction:
  //       'Keep your lifestyle sustainable while reviewing whether your debt repayment plan is progressing toward your financial goals.',
  // ),

  // CashflowInsightType.expensesEqualDebtRepayment: CashflowInsight(
  //   type: CashflowInsightType.expensesEqualDebtRepayment,
  //   title: 'Your budget is evenly split',
  //   interpretation:
  //       'Your lifestyle expenses and debt repayments currently account for similar portions of your budget.',
  //   recommendedAction:
  //       'Maintain a sustainable lifestyle while making consistent progress on your debt obligations.',
  // ),

  // CashflowInsightType.debtRepaymentExceedsExpenses: CashflowInsight(
  //   type: CashflowInsightType.debtRepaymentExceedsExpenses,
  //   title: 'Most of your budget goes to debt repayment',
  //   interpretation:
  //       'Your debt repayments currently make up more of your budget than your lifestyle expenses.',
  //   recommendedAction:
  //       'Continue prioritizing your debt obligations while ensuring your lifestyle budget remains sustainable.',
  // ),
};
