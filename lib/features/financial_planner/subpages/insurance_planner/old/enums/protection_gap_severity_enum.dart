import 'package:flutter/animation.dart';

enum ProtectionGapSeverity { critical, partial, covered }

ProtectionGapSeverity getProtectionGapSeverity({
  required double amountCovered,
  required double amountNeed,
}) {
  if (amountNeed <= 0) {
    return ProtectionGapSeverity.critical;
  }

  final coverage = (amountCovered / amountNeed * 100).clamp(0, 100);

  if (coverage >= 95) {
    return ProtectionGapSeverity.covered;
  }

  if (coverage >= 50) {
    return ProtectionGapSeverity.partial;
  }

  return ProtectionGapSeverity.critical;
}

extension ProtectionGapSeverityX on ProtectionGapSeverity {
  Color get color {
    switch (this) {
      case ProtectionGapSeverity.critical:
        return const Color(0xFFDC2626);

      case ProtectionGapSeverity.partial:
        return const Color(0xFFEA580C);

      case ProtectionGapSeverity.covered:
        return const Color(0xFF059669);
    }
  }

  Color get softColor {
    return color.withValues(alpha: 0.0);
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
