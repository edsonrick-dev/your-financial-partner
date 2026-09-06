import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_ascend_intro/widgets/financial_picture_page.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_ascend_intro/widgets/onboarding_financial_planners_preview.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_ascend_intro/widgets/start_where_you_are_page.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class OnboardingAscendIntroView extends GetView<OnboardingController> {
  const OnboardingAscendIntroView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Scaffold(
      appBar: AppBar(
        title: Text('Meet AscendYFP', style: AppTextStyle.headlineL),
      ),

      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: controller.introPageController,
              onPageChanged: controller.onIntroPageChanged,
              physics: const ClampingScrollPhysics(),
              children: const [
                FinancialPicturePage(),
                OnboardingFinancialPlannersPreview(),
                StartWhereYouArePage(),
              ],
            ),
          ),

          // Page indicators
          Obx(
            () => Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                final isActive = controller.introPageIndex.value == index;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: isActive ? 20 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: isActive
                        ? colorScheme.appText
                        : colorScheme.appBorder,
                    borderRadius: BorderRadius.circular(100),
                  ),
                );
              }),
            ),
          ),

          const SizedBox(height: 20),

          AppSection(
            child: Obx(
              () => AppButton(
                text: controller.introPageIndex.value == 2
                    ? 'Continue'
                    : 'Next',
                onTap: controller.nextIntroPage,
              ),
            ),
          ),

          SizedBox(height: context.bottomPadding),
        ],
      ),
    );
  }
}
