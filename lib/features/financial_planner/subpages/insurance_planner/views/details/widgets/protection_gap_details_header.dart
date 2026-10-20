import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/enums/protection_gap_severity_enum.dart';
import 'package:getx_drift_app/core/num_extension.dart';

class ProtectionGapDetailsHeader extends StatelessWidget {
  final double protectionNeed;
  final double protectionSource;
  final ProtectionGapSeverity severity;

  const ProtectionGapDetailsHeader({
    super.key,
    required this.protectionNeed,
    required this.protectionSource,
    required this.severity,
  });

  double get benefitGap {
    return (protectionNeed - protectionSource).clamp(0, double.infinity);
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Column(
      children: [
        Text(
          benefitGap.toCurrency(),
          style: AppTextStyle.amountXL.copyWith(
            color: colorScheme.appInversedtext,
          ),
        ),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 12),
          decoration: BoxDecoration(
            color: severity.softColor,
            borderRadius: BorderRadius.circular(999),
            border: Border.all(color: severity.color),
          ),
          child: Text(
            severity.label,
            style: AppTextStyle.titleM.copyWith(color: severity.color),
          ),
        ),
        SizedBox(height: 16),
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
