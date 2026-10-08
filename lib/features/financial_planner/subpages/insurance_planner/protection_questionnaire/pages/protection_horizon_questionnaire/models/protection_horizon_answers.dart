import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';

class ProtectionHorizonAnswers {
  final ProtectionHorizon death;
  final ProtectionHorizon criticalIllness;
  final ProtectionHorizon disability;

  const ProtectionHorizonAnswers({
    required this.death,
    required this.criticalIllness,
    required this.disability,
  });
}
