import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/subpages/questionnaires/protection_horizon/models/protection_horizon_option.dart';

const criticalIllnessHorizonOptions = [
  ProtectionHorizonOption(
    horizon: ProtectionHorizon.one,
    description:
        'Provides financial support for the initial treatment and recovery period.',
    whenToChoose:
        'Suitable if you have sufficient resources to handle longer-term financial disruption.',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.three,
    description:
        'Provides financial support through an extended period of treatment and recovery.',
    whenToChoose:
        'Suitable if a prolonged interruption to your income could make it difficult to maintain your lifestyle and meet financial obligations.',
  ),

  ProtectionHorizonOption(
    isRecommended: true,
    horizon: ProtectionHorizon.five,
    description:
        'Provides a longer financial buffer for treatment, recovery, and continued lifestyle expenses.',
    whenToChoose:
        'Suitable if you want stronger protection against the financial impact of a serious illness lasting several years.',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.ten,
    description:
        'Provides long-term financial support for an extended period following a critical illness.',
    whenToChoose:
        'Suitable if you want substantial protection against prolonged treatment, recovery, or reduced earning capacity.',
  ),
];
