import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_details_empty_header.dart';
import 'package:getx_drift_app/features/profile/widgets/requirement_row.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class EmptyDebtLoadView extends GetView<FinancialProfileController> {
  const EmptyDebtLoadView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        AppSection(
          child: FinancialDetailsEmptyHeader(
            text: 'Debt Load',
            description: 'Your debt load cannot be assessed yet.',
            instruction:
                'Set up your income and any debt repayments to see how much your debt burdens your finances.',
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
                    label: 'Income',
                    isComplete: controller.hasIncome,
                  ),
                  const SizedBox(height: 8),
                  RequirementRow(
                    label: 'Debt repayments (if any)',
                    isComplete: controller.hasDebtRepayment,
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
