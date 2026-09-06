import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_option_tile.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class OnboardingFirstQuestionView extends GetView<OnboardingController> {
  const OnboardingFirstQuestionView({super.key});

  static const goals = [
    'Managing my spending',
    'Building an emergency fund',
    'Paying off debt',
    'Building wealth',
    'Protecting myself and my family',
    'Planning for my financial future',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        // title: Text('Onboarding (1/7)', style: AppTextStyle.headlineL),
      ),
      body: Column(
        children: [
          AppSection(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'What would you like AscendYFP to help you improve?',
                  style: AppTextStyle.displayM,
                ),

                const SizedBox(height: 20),

                Text('Select all that apply.', style: AppTextStyle.bodyL),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              itemCount: goals.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final goal = goals[index];

                return Obx(
                  () => OnboardingOptionTile(
                    title: goal,
                    isSelected: controller.isImprovementAreaSelected(goal),
                    onTap: () => controller.toggleImprovementArea(goal),
                  ),
                );
              },
            ),
          ),
          AppSection(
            child: AppButton(
              text: 'Continue',
              onTap: () {
                Get.toNamed(Routes.ONBOARDING_SECOND_QUESTION);
              },
            ),
          ),
          SizedBox(height: context.bottomPadding),
        ],
      ),
    );
  }
}
