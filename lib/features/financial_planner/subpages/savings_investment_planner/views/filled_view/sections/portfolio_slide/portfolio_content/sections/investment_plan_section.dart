import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class InvestmentPlanSection extends StatelessWidget {
  const InvestmentPlanSection({
    super.key,
    required this.targetInvestment,
    required this.currentInvestment,
  });

  final double targetInvestment;
  final double currentInvestment;

  @override
  Widget build(BuildContext context) {
    final remainingAmount = (targetInvestment - currentInvestment).clamp(
      0.0,
      double.infinity,
    );

    final completionRate = targetInvestment > 0
        ? (currentInvestment / targetInvestment).clamp(0.0, 1.0)
        : 0.0;

    final colorScheme = context.colors;

    return AppSection(
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppGradient.gradientA(colorScheme),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '2026 Investment Target',
              style: AppTextStyle.titleL.copyWith(
                color: colorScheme.appInversedtextMuted,
              ),
            ),
            SizedBox(height: 16),
            LinearProgressIndicator(
              value: completionRate,
              minHeight: 8,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: colorScheme.appInversedtext.withAlpha(40),
              color: colorScheme.appAccent,
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Invested so far',
                        style: AppTextStyle.bodyS.copyWith(
                          color: colorScheme.appInversedtextMuted,
                        ),
                      ),
                      Text(
                        currentInvestment.toCurrency(),
                        style: AppTextStyle.amountL.copyWith(
                          color: colorScheme.appInversedtext,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Target invested',
                        style: AppTextStyle.bodyS.copyWith(
                          color: colorScheme.appInversedtextMuted,
                        ),
                      ),
                      Text(
                        targetInvestment.toCurrency(),
                        style: AppTextStyle.amountL.copyWith(
                          color: colorScheme.appInversedtext,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              spacing: 4,
              children: [
                Divider(color: colorScheme.appInversedtext),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Remaining',
                        style: AppTextStyle.bodyM.copyWith(
                          color: colorScheme.appInversedtextMuted,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          remainingAmount.toCurrency(),
                          style: AppTextStyle.amountL.copyWith(
                            color: colorScheme.appInversedtext,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
