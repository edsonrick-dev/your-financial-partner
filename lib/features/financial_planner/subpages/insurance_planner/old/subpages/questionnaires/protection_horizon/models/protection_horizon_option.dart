import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';

class ProtectionHorizonOption {
  final ProtectionHorizon horizon;
  final String description;
  final String whenToChoose;
  final bool isRecommended;
  const ProtectionHorizonOption({
    required this.horizon,
    required this.description,
    required this.whenToChoose,
    this.isRecommended = false,
  });
}
