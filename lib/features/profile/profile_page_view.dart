import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_insights/financial_profile_cashflow_controller_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_debt_load_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_emergency_fund_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_lifestyle_coverage_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_wealth_building_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/financial_stability_profile/financial_stability_profile_empty_view.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_ratio_card.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_stability_profile_card.dart';
import 'package:getx_drift_app/features/settings/settings_page_view.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfilePage extends GetView<FinancialProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = 20.0;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: AppBar(
              title: Text('Profile', style: AppTextStyle.headlineL),
              centerTitle: false,
              surfaceTintColor: Colors.transparent,
              actions: [
                AdaptivePressable(
                  onTap: () {
                    Get.bottomSheet(
                      SettingsPageView(),
                      isScrollControlled: true,
                    );
                  },
                  child: Icon(PhosphorIconsRegular.gear),
                ),
              ],
            ),
          ),

          Expanded(
            child: Obx(() {
              final isProfileComplete =
                  controller.isCashflowComplete &&
                  controller.hasNetWorth &&
                  controller.hasCompletedAssessment.value &&
                  controller.hasRevealedProfile.value;

              if (isProfileComplete) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      AppSection(
                        sectionTitle: 'Financial Stability Profile',
                        child: FinancialStabilityProfileCard(),
                      ),

                      SizedBox(height: spacing),

                      AppSection(
                        sectionTitle: 'Financial Ratios',
                        child: Column(
                          spacing: 12,
                          children: [
                            IntrinsicHeight(
                              child: Row(
                                spacing: 12,
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => FinancialRatioCard(
                                        ratio: controller.debtLoad,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Obx(
                                      () => FinancialRatioCard(
                                        ratio: controller.wealthBuilding,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IntrinsicHeight(
                              child: Row(
                                spacing: 12,
                                children: [
                                  Expanded(
                                    child: Obx(
                                      () => FinancialRatioCard(
                                        ratio: controller.emergencyFund,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Obx(
                                      () => FinancialRatioCard(
                                        ratio: controller.lifestyleCoverage,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: spacing),

                      LearningSection(),

                      SizedBox(height: context.bottomPadding),
                    ],
                  ),
                );
              }

              return FinancialStabilityProfileEmptyState(
                hasCashflowPlan: controller.isCashflowComplete,
                hasNetWorthPlan: controller.hasNetWorth,
                hasAssessment: controller.hasCompletedAssessment.value,
                onAction: () {
                  _handleProfileAction();
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  void _handleProfileAction() {
    if (!controller.hasNetWorth) {
      Get.toNamed(Routes.NETWORTHDETAILS);
      return;
    }

    if (!controller.isCashflowComplete) {
      controller.cashflowController.setInitialDetailsTab();
      Get.toNamed(Routes.CASHFLOWDETAILS);
      return;
    }

    if (!controller.hasCompletedAssessment.value) {
      Get.bottomSheet(const AscendAssessment(), isScrollControlled: false);
      return;
    }

    if (!controller.hasRevealedProfile.value) {
      controller.revealFinancialStabilityProfile();
      return;
    }
  }
}

class AscendAssessment extends StatelessWidget {
  const AscendAssessment({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSheet(
      adaptiveHeight: true,
      title: "Ascend's Assessment",
      child: AppSection(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 20),
            Text(
              "Let's make Ascend a better financial partner.",
              style: AppTextStyle.displayM,
            ),
            // SizedBox(height: 12),
            // Text(
            //   "Take the assessment for Ascend to better know you.",
            //   style: AppTextStyle.headlineM,
            // ),
            SizedBox(height: 20),
            Text(
              "You've already created your financial picture. Now, "
              "help us understand you—your goals, habits, and mindset—so "
              "Ascend can give you more relevant guidance and a Financial "
              "Stability Profile built around your situation.",
              style: AppTextStyle.bodyL,
            ),

            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme.bgLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(PhosphorIconsRegular.clock, size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Takes about 2 minutes',
                          style: AppTextStyle.titleL,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'There are no right or wrong answers. Your answers are private and will only be used to personalize your Ascen experience',
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            AppButton(
              text: 'Start assessment',
              onTap: () {
                Get.toNamed(Routes.ONBOARDING);
              },
            ),

            SizedBox(height: context.bottomPaddingSub),
          ],
        ),
      ),
    );
  }
}
