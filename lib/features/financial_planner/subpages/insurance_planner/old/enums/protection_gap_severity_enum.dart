import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

enum ProtectionGapSeverity { critical, partial, covered }

ProtectionGapSeverity getProtectionGapSeverity({
  required double amountCovered,
  required double amountNeed,
}) {
  if (amountNeed <= 0) {
    return ProtectionGapSeverity.critical;
  }

  // Fully covered when coverage meets or exceeds the need.
  if (amountCovered >= amountNeed) {
    return ProtectionGapSeverity.covered;
  }

  final coverage = amountCovered / amountNeed * 100;

  if (coverage >= 95) {
    return ProtectionGapSeverity.covered;
  }

  if (coverage >= 50) {
    return ProtectionGapSeverity.partial;
  }

  return ProtectionGapSeverity.critical;
}

extension ProtectionGapSeverityX on ProtectionGapSeverity {
  Color color(BuildContext context) {
    switch (this) {
      case ProtectionGapSeverity.critical:
        return context.colors.appOutflow;

      case ProtectionGapSeverity.partial:
        return context.colors.appAccent;

      case ProtectionGapSeverity.covered:
        return context.colors.appInflow;
    }
  }

  Color inversedColor(BuildContext context) {
    switch (this) {
      case ProtectionGapSeverity.critical:
        return context.colors.appOutflowInversed;

      case ProtectionGapSeverity.partial:
        return context.colors.appAccent;

      case ProtectionGapSeverity.covered:
        return context.colors.appInflowInverse;
    }
  }

  Color softColor(BuildContext context) {
    return color(context).withValues(alpha: 0.12);
  }

  String get label {
    switch (this) {
      case ProtectionGapSeverity.critical:
        return 'Protection Critical';

      case ProtectionGapSeverity.partial:
        return 'Partially Covered';

      case ProtectionGapSeverity.covered:
        return 'Fully Covered';
    }
  }
}
