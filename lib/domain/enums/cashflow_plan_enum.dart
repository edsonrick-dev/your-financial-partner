import 'package:getx_drift_app/data/enums/transaction_type.dart';

enum CashflowPlanType { income, expense, debtRepayment, savingsInvestment }

extension CashFlowPlanTypeExtension on CashflowPlanType {
  String get categoryType => switch (this) {
    CashflowPlanType.income => TransactionType.earn.name,

    CashflowPlanType.expense => TransactionType.spend.name,

    CashflowPlanType.debtRepayment => 'debtRepayment',

    CashflowPlanType.savingsInvestment => 'savingsInvestment',
  };

  String get label {
    switch (this) {
      case CashflowPlanType.income:
        return 'Income Sources';
      case CashflowPlanType.expense:
        return 'Expenses';
      case CashflowPlanType.debtRepayment:
        return 'Debt Repayment';
      case CashflowPlanType.savingsInvestment:
        return 'Savings & Investments';
    }
  }

  String get description {
    switch (this) {
      case CashflowPlanType.income:
        return 'Plan money you expect to receive regularly or occasionally.';
      case CashflowPlanType.expense:
        return 'Plan money for everyday needs, bills, and lifestyle spending.';
      case CashflowPlanType.debtRepayment:
        return 'Plan money for paying off loans and other obligations.';
      case CashflowPlanType.savingsInvestment:
        return 'Plan money for emergencies, financial goals, savings, and investments.';
    }
  }

  String get iconKey {
    switch (this) {
      case CashflowPlanType.income:
        return 'coins';
      case CashflowPlanType.expense:
        return 'shoppingCart';
      case CashflowPlanType.debtRepayment:
        return 'creditCard';
      case CashflowPlanType.savingsInvestment:
        return 'piggyBank';
    }
  }
}
