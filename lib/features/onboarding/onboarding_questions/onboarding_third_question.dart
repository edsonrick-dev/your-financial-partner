import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_option_tile.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class OnboardingThirdQuestionView extends GetView<OnboardingController> {
  const OnboardingThirdQuestionView({super.key});

  static const goals = [
    'Build an emergency fund',
    'Become debt-free',
    'Buy a home',
    'Start investing',
    'Grow my wealth',
    'Protect my family',
    'Achieve financial independence',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          AppSection(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What are your top financial goals?',
                  style: AppTextStyle.displayM,
                ),

                const SizedBox(height: 20),

                Text(
                  'This will help us recommend the right videos and '
                  'articles for your guidance.',
                  style: AppTextStyle.bodyL,
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              itemCount: goals.length,
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final goal = goals[index];

                return Obx(
                  () => OnboardingOptionTile(
                    title: goal,
                    isSelected: controller.isSelectedGoal(goal),
                    onTap: () {
                      controller.toggleFinancialGoal(goal);
                    },
                  ),
                );
              },
            ),
          ),
          AppSection(
            child: AppButton(
              text: 'Continue',
              onTap: () {
                Get.toNamed(Routes.ONBOARDING_FOURTH_QUESTION);
                // Navigate to question 4
              },
            ),
          ),

          SizedBox(height: context.bottomPadding),
        ],
      ),
    );
  }
}
