import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_fund_details_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_result.dart';

class CriticalIllnessBenefitResult {
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
  final double totalCriticalIllnessNeed;
  final double existingCriticalIllnessCoverage;
  final double protectionGap;

  // Supporting calculation details
  final ExpenseContinuityResult expenseContinuityResult;
  final ExpenseContinuityFundDetailsData expenseContinuityDetails;

  const CriticalIllnessBenefitResult({
    required this.medicalExpenses,
    required this.lifestyleExpenseContinuity,
    required this.recoveryExpenses,
    required this.liabilities,
    required this.eligibleExistingResources,
    required this.totalCriticalIllnessNeed,
    required this.existingCriticalIllnessCoverage,
    required this.protectionGap,
    required this.expenseContinuityResult,
    required this.expenseContinuityDetails,
  });
}
