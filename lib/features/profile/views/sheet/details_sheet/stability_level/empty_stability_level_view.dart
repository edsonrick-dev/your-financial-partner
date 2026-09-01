import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_debt_load_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_emergency_fund_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_lifestyle_coverage_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_wealth_building_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_details_empty_header.dart';
import 'package:getx_drift_app/features/profile/widgets/requirement_row.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class EmptyStabilityLevelView extends GetView<FinancialProfileController> {
  const EmptyStabilityLevelView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        // -------------------------------------------------------------------
        // SUMMARY
        // -------------------------------------------------------------------
        AppSection(
          child: FinancialDetailsEmptyHeader(
            text: 'Financial Stability',
            description: 'Your financial stability cannot be assessed yet.',
            instruction:
                'Complete all four financial assessments to see '
                'your overall financial stability.',
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
