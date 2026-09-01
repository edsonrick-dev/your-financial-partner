import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_details_empty_header.dart';
import 'package:getx_drift_app/features/profile/widgets/requirement_row.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class EmptyEmergencyFundView extends StatelessWidget {
  const EmptyEmergencyFundView({super.key, required this.controller});

  final FinancialProfileController controller;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 20,
        children: [
          AppSection(
            child: FinancialDetailsEmptyHeader(
              text: 'Emergency Fund',
              description: 'Your emergency fund cannot be assessed yet.',
              instruction:
                  'Set up your income, budget, and at least one cash or bank account to see how long your available funds could support your lifestyle.',
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
                    const SizedBox(height: 10),
                    RequirementRow(
                      label: 'Cash or bank account',
                      isComplete: controller.hasLiquidFunds,
                    ),
                    const SizedBox(height: 10),
                    RequirementRow(
                      label: 'Average daily balance',
                      isComplete: controller.averageDailyBalance != null,
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
