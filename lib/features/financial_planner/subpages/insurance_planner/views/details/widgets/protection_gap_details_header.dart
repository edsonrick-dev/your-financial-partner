import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/enums/protection_gap_severity_enum.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/protection_types.dart';

class ProtectionGapDetailsHeader extends StatelessWidget {
  final double protectionNeed;
  final double protectionSource;
  final ProtectionGapSeverity severity;
  final ProtectionType type;

  /// True when all required needs have been configured.
  final bool isCompleted;

  /// True when at least one protection source exists.
  final bool hasSources;

  const ProtectionGapDetailsHeader({
    super.key,
    required this.protectionNeed,
    required this.protectionSource,
    required this.severity,
    required this.type,
    this.isCompleted = false,
    this.hasSources = false,
  });

  /// A gap is meaningful only when needs are configured and sources exist.
  double get benefitGap {
    if (!isCompleted || !hasSources) return 0;

    return (protectionNeed - protectionSource).clamp(0.0, double.infinity);
  }

  ProtectionGapSeverity get effectiveSeverity {
    // No protection need means there is no protection gap.
    if (protectionNeed <= 0) {
      return ProtectionGapSeverity.covered;
    }

    // Existing sources fully cover the assessed need.
    if (protectionSource >= protectionNeed) {
      return ProtectionGapSeverity.covered;
    }

    // Otherwise, preserve the calculated severity.
    return severity;
  }

  Widget _buildStatus({
    required BuildContext context,
    required String label,
    required Color color,
    required IconData icon,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: color),
        const SizedBox(width: 6),
        Text(label, style: AppTextStyle.titleM.copyWith(color: color)),
      ],
    );
  }

  Widget _buildAssessmentStatus(BuildContext context) {
    final colorScheme = context.colors;

    if (!isCompleted) {
      return _buildStatus(
        context: context,
        label: 'Assessment incomplete',
        color: colorScheme.appOutflowInversed,
        icon: Icons.info_outline,
      );
    }

    if (!hasSources) {
      return _buildStatus(
        context: context,
        label: 'Sources not configured',
        color: colorScheme.appOutflowInversed,
        icon: Icons.info_outline,
      );
    }

    return _buildStatus(
      context: context,
      label: 'Sources configured',
      color: colorScheme.appInflowInverse,
      icon: Icons.check_circle_outline,
    );
  }

  Widget _buildSeverityBadge(BuildContext context) {
    final displaySeverity = effectiveSeverity;
    final color = displaySeverity.inversedColor(context);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color),
      ),
      child: Text(
        displaySeverity.label,
        style: AppTextStyle.titleM.copyWith(color: color),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Column(
      children: [
        // Display a gap only when both needs and sources are configured.
        if (benefitGap > 0) ...[
          Text(
            benefitGap.toCurrency(),
            style: AppTextStyle.amountXL.copyWith(
              color: colorScheme.appInversedtext,
            ),
          ),
          const SizedBox(height: 8),
        ],

        // Show assessment status when needs are incomplete or sources are absent.
        if (!isCompleted || !hasSources) _buildAssessmentStatus(context),

        // Show severity only when the assessment and sources are configured.
        if (isCompleted && hasSources) ...[_buildSeverityBadge(context)],

        const SizedBox(height: 16),

        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Text(
                    protectionNeed.toCurrency(),
                    style: AppTextStyle.amountL.copyWith(
                      color: colorScheme.appInversedtext,
                    ),
                  ),
                  Text(
                    'Protection Need',
                    style: AppTextStyle.titleM.copyWith(
                      color: colorScheme.appInversedtextMuted,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Text(
                    protectionSource.toCurrency(),
                    style: AppTextStyle.amountL.copyWith(
                      color: colorScheme.appInversedtext,
                    ),
                  ),
                  Text(
                    'Protection Source',
                    style: AppTextStyle.titleM.copyWith(
                      color: colorScheme.appInversedtextMuted,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
