import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_fund_details_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_result.dart';

class DisabilityBenefitResult {
  // Medical expenses
  final double medicalExpenses;

  // Income replacement or financial continuity
  final double lifestyleExpenseContinuity;

  // Additional financial needs
  final double recoveryExpenses;
  final double liabilities;

  // Existing resources
  final double eligibleExistingResources;

  // Summary
  final double totalDisabilityNeed;
  final double existingDisabilityCoverage;
  final double protectionGap;

  // Supporting calculation details
  final ExpenseContinuityResult expenseContinuityResult;
  final ExpenseContinuityFundDetailsData expenseContinuityDetails;

  const DisabilityBenefitResult({
    required this.medicalExpenses,
    required this.lifestyleExpenseContinuity,
    required this.recoveryExpenses,
    required this.liabilities,
    required this.eligibleExistingResources,
    required this.totalDisabilityNeed,
    required this.existingDisabilityCoverage,
    required this.protectionGap,
    required this.expenseContinuityResult,
    required this.expenseContinuityDetails,
  });
}
