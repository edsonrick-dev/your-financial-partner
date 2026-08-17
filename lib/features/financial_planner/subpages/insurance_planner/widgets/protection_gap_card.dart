import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/enums/protection_gap_severity_enum.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

class ProtectionGapCard extends StatelessWidget {
  final IconData icon;
  final String gapTitle;
  final double amountCovered;
  final double amountNeed;
  final VoidCallback? onTap;

  const ProtectionGapCard({
    super.key,
    required this.icon,
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
      child: Container(
        padding: const EdgeInsets.all(8),
        constraints: const BoxConstraints(minHeight: 44),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: colorScheme.bgLight,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
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
