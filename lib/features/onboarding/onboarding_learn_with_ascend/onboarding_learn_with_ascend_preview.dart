import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_learn_with_ascend/widgets/learn_intro_page_one.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_learn_with_ascend/widgets/learn_intro_page_two.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class OnboardingLearnWithAscendPreview extends GetView<OnboardingController> {
  const OnboardingLearnWithAscendPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learn With Ascend', style: AppTextStyle.headlineL),
      ),

      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller.learnIntroPageController,
              onPageChanged: controller.onLearnIntroPageChanged,
              physics: const ClampingScrollPhysics(),
              children: const [LearnIntroPageOne(), LearnIntroPageTwo()],
            ),
          ),

          const SizedBox(height: 8),

          AppSection(
            child: Obx(
              () => AppButton(
                text: controller.learnIntroPageIndex.value == 1
                    ? 'Start building my financial plan'
                    : 'Next',
                onTap: controller.nextLearnIntroPage,
              ),
            ),
          ),

          SizedBox(height: context.bottomPadding),
        ],
      ),
    );
  }
}
