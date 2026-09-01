import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_debt_load_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_emergency_fund_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_lifestyle_coverage_extension.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_wealth_building_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_ratio_card.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_stability_profile_card.dart';
import 'package:getx_drift_app/features/settings/settings_page_view.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfilePage extends GetView<FinancialProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final spacing = 20.0;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Personal Profile Section
            Column(
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
              ],
            ),

            UserProfileCard(),

            //Financial Stability Profile Section
            SizedBox(height: spacing),
            AppSection(
              sectionTitle: 'Financial Stability Profile',
              child: FinancialStabilityProfileCard(),
            ),
            SizedBox(height: spacing),
            //Financial Ratios
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
                            () =>
                                FinancialRatioCard(ratio: controller.debtLoad),
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
          ],
        ),
      ),
    );
  }
}

class UserProfileCard extends StatelessWidget {
  const UserProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSection(
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          gradient: AppGradient.gradientA(colorScheme),
        ),
        padding: EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: colorScheme.appInversedtext,
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                // spacing: 4,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Katrina Francesca D. Villano',
                    style: AppTextStyle.headlineM.copyWith(
                      color: colorScheme.appInversedtext,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'edsonsanjuan@gmail.com',
                    style: AppTextStyle.titleM.copyWith(
                      color: colorScheme.appInversedtext,
                    ),
                  ),
                  SizedBox(height: 4),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      color: colorScheme.appAccent,
                    ),
                    child: Text(
                      'Free Account',
                      style: TextStyle(color: colorScheme.text),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 2),
            Icon(
              PhosphorIconsRegular.pencilSimple,
              color: colorScheme.appInversedtext,
            ),
            SizedBox(width: 4),
          ],
        ),
      ),
    );
  }
}
