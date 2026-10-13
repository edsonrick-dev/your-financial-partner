import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_fund_details_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_result.dart';

class DeathBenefitResult {
  final double dependentExpenseContinuity;
  final double estateSettlementFund;
  final double liabilities;
  final double dependentsFutureNeeds;
  final double finalExpenses;
  final double eligibleExistingResources;

  final double totalDeathNeed;
  final double existingDeathCoverage;
  final double protectionGap;
  final ExpenseContinuityResult expenseContinuityResult;
  final ExpenseContinuityFundDetailsData expenseContinuityDetails;

  const DeathBenefitResult({
    required this.dependentExpenseContinuity,
    required this.estateSettlementFund,
    required this.liabilities,
    required this.dependentsFutureNeeds,
    required this.finalExpenses,
    required this.eligibleExistingResources,
    required this.totalDeathNeed,
    required this.existingDeathCoverage,
    required this.protectionGap,
    required this.expenseContinuityResult,
    required this.expenseContinuityDetails,
  });
}
