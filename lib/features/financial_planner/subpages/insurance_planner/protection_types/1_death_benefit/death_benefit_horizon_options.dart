import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/subpages/questionnaires/protection_horizon/models/protection_horizon_option.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/2_critical_illness_benefit/criticall_illness_benefit_horizon_options.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/3_disability_benefit/disability_benefit_horizon_optons.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';

const deathBenefitHorizonOptions = [
  ProtectionHorizonOption(
    horizon: ProtectionHorizon.zero,
    description: 'No ongoing financial support for your dependents.',
    whenToChoose: 'Choose this if you have no financial dependents.',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.five,
    description:
        'Provides financial support for your dependents for 5 years after the plan period.',
    whenToChoose:
        'Choose this if your dependents are expected to become financially independent within a relatively short period.',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.ten,
    isRecommended: true,
    description:
        'Provides financial support for your dependents for 10 years after the plan period.',
    whenToChoose:
        'Choose this if your dependents are expected to need financial support for several years.',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.fifteen,
    description:
        'Provides financial support for your dependents for 15 years after the plan period.',
    whenToChoose:
        'Choose this if your dependents are expected to need support for a longer period.',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.twenty,
    description:
        'Provides financial support for your dependents for 20 years after the plan period.',
    whenToChoose:
        'Choose this if your dependents are expected to remain financially dependent for an extended period.',
  ),
];
