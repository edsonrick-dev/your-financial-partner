import 'package:flutter/animation.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/enums/protection_gap_severity_enum.dart';

enum ProtectionProfile {
  financiallySecured,
  almostSecured,
  moderatelyProtected,
  unevenProtection,
  vulnerableCoverage,
  financiallyExposed,
}

ProtectionProfile getProtectionProfile(List<ProtectionGapSeverity> severities) {
  if (severities.length != 3) {
    throw ArgumentError('Exactly 3 protection severities are required.');
  }

  final criticalCount = severities
      .where((s) => s == ProtectionGapSeverity.critical)
      .length;

  final partialCount = severities
      .where((s) => s == ProtectionGapSeverity.partial)
      .length;

  final coveredCount = severities
      .where((s) => s == ProtectionGapSeverity.covered)
      .length;

  if (coveredCount == 3) {
    return ProtectionProfile.financiallySecured;
  }

  if (criticalCount == 3) {
    return ProtectionProfile.financiallyExposed;
  }

  if (partialCount == 3) {
    return ProtectionProfile.moderatelyProtected;
  }

  if (criticalCount > 0 && partialCount > 0 && coveredCount > 0) {
    return ProtectionProfile.unevenProtection;
  }

  if (criticalCount > 0 && partialCount > 0) {
    return ProtectionProfile.vulnerableCoverage;
  }

  if (coveredCount > 0 && partialCount > 0) {
    return ProtectionProfile.almostSecured;
  }

  if (criticalCount > 0 && coveredCount > 0) {
    return ProtectionProfile.unevenProtection;
  }

  return ProtectionProfile.moderatelyProtected;
}

extension ProtectionProfileX on ProtectionProfile {
  String get title {
    switch (this) {
      case ProtectionProfile.financiallySecured:
        return 'Financially Secured';

      case ProtectionProfile.almostSecured:
        return 'Almost Secured';

      case ProtectionProfile.moderatelyProtected:
        return 'Moderately Protected';

      case ProtectionProfile.unevenProtection:
        return 'Uneven Protection';

      case ProtectionProfile.vulnerableCoverage:
        return 'Vulnerable Coverage';

      case ProtectionProfile.financiallyExposed:
        return 'Financially Exposed';
    }
  }

  Color get color {
    switch (this) {
      case ProtectionProfile.financiallySecured:
        return const Color(0xFF16A34A);

      case ProtectionProfile.almostSecured:
      case ProtectionProfile.moderatelyProtected:
        return const Color(0xFFCA8A04);

      case ProtectionProfile.unevenProtection:
      case ProtectionProfile.vulnerableCoverage:
        return const Color(0xFFF97316);

      case ProtectionProfile.financiallyExposed:
        return const Color(0xFFDC2626);
    }
  }
}
