import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Debt Load', style: AppTextStyle.headlineL),
              const SizedBox(height: 12),
              Text(
                'Your debt load cannot be assessed yet.',
                style: AppTextStyle.bodyM,
              ),
              const SizedBox(height: 8),
              Text(
                'Set up your income and any debt repayments to see how much your debt burdens your finances.',
                style: AppTextStyle.bodyM.copyWith(
                  color: context.colors.appTextMuted,
                ),
              ),
            ],
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
