import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/widgets/requirement_row.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class EmptyLifestyleCoverageView extends GetView<FinancialProfileController> {
  const EmptyLifestyleCoverageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        // ---------------------------------------------------------------
        // EMPTY SUMMARY
        // ---------------------------------------------------------------
        AppSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Lifestyle Coverage', style: AppTextStyle.headlineL),

              const SizedBox(height: 12),

              Text(
                'Your lifestyle coverage cannot be assessed yet.',
                style: AppTextStyle.bodyM,
              ),

              const SizedBox(height: 8),

              Text(
                'Add your net worth and set a planned lifestyle budget '
                'to see how long your current financial position could '
                'support your lifestyle.',
                style: AppTextStyle.bodyM.copyWith(
                  color: context.colors.appTextMuted,
                ),
              ),
            ],
          ),
        ),

        // ---------------------------------------------------------------
        // REQUIREMENTS
        // ---------------------------------------------------------------
        AppSection(
          sectionTitle: 'What you need',
          child: AppSectionBody(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  RequirementRow(
                    label: 'Net worth',
                    isComplete: controller.hasNetWorth,
                  ),

                  const SizedBox(height: 10),

                  RequirementRow(
                    label: 'Budget plan',
                    isComplete: controller.hasBudget,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
