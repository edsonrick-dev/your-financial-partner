import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/controller/protection_questionnaire_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/1_protection_horizon_questionnaire/widgets/protection_horizon_question.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/1_protection_horizon_questionnaire/models/protection_horizon_options.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProtectionHorizonQuestionnaire
    extends GetView<ProtectionQuestionnaireController> {
  const ProtectionHorizonQuestionnaire({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Protection Horizon Questionnaire',
            style: AppTextStyle.headlineL,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: Column(
          spacing: 20,
          children: [
            AppSection(
              child: Column(
                spacing: 20,
                children: [
                  Container(
                    padding: const EdgeInsets.all(24),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: AppGradient.gradientA(colorScheme),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Life's uncertainties shouldn't derail your personal and dependents' future. Let's define how long your financial support should continue when unexpected events happen.",
                          style: AppTextStyle.bodyL.copyWith(
                            color: colorScheme.appInversedtext,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: colorScheme.bgDark,
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: colorScheme.appBorder),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          PhosphorIconsRegular.lightbulb,
                          // color: colorScheme.appInfo,
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            spacing: 4,
                            children: [
                              Text(
                                'Your protection plan is designed to be valid for 5 years',
                                style: AppTextStyle.titleL.copyWith(
                                  // color: colorScheme.appInfo,
                                ),
                              ),
                              Text(
                                "Factor this when selecting your answers below.",
                                style: AppTextStyle.bodyM,
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

            Column(
              spacing: 24,
              children: [
                Obx(
                  () => ProtectionHorizonQuestion(
                    title: 'If you were to pass away:',
                    subtitle:
                        'How many years should your death benefit provide financial support for your dependents?',
                    options: protectionHorizonOptions[ProtectionType.death]!,
                    selectedHorizon: controller.deathBenefitHorizon.value,
                    onChanged: controller.setDeathBenefitHorizon,
                  ),
                ),
                Obx(
                  () => ProtectionHorizonQuestion(
                    title: 'If you were diagnosed with a critical illness:',
                    subtitle:
                        'How many years should your critical illness benefit provide financial support?',
                    options:
                        protectionHorizonOptions[ProtectionType
                            .criticalIllness]!,
                    selectedHorizon:
                        controller.criticalIllnessBenefitHorizon.value,
                    onChanged: controller.setCriticalIllnessBenefitHorizon,
                  ),
                ),
                Obx(
                  () => ProtectionHorizonQuestion(
                    title: 'If you were permanently disabled:',
                    subtitle:
                        'How many years should your disability benefit provide financial support?',
                    options:
                        protectionHorizonOptions[ProtectionType.disability]!,
                    selectedHorizon: controller.disabilityBenefitHorizon.value,
                    onChanged: controller.setDisabilityBenefitHorizon,
                  ),
                ),
              ],
            ),

            AppSection(
              child: AppButton(
                text: 'Save my protection horizon',
                onTap: () {
                  controller.saveProtectionHorizon();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
