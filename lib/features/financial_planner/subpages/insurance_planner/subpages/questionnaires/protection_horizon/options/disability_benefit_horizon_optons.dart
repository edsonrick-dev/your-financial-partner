import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/questionnaires/protection_horizon/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/questionnaires/protection_horizon/models/protection_horizon_option.dart';

const disabilityHorizonOptions = [
  ProtectionHorizonOption(
    horizon: ProtectionHorizon.two,
    description: 'A short-term safety net for recovery and rehabilitation.',
    whenToChoose: '...',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.five,
    description:
        'A substantial period for retraining, adjusting your lifestyle, and recovering.',
    whenToChoose: '...',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.ten,
    description: 'A long-term solution for extended financial security.',
    whenToChoose: '...',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.untilRetirement,
    description: 'Complete, long-term security until your expected retirement.',
    whenToChoose: '...',
  ),
];
