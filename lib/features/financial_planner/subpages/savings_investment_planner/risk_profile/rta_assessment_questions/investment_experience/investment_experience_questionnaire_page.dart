import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/risk_tolerance_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/investment_experience/investment_experience_model.dart';
import 'package:getx_drift_app/features/onboarding/enums/onboarding_selection_type.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_option_tile.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class InvestmentExperienceQuestionnairePage
    extends GetView<RiskToleranceController> {
  const InvestmentExperienceQuestionnairePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(
            InvestmentExperienceQuestion.question,
            style: AppTextStyle.titleL,
          ),

          Text('Select all that apply.', style: AppTextStyle.bodyL),

          Obx(
            () => Column(
              spacing: 12,
              children: InvestmentExperienceQuestion.options.map((option) {
                return OnboardingOptionTile(
                  title: option.label,
                  isSelected: controller.investmentExperience.contains(option),
                  selectionType: OnboardingSelectionType.multiple,
                  onTap: () {
                    controller.toggleInvestmentExperience(option);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
