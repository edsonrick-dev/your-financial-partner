import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/onboarding/enums/onboarding_selection_type.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_option_tile.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class OnboardingSecondQuestionView extends GetView<OnboardingController> {
  const OnboardingSecondQuestionView({super.key});

  static const confidenceLevels = [
    'I’m just getting started',
    'I understand the basics',
    'I actively manage my finances',
    'I feel confident managing my finances',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        // title: Text('Onboarding (2/7)', style: AppTextStyle.headlineL),
      ),
      body: Column(
        children: [
          AppSection(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How confident are you managing your finances?',
                  style: AppTextStyle.displayM,
                ),

                const SizedBox(height: 20),

                Text('Choose one.', style: AppTextStyle.bodyL),
              ],
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              itemCount: confidenceLevels.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final level = confidenceLevels[index];

                return Obx(
                  () => OnboardingOptionTile(
                    selectionType: OnboardingSelectionType.single,
                    title: level,
                    isSelected: controller.selectedConfidence.value == level,
                    onTap: () {
                      controller.selectConfidence(level);
                      Get.toNamed(Routes.ONBOARDING_THIRD_QUESTION);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
