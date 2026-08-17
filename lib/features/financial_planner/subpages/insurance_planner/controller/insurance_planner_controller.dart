import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/enums/protection_gap_severity_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/enums/protection_profile_enum.dart';

class InsurancePlannerController extends GetxController {
  // Protection amounts
  final deathBenefitCovered = 1000000.0.obs;
  final deathBenefitNeed = 2000000.0.obs;

  final criticalIllnessCovered = 500000.0.obs;
  final criticalIllnessNeed = 1000000.0.obs;

  final disabilityCovered = 1500000.0.obs;
  final disabilityNeed = 1500000.0.obs;
  ProtectionGapSeverity get deathBenefitSeverity => getProtectionGapSeverity(
    amountCovered: deathBenefitCovered.value,
    amountNeed: deathBenefitNeed.value,
  );

  ProtectionGapSeverity get criticalIllnessSeverity => getProtectionGapSeverity(
    amountCovered: criticalIllnessCovered.value,
    amountNeed: criticalIllnessNeed.value,
  );

  ProtectionGapSeverity get disabilitySeverity => getProtectionGapSeverity(
    amountCovered: disabilityCovered.value,
    amountNeed: disabilityNeed.value,
  );

  ProtectionProfile get protectionProfile {
    return getProtectionProfile([
      deathBenefitSeverity,
      criticalIllnessSeverity,
      disabilitySeverity,
    ]);
  }

  int get unmetProtectionGoals {
    return [
      deathBenefitSeverity,
      criticalIllnessSeverity,
      disabilitySeverity,
    ].where((severity) => severity != ProtectionGapSeverity.covered).length;
  }
  // Recommendations
  // policies, filtering, selected policy, etc.

  // Protection score
  // calculations and severity classification
}
