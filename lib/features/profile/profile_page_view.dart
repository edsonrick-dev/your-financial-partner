import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/emergency_fund_controller_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_ratio_card.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_stability_guage.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProfilePage extends GetView<FinancialProfileController> {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          spacing: 12,
          children: [
            //Personal Profile Section
            Column(
              children: [
                AppBar(
                  title: Text('Profile', style: AppTextStyle.headlineL),
                  centerTitle: false,
                  surfaceTintColor: Colors.transparent,
                ),
                AppSection(
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
                            color: colorScheme.textInversed,
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
                                  color: colorScheme.textInversed,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'edsonsanjuan@gmail.com',
                                style: AppTextStyle.titleM.copyWith(
                                  color: colorScheme.textInversed,
                                ),
                              ),
                              SizedBox(height: 4),
                              Container(
                                padding: EdgeInsets.symmetric(
                                  vertical: 2,
                                  horizontal: 12,
                                ),
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
                          color: colorScheme.textInversed,
                        ),
                        SizedBox(width: 4),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            //Financial Stability Profile Section
            AppSection(
              sectionTitle: 'Financial Stability Profile',
              child: Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AdaptivePressable(
                    onTap: () {
                      AppSheets.viewStabilityProfileDetails(null);
                    },
                    child: Container(
                      padding: EdgeInsets.fromLTRB(16, 16, 20, 16),
                      decoration: BoxDecoration(
                        color: colorScheme.bgLight,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.06),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                        // border: Border.all(color: colorScheme.appBorder),
                      ),
                      child: Obx(
                        () => Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            FinancialStabilityGauge(
                              score: controller.financialScore,
                              colorScheme: colorScheme,
                            ),
                            SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    controller.stability.title,
                                    style: AppTextStyle.headlineM.copyWith(
                                      color: colorScheme.appText,
                                    ),
                                  ),
                                  Text(
                                    controller.stability.shortDescription,
                                    style: AppTextStyle.bodyM.copyWith(
                                      color: colorScheme.appText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

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
