import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class InvestmentPlanSection extends StatelessWidget {
  const InvestmentPlanSection({super.key});

  @override
  Widget build(BuildContext context) {
    final targetInvestment = 180000.0;
    final currentInvestment = 80000.0;
    final remainingAmount = (targetInvestment - currentInvestment).clamp(
      0.0,
      double.infinity,
    );
    final completionRate = targetInvestment > 0
        ? currentInvestment / targetInvestment
        : 0.0;
    final colorScheme = context.colors;
    return AppSection(
      child: AppSectionBody(
        padding: 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('2026 Investment Target', style: AppTextStyle.titleL),

            SizedBox(height: 16),

            LinearProgressIndicator(
              value: completionRate,
              minHeight: 8,
              borderRadius: BorderRadius.circular(10),
              backgroundColor: colorScheme.appText.withAlpha(40),
              // valueColor: AlwaysStoppedAnimation(statusColor),
            ),

            SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Invested so far",
                        style: AppTextStyle.bodyS.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),
                      Text(
                        currentInvestment.toCurrency(),
                        style: AppTextStyle.amountL,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Target invested",
                        style: AppTextStyle.bodyS.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),
                      Text(
                        targetInvestment.toCurrency(),
                        style: AppTextStyle.amountL,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Column(
              spacing: 4,
              children: [
                Divider(),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Remaining",
                        style: AppTextStyle.bodyM.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          remainingAmount.toCurrency(),
                          style: AppTextStyle.amountL,
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
