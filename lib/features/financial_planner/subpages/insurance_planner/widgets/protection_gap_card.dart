import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

class ProtectionGapCard extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String gapTitle;
  final double amountCovered;
  final double amountNeed;
  final VoidCallback? onTap;

  const ProtectionGapCard({
    super.key,
    required this.icon,
    required this.color,
    required this.gapTitle,
    required this.amountCovered,
    required this.amountNeed,
    this.onTap,
  });

  double get gapAmount {
    return (amountNeed - amountCovered).clamp(0, double.infinity);
  }

  double get coveragePercentage {
    if (amountNeed <= 0) return 0;

    return (amountCovered / amountNeed * 100).clamp(0, 100);
  }

  ProtectionGapSeverity get severity {
    final coverage = coveragePercentage;

    if (coverage >= 95) {
      return ProtectionGapSeverity.covered;
    }

    if (coverage >= 50) {
      return ProtectionGapSeverity.partial;
    }

    return ProtectionGapSeverity.critical;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final severityColor = severity.color;
    return AdaptivePressable(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minHeight: 44),
        child: Row(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0.2,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: severityColor,
                    ),
                  ),
                ),
                Icon(icon, color: severityColor),
              ],
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          gapTitle,
                          style: AppTextStyle.titleM,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        gapAmount.toCompactCurrency(kThreshold: 10000000),
                        style: AppTextStyle.amountM,
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: LinearProgressIndicator(
                            value: coveragePercentage / 100,
                            minHeight: 8,
                            backgroundColor: colorScheme.bgDark,
                            valueColor: AlwaysStoppedAnimation(severityColor),
                          ),
                        ),
                      ),

                      const SizedBox(width: 8),

                      SizedBox(
                        width: 40,
                        child: Text(
                          '${coveragePercentage.toStringAsFixed(0)}%',
                          textAlign: TextAlign.right,
                          style: AppTextStyle.amountS.copyWith(
                            color: severityColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  RichText(
                    text: TextSpan(
                      style: AppTextStyle.bodyS.copyWith(
                        color: colorScheme.textMuted,
                      ),
                      children: [
                        TextSpan(
                          text: amountCovered.toCurrency(),
                          style: AppTextStyle.bodyS.copyWith(
                            color: colorScheme.text,
                          ),
                        ),
                        const TextSpan(text: ' covered out of '),
                        TextSpan(
                          text: amountNeed.toCurrency(),
                          style: AppTextStyle.bodyS.copyWith(
                            color: colorScheme.text,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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

  String get label {
    switch (this) {
      case ProtectionGapSeverity.critical:
        return 'Critical Gap';

      case ProtectionGapSeverity.partial:
        return 'Partial Coverage';

      case ProtectionGapSeverity.covered:
        return 'Fully Covered';
    }
  }
}

class ProtectionScore {
  final String title;
  final String description;
  final Color color;

  const ProtectionScore({
    required this.title,
    required this.description,
    required this.color,
  });

  static const financiallySecured = ProtectionScore(
    title: 'Financially Secured',
    description: 'All essential protection goals are covered.',
    color: Color(0xFF16A34A),
  );

  static const almostSecured = ProtectionScore(
    title: 'Almost Secured',
    description: 'Your protection is strong with only minor gaps.',
    color: Color(0xFFCA8A04),
  );

  static const moderatelyProtected = ProtectionScore(
    title: 'Moderately Protected',
    description:
        'Your protection is established but still has room to improve.',
    color: Color(0xFFCA8A04),
  );

  static const unevenProtection = ProtectionScore(
    title: 'Uneven Protection',
    description:
        'Some protection areas are strong while others remain exposed.',
    color: Color(0xFFF97316),
  );

  static const vulnerableCoverage = ProtectionScore(
    title: 'Vulnerable Coverage',
    description: 'Your protection has significant gaps across key areas.',
    color: Color(0xFFF97316),
  );

  static const financiallyExposed = ProtectionScore(
    title: 'Financially Exposed',
    description: 'Your protection is insufficient across all key areas.',
    color: Color(0xFFDC2626),
  );
}

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
