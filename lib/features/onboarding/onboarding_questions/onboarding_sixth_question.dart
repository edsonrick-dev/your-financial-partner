import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_option_tile.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class OnboardingSixthQuestion extends GetView<OnboardingController> {
  const OnboardingSixthQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    //  contentSource= controller.contentSource;
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          AppSection(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Where do you usually learn about money?',
                  style: AppTextStyle.displayM,
                ),

                const SizedBox(height: 12),

                Text('Select all that apply.', style: AppTextStyle.bodyL),

                const SizedBox(height: 24),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              itemCount: controller.contentSource.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final option = controller.contentSource[index];
                return Obx(
                  () => OnboardingOptionTile(
                    title: option,
                    isSelected: controller.isLearningSourceSelected(option),
                    onTap: () => controller.toggleLearningSource(option),
                  ),
                );
              },
            ),
          ),
          AppSection(
            child: AppButton(
              text: 'Continue',
              onTap: () {
                Get.toNamed(Routes.ONBOARDING_LEARN_WITH_ASCEND_INTRO);
              },
            ),
          ),
          SizedBox(height: context.bottomPadding),
        ],
      ),
    );
  }
}
