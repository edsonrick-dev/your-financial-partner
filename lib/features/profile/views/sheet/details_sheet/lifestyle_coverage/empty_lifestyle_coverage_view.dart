import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_details_empty_header.dart';
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
        AppSection(
          child: FinancialDetailsEmptyHeader(
            text: 'Lifestyle Coverage',
            description: 'Your lifestyle coverage cannot be assessed yet.',
            instruction:
                'Add your net worth and set a planned lifestyle budget '
                'to see how long your current financial position could '
                'support your lifestyle.',
          ),
        ),

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
