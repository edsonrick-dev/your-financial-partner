import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_fund_details_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_result.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';

class ProtectionBenefitInput {
  // Protection configuration
  final ProtectionType protectionType;
  final ProtectionHorizon horizon;

  // Expense continuity
  final double monthlyContinuityExpenses;

  // Medical and recovery expenses
  final double medicalAndRecoveryFund;

  // Financial obligations
  final double liabilities;

  // Death-specific needs
  final double estateSettlementFund;
  final double dependentsFutureNeeds;
  final double finalExpenses;

  // Existing financial resources and insurance coverage
  final double eligibleExistingResources;
  final double existingCoverage;

  // Required only when the horizon is until retirement
  final int? currentAge;
  final int? retirementAge;

  const ProtectionBenefitInput({
    required this.protectionType,
    required this.horizon,
    required this.monthlyContinuityExpenses,
    this.medicalAndRecoveryFund = 0,
    this.liabilities = 0,
    this.estateSettlementFund = 0,
    this.dependentsFutureNeeds = 0,
    this.finalExpenses = 0,
    this.eligibleExistingResources = 0,
    this.existingCoverage = 0,
    this.currentAge,
    this.retirementAge,
  });
}

class ProtectionBenefitResult {
  // Protection configuration
  final ProtectionType protectionType;
  final ProtectionHorizon horizon;

  // Expense continuity
  final double expenseContinuityFund;
  final ExpenseContinuityResult expenseContinuityResult;
  final ExpenseContinuityFundDetailsData expenseContinuityDetails;

  // Medical and recovery
  final double medicalAndRecoveryFund;

  // Financial obligations
  final double liabilities;

  // Existing financial resources and insurance coverage
  final double eligibleExistingResources;
  final double existingCoverage;

  // Final calculation results
  final double totalProtectionNeed;
  final double protectionGap;

  const ProtectionBenefitResult({
    required this.protectionType,
    required this.horizon,
    required this.expenseContinuityFund,
    required this.expenseContinuityResult,
    required this.expenseContinuityDetails,
    this.medicalAndRecoveryFund = 0,
    required this.liabilities,
    required this.eligibleExistingResources,
    required this.existingCoverage,
    required this.totalProtectionNeed,
    required this.protectionGap,
  });
}
