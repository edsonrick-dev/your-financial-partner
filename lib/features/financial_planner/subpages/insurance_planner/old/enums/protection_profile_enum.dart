import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/enums/protection_gap_severity_enum.dart';

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

  final almostCount = severities
      .where((s) => s == ProtectionGapSeverity.almost)
      .length;

  final coveredCount = severities
      .where((s) => s == ProtectionGapSeverity.covered)
      .length;

  // All three protection areas are fully covered.
  if (coveredCount == 3) {
    return ProtectionProfile.financiallySecured;
  }

  // All three protection areas have critical gaps.
  if (criticalCount == 3) {
    return ProtectionProfile.financiallyExposed;
  }

  // All three protection areas have partial gaps.
  if (partialCount == 3) {
    return ProtectionProfile.moderatelyProtected;
  }

  // No critical gaps, and all areas are almost or fully covered.
  if (criticalCount == 0 &&
      partialCount == 0 &&
      almostCount + coveredCount == 3) {
    return ProtectionProfile.almostSecured;
  }

  // A mixture of critical gaps, partial gaps, and fully covered areas.
  if (criticalCount > 0 && partialCount > 0 && coveredCount > 0) {
    return ProtectionProfile.unevenProtection;
  }

  // At least one critical gap and one partial gap.
  if (criticalCount > 0 && partialCount > 0) {
    return ProtectionProfile.vulnerableCoverage;
  }

  // Critical gaps exist alongside almost or fully covered areas.
  if (criticalCount > 0 &&
      partialCount == 0 &&
      (almostCount > 0 || coveredCount > 0)) {
    return ProtectionProfile.unevenProtection;
  }

  // Partial gaps exist alongside almost or fully covered areas.
  if (partialCount > 0 &&
      criticalCount == 0 &&
      (almostCount > 0 || coveredCount > 0)) {
    return ProtectionProfile.almostSecured;
  }

  // All three areas are almost covered.
  if (almostCount == 3) {
    return ProtectionProfile.almostSecured;
  }

  // Remaining combinations include mixed protection levels.
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

  int get points {
    switch (this) {
      case ProtectionProfile.financiallySecured:
        return 20;

      case ProtectionProfile.almostSecured:
        return 15;

      case ProtectionProfile.moderatelyProtected:
        return 10;

      case ProtectionProfile.unevenProtection:
        return 10;

      case ProtectionProfile.vulnerableCoverage:
        return 5;

      case ProtectionProfile.financiallyExposed:
        return 0;
    }
  }

  Color color(BuildContext context) {
    final colorScheme = context.colors;
    switch (this) {
      case ProtectionProfile.financiallySecured:
        return colorScheme.appInflowInverse;

      case ProtectionProfile.almostSecured:
      case ProtectionProfile.moderatelyProtected:
        return colorScheme.appAccent;

      case ProtectionProfile.unevenProtection:
      case ProtectionProfile.vulnerableCoverage:
        return colorScheme.appNeutral;

      case ProtectionProfile.financiallyExposed:
        return colorScheme.appOutflowInversed;
    }
  }
}
