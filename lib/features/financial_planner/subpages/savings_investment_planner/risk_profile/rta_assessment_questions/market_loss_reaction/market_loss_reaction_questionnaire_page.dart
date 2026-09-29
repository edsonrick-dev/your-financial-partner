import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/risk_tolerance_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/market_loss_reaction/market_loss_reaction_model.dart';
import 'package:getx_drift_app/features/onboarding/enums/onboarding_selection_type.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_option_tile.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class MarketLossReactionQuestionnairePage
    extends GetView<RiskToleranceController> {
  const MarketLossReactionQuestionnairePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(MarketLossReactionQuestion.question, style: AppTextStyle.bodyL),

          Obx(
            () => Column(
              spacing: 12,
              children: MarketLossReactionQuestion.options.map((option) {
                return OnboardingOptionTile(
                  title: option.label,
                  isSelected: controller.marketLossReaction.value == option,
                  selectionType: OnboardingSelectionType.single,
                  onTap: () {
                    controller.setMarketLossReaction(option);
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
