import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class ProtectionScoreContainerSection
    extends GetView<FinancialPlannerController> {
  const ProtectionScoreContainerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSection(
      child: Container(
        padding: EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.text, colorScheme.gradient2],
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text(
              'Protection Score',
              style: AppTextStyle.titleL.copyWith(
                color: colorScheme.appInversedtextMuted,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Underinsured',
                  style: AppTextStyle.displayL.copyWith(
                    color: colorScheme.inversePrimary,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  '2 of 3 essential protection goals are not yet met.',
                  style: AppTextStyle.labelM.copyWith(
                    color: colorScheme.inversePrimary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
