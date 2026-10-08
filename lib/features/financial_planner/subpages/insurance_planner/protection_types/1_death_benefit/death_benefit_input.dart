import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';

class DeathBenefitInput {
  final ProtectionHorizon horizon;

  final double monthlyDependentExpenses;

  final double estateSettlementFund;
  final double liabilities;
  final double dependentsFutureNeeds;
  final double finalExpenses;

  final double eligibleExistingResources;
  final double existingDeathCoverage;

  final int currentAge;
  final int retirementAge;

  const DeathBenefitInput({
    required this.horizon,
    required this.monthlyDependentExpenses,
    required this.estateSettlementFund,
    required this.liabilities,
    required this.dependentsFutureNeeds,
    required this.finalExpenses,
    required this.eligibleExistingResources,
    required this.existingDeathCoverage,
    required this.currentAge,
    required this.retirementAge,
  });
}
