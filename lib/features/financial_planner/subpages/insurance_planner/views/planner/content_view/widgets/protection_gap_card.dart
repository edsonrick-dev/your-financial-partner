import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/enums/protection_gap_severity_enum.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class ProtectionGapCard extends StatelessWidget {
  final IconData icon;
  final String gapTitle;
  final double amountCovered;
  final double amountNeed;
  final VoidCallback? onTap;
  final bool isCompleted;

  const ProtectionGapCard({
    super.key,
    required this.icon,
    required this.gapTitle,
    required this.amountCovered,
    required this.amountNeed,
    this.isCompleted = false,
    this.onTap,
  });
  bool get hasNoNeed => amountNeed <= 0;

  double get gapAmount {
    if (hasNoNeed) return 0;
    return (amountNeed - amountCovered).clamp(0.0, double.infinity);
  }

  double get coveragePercentage {
    if (hasNoNeed) return 100;
    return (amountCovered / amountNeed * 100).clamp(0.0, 100.0);
  }

  ProtectionGapSeverity get severity => getProtectionGapSeverity(
    amountCovered: amountCovered,
    amountNeed: amountNeed,
  );

  bool get isWellCovered => severity == ProtectionGapSeverity.covered;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final severityColor = severity.color;
    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon),

              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      gapTitle,
                      style: AppTextStyle.titleL,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (!isCompleted)
                      Text(
                        'Tap to take assessment',
                        style: AppTextStyle.bodyM.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),
                  ],
                ),
              ),

              if (isCompleted) ...[
                const SizedBox(width: 12),

                if (hasNoNeed || isWellCovered)
                  Text(
                    '✓ Well Protected',
                    style: AppTextStyle.titleM.copyWith(
                      color: Colors.green.shade700,
                    ),
                  )
                else
                  Text(
                    gapAmount.toCompactCurrency(kThreshold: 100000),
                    style: AppTextStyle.amountL,
                  ),
              ],
            ],
          ),

          if (isCompleted) ...[
            const SizedBox(height: 8),
            if (hasNoNeed) ...[
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'No protection need identified in your assessment.',
                  style: AppTextStyle.bodyM,
                ),
              ),
            ] else if (isWellCovered && amountCovered > amountNeed) ...[
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  'Insurance sources cover your insurance needs',
                  style: AppTextStyle.bodyM.copyWith(),
                ),
              ),
            ] else
              FittedBox(
                fit: BoxFit.scaleDown,
                child: RichText(
                  text: TextSpan(
                    style: AppTextStyle.amountM.copyWith(
                      color: colorScheme.appTextMuted,
                    ),
                    children: [
                      TextSpan(
                        text: amountCovered.toCurrency(),
                        style: TextStyle(color: colorScheme.appText),
                      ),
                      TextSpan(
                        text: ' covered out of ',
                        style: AppTextStyle.bodyM,
                      ),
                      TextSpan(text: amountNeed.toCurrency()),
                    ],
                  ),
                ),
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
                      valueColor: AlwaysStoppedAnimation(
                        severityColor(context),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                SizedBox(
                  width: 52,
                  child: Text(
                    '${coveragePercentage.toStringAsFixed(1)}%',
                    textAlign: TextAlign.right,
                    style: AppTextStyle.amountS.copyWith(
                      color: severityColor(context),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
