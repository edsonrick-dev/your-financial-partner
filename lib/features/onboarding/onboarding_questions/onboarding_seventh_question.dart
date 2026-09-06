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

class OnboardingSeventhQuestion extends GetView<OnboardingController> {
  const OnboardingSeventhQuestion({super.key});

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
                  'How did you hear about Ascend?',
                  style: AppTextStyle.displayM,
                ),

                // const SizedBox(height: 12),

                // Text('Select all that apply.', style: AppTextStyle.bodyL),
                const SizedBox(height: 24),
              ],
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
              itemCount: controller.heardUs.length,
              separatorBuilder: (_, _) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final option = controller.heardUs[index];
                return Obx(
                  () => OnboardingOptionTile(
                    selectionType: OnboardingSelectionType.single,
                    title: option,
                    isSelected: controller.selectedHeardSource.value == option,
                    onTap: () {
                      controller.selectHeardUs(option);
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
