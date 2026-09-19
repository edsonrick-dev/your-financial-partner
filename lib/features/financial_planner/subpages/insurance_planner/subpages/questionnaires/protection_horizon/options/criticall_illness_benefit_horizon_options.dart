import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/questionnaires/protection_horizon/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/questionnaires/protection_horizon/models/protection_horizon_option.dart';

const criticalIllnessHorizonOptions = [
  ProtectionHorizonOption(
    horizon: ProtectionHorizon.one,
    description: 'Focuses on the acute treatment and initial recovery period.',
    whenToChoose: '...',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.three,
    description:
        'A solid buffer for recovery, including longer-term treatment.',
    whenToChoose: '...',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.five,
    description: 'A comprehensive buffer for a full recovery.',
    whenToChoose: '...',
  ),

  ProtectionHorizonOption(
    horizon: ProtectionHorizon.ten,
    description: 'Maximum protection for a prolonged recovery.',
    whenToChoose: '...',
  ),
];
