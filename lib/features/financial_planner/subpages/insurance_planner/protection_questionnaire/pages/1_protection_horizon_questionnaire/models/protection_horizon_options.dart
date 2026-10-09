import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/death_benefit_horizon_options.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/2_critical_illness_benefit/criticall_illness_benefit_horizon_options.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/3_disability_benefit/disability_benefit_horizon_optons.dart';

import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';

const protectionHorizonOptions = {
  ProtectionType.death: deathBenefitHorizonOptions,
  ProtectionType.criticalIllness: criticalIllnessHorizonOptions,
  ProtectionType.disability: disabilityHorizonOptions,
};
