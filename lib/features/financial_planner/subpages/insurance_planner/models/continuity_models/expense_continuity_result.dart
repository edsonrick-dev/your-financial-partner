import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_year.dart';

class ExpenseContinuityResult {
  final double uninvestedNeed;
  final double investedNeed;
  final List<ExpenseContinuityYear> projection;

  const ExpenseContinuityResult({
    required this.uninvestedNeed,
    required this.investedNeed,
    required this.projection,
  });

  double get investmentBenefit => uninvestedNeed - investedNeed;
}
