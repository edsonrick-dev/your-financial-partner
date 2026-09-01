import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_debt_load_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_emergency_fund_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_lifestyle_coverage_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_wealth_building_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/financial_score_disclaimer_section.dart';
import 'package:getx_drift_app/features/profile/widgets/requirement_row.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class EmptyStabilityLevelView extends GetView<FinancialProfileController> {
  const EmptyStabilityLevelView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Column(
      spacing: 20,
      children: [
        // -------------------------------------------------------------------
        // SUMMARY
        // -------------------------------------------------------------------
        AppSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Financial Stability', style: AppTextStyle.headlineL),

              const SizedBox(height: 12),

              Text(
                'Your financial stability cannot be assessed yet.',
                style: AppTextStyle.bodyM,
              ),

              const SizedBox(height: 8),

              Text(
                'Complete all four financial assessments to see '
                'your overall financial stability.',
                style: AppTextStyle.bodyM.copyWith(
                  color: colorScheme.appTextMuted,
                ),
              ),
            ],
          ),
        ),

        // -------------------------------------------------------------------
        // REQUIREMENTS
        // -------------------------------------------------------------------
        AppSection(
          sectionTitle: 'What you need',
          child: AppSectionBody(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  RequirementRow(
                    label: 'Debt Load',
                    isComplete: controller.canAssessDebtLoad,
                  ),

                  const SizedBox(height: 12),

                  RequirementRow(
                    label: 'Wealth Building',
                    isComplete: controller.canAssessWealthBuilding,
                  ),

                  const SizedBox(height: 12),

                  RequirementRow(
                    label: 'Emergency Fund',
                    isComplete: controller.canAssessEmergencyFund,
                  ),

                  const SizedBox(height: 12),

                  RequirementRow(
                    label: 'Lifestyle Coverage',
                    isComplete: controller.canAssessLifestyleCoverage,
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
