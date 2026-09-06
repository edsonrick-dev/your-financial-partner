import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/onboarding/enums/onboarding_selection_type.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_option_tile.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class OnboardingFourthQuestionView extends GetView<OnboardingController> {
  const OnboardingFourthQuestionView({super.key});

  static const options = [
    "I don't really have a system",
    'I mostly keep it in my head',
    'I use notes or spreadsheets',
    'I use a finance/budgeting app',
    'I work with a financial professional',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Column(
        children: [
          // HEADER + OPTIONS
          AppSection(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'How do you currently manage your finances?',
                  style: AppTextStyle.displayM,
                ),
              ],
            ),
          ),

          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              itemCount: options.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final option = options[index];

                return Obx(
                  () => OnboardingOptionTile(
                    selectionType: OnboardingSelectionType.single,
                    title: option,
                    isSelected: controller.currentManagement.value == option,
                    onTap: () {
                      controller.selectCurrentManagement(option);
                      Get.toNamed(Routes.ONBOARDING_ASCEND_INTRO_VIEW);
                    },
                  ),
                );
              },
            ),
          ),
          // // CONTINUE BUTTON
          // AppSection(
          //   child: AppButton(
          //     text: 'Continue',
          //     onTap: () {
          //       // Navigate to next question.
          //     },
          //   ),
          // ),

          // SizedBox(height: context.bottomPadding),
        ],
      ),
    );
  }
}
