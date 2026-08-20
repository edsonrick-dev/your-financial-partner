enum CashflowPlanType { income, expense, debtRepayment }

extension CashFlowPlanTypeExtension on CashflowPlanType {
  String get label => switch (this) {
    CashflowPlanType.income => 'Income Sources',
    CashflowPlanType.expense => 'Expenses',
    CashflowPlanType.debtRepayment => 'Debt Repayment',
  };

  String get description => switch (this) {
    CashflowPlanType.income =>
      'Plan money you expect to receive regularly or occasionally.',

    CashflowPlanType.expense =>
      'Plan money for everyday needs and lifestyle spending.',

    CashflowPlanType.debtRepayment =>
      'Plan money for repaying your formal loans.',
  };

  String get iconKey => switch (this) {
    CashflowPlanType.income => 'coins',
    CashflowPlanType.expense => 'shoppingCart',
    CashflowPlanType.debtRepayment => 'creditCard',
  };
}
