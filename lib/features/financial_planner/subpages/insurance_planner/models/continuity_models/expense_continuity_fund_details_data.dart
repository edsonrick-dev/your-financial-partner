import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_result.dart';

class ExpenseContinuityFundDetailsData {
  const ExpenseContinuityFundDetailsData({
    required this.planDate,
    required this.monthlyExpense,
    required this.planValidityYears,
    required this.supportYears,
    required this.inflationRate,
    required this.portfolioReturn,
    required this.result,
  });

  final DateTime planDate;
  final double monthlyExpense;
  final int planValidityYears;
  final int supportYears;
  final double inflationRate;
  final double portfolioReturn;
  final ExpenseContinuityResult result;

  double get currentAnnualExpenses => monthlyExpense * 12;

  DateTime get supportStartDate =>
      DateTime(planDate.year + planValidityYears, planDate.month, planDate.day);

  DateTime get supportEndDate => DateTime(
    supportStartDate.year + supportYears - 1,
    supportStartDate.month,
    supportStartDate.day,
  );
}
