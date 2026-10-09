import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/protection_continutity_type.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:flutter/material.dart';

enum ProtectionType { death, criticalIllness, disability }

extension ProtectionTypeX on ProtectionType {
  String get label {
    switch (this) {
      case ProtectionType.death:
        return 'Death Benefit';

      case ProtectionType.criticalIllness:
        return 'Critical Illness';

      case ProtectionType.disability:
        return 'Disability';
    }
  }

  String get shortLabel {
    switch (this) {
      case ProtectionType.death:
        return 'Death';

      case ProtectionType.criticalIllness:
        return 'Critical Illness';

      case ProtectionType.disability:
        return 'Disability';
    }
  }

  PhosphorIconData get icon {
    switch (this) {
      case ProtectionType.death:
        return PhosphorIconsRegular.heart;

      case ProtectionType.criticalIllness:
        return PhosphorIconsRegular.hospital;

      case ProtectionType.disability:
        return PhosphorIconsRegular.wheelchair;
    }
  }

  Color get color {
    switch (this) {
      case ProtectionType.death:
        return const Color(0xFF9B8AFB); // Violet
      case ProtectionType.criticalIllness:
        return const Color(0xFF45B8AC); // Teal
      case ProtectionType.disability:
        return const Color(0xFF6EA8FE); // Blue
    }
  }

  ProtectionContinuityType get continuityType {
    switch (this) {
      case ProtectionType.death:
        return ProtectionContinuityType.dependentExpenses;

      case ProtectionType.criticalIllness:
      case ProtectionType.disability:
        return ProtectionContinuityType.lifestyleExpenses;
    }
  }
}
