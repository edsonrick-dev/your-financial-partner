import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/subpages/questionnaires/protection_horizon/models/protection_horizon_option.dart';

const disabilityHorizonOptions = [
  ProtectionHorizonOption(
    horizon: ProtectionHorizon.two,
    description:
        'Provides a short-term financial safety net while you recover or adjust.',
    whenToChoose:
        'Suitable when you expect to have other resources or benefits available after the initial period.',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.five,
    description:
        'Provides financial support for an extended period of disability.',
    whenToChoose:
        'Suitable when returning to your previous level of income may take several years.',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.ten,
    description: 'Provides long-term financial support during disability.',
    whenToChoose:
        'Suitable when you want substantial protection against prolonged loss of earning capacity.',
  ),

  ProtectionHorizonOption(
    isRecommended: true,
    horizon: ProtectionHorizon.untilRetirement,
    description:
        'Provides financial support until your expected retirement age.',
    whenToChoose:
        'Suitable when a long-term disability could permanently affect your ability to earn income.',
  ),
];
