import 'package:flutter/material.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/enum/finanical_ratio_type_enum.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';

class FinancialRatioCard extends StatelessWidget {
  final FinancialRatio ratio;
  final VoidCallback? onTap;

  const FinancialRatioCard({super.key, required this.ratio, this.onTap});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final displayValue = ratio.displayValue ?? ratio.value;

    return AdaptivePressable(
      onTap: () {
        AppSheets.viewStabilityProfileDetails(ratio.type);
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: colorScheme.text.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 48,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      ratio.type.displayName,
                      style: AppTextStyle.titleL,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),
            Text(
              ratio.type.formatValue(displayValue!),
              style: AppTextStyle.headlineM,
            ),

            const Spacer(),
            Text(
              ratio.scoreBand.category,
              style: AppTextStyle.bodyS.copyWith(color: ratio.scoreBand.color),
            ),
            const SizedBox(height: 4),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: ratio.scoreBand.color,
                borderRadius: BorderRadius.circular(99),
              ),
              child: Text(
                '${ratio.normalizedPoints} pts',
                style: AppTextStyle.labelM.copyWith(color: colorScheme.bgLight),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
