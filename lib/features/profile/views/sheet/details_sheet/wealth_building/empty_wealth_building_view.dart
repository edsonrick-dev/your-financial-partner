import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_details_empty_header.dart';
import 'package:getx_drift_app/features/profile/widgets/requirement_row.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class EmptyWealthBuildingView extends GetView<FinancialProfileController> {
  const EmptyWealthBuildingView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 20,
        children: [
          AppSection(
            child: FinancialDetailsEmptyHeader(
              text: 'Wealth Building',
              description: 'Your wealth building rate cannot be assessed yet.',
              instruction:
                  'Set up your income and budget plans to see how fast you are able to building wealth.',
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
                      label: 'Income plan',
                      isComplete: controller.hasIncome,
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
      ),
    );
  }
}
