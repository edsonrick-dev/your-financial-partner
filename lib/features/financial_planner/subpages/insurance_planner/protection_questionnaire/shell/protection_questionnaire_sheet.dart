import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';

import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/2_financial_dependency_questionnaire/financial_dependency_question.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/widgets/insurance_assessment_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/1_protection_horizon_questionnaire/protection_horizon_questionnaire_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/3_lifestyle_continuity_questionnaire/lifestyle_continuity_questionnaire.dart';
import 'package:getx_drift_app/features/home/bindings/protection_questionnaire_binding.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProtectionQuestionnaireSheet extends GetView<InsurancePlannerController> {
  const ProtectionQuestionnaireSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final isAdditionalNeedsCompleted = false;
    final isExistingProtectionCompleted = false;

    final colorScheme = context.colors;
    return AppSheet(
      height: AppSheetHeight.full,
      title: 'Plan Your Protection',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: Column(
          children: [
            AppSection(
              child: Container(
                padding: const EdgeInsets.all(24),
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: AppGradient.gradientA(colorScheme),
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Column(
                  children: [
                    Text(
                      "Answer a few questions to shape your protection plan. Ascend will use your financial plan and your answers to estimate your needs and identify any coverage gaps.",
                      style: AppTextStyle.bodyL.copyWith(
                        color: colorScheme.appInversedtext,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Column(
              children: [
                AppSection(
                  child: Column(
                    spacing: 16,
                    children: [
                      //Protection Horizon
                      _protectionHorizonQuestionnaire(),

                      //Beneficiaries
                      _beneficiariesQuestionnaire(),

                      //Lifestyle Continuity
                      Obx(
                        () => QuestionnaireTile(
                          title: 'Lifestyle Continuity',
                          description:
                              controller.isExpenseContinuityCompleted.value
                              ? 'Expense continuity preferences saved'
                              : 'Set how expenses would continue under each protection scenario.',
                          isCompleted:
                              controller.isExpenseContinuityCompleted.value,
                          onTap: () async {
                            final saved = await Get.to<bool>(
                              () => const LifestyleContinuityQuestionnaire(),
                              binding: ProtectionQuestionnaireBinding(),
                              preventDuplicates: false,
                            );

                            if (saved == true) {
                              controller.isExpenseContinuityCompleted.value =
                                  true;
                            }
                          },
                        ),
                      ),

                      QuestionnaireTile(
                        title: 'Additional Financial Needs',
                        description: isAdditionalNeedsCompleted
                            ? 'Financial needs reviewed'
                            : 'Add one-time and future financial needs.',
                        isCompleted: isAdditionalNeedsCompleted,
                        onTap: () {
                          // Open Additional Financial Needs questionnaire
                        },
                      ),

                      QuestionnaireTile(
                        title: 'Existing Protection',
                        description: isExistingProtectionCompleted
                            ? '3 protection types reviewed'
                            : 'Review your current insurance coverage.',
                        isCompleted: isExistingProtectionCompleted,
                        onTap: () {
                          // Open Existing Protection questionnaire
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            AppSection(
              sectionTitle: 'Protection Assessments',
              trailingText: '0/3 completed',
              child: Column(
                spacing: 20,
                children: [
                  ///Death Benefit

                  ///Critical Illness Benefit
                  InsuranceAssessmentCard(
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.DEATHEBENFITQUESTIONNAIRE);
                    },
                    icon: PhosphorIconsRegular.shield,
                    title: 'Death Benefit',
                    description:
                        'Protect the people and expenses that may remain after your death.',
                  ),
                  InsuranceAssessmentCard(
                    icon: PhosphorIconsRegular.hospital,
                    title: 'Critical Illness Benefit',
                    description:
                        'Prepare for the financial impact of a serious illness.',
                  ),
                  InsuranceAssessmentCard(
                    icon: PhosphorIconsRegular.wheelchair,
                    title: 'Disability Benefit',
                    description:
                        'Protect you and your family if a disability prevents you from working.',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Obx _beneficiariesQuestionnaire() {
    return Obx(
      () => QuestionnaireTile(
        title: 'Beneficiaries',
        description: controller.isFinancialDependencyCompleted
            ? '3 protection scenarios set'
            : 'Set how expenses would continue under each protection scenario.',
        isCompleted: controller.isFinancialDependencyCompleted,
        onTap: () {
          Get.to(
            () => const FinancialDependencyQuestion(),
            binding: ProtectionQuestionnaireBinding(),
          );
          // Open Expense Continuity questionnaire
        },
      ),
    );
  }

  Obx _protectionHorizonQuestionnaire() {
    return Obx(
      () => QuestionnaireTile(
        title: 'Protection Horizon',
        description: controller.isProtectionHorizonCompleted
            ? '3 protection horizons set'
            : 'Choose how long each benefit should provide support.',
        isCompleted: controller.isProtectionHorizonCompleted,
        onTap: () {
          Get.to(
            () => const ProtectionHorizonQuestionnaire(),
            binding: ProtectionQuestionnaireBinding(),
          );
        },
      ),
    );
  }
}

class QuestionnaireTile extends StatelessWidget {
  final String title;
  final String description;
  final bool isCompleted;
  final VoidCallback onTap;

  const QuestionnaireTile({
    super.key,
    required this.title,
    required this.description,
    required this.isCompleted,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          SizedBox(height: 24, child: _StatusIcon(isCompleted: isCompleted)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyle.titleL),
                const SizedBox(height: 4),

                Text(description, style: AppTextStyle.bodyM),
              ],
            ),
          ),
          SizedBox(
            height: 24,
            child: PhosphorIcon(PhosphorIconsRegular.caretRight, size: 20),
          ),
        ],
      ),
    );
  }
}

class _StatusIcon extends StatelessWidget {
  final bool isCompleted;

  const _StatusIcon({required this.isCompleted});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final iconSize = 20.0;

    if (isCompleted) {
      return Container(
        width: iconSize,
        height: iconSize,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).colorScheme.primary,
        ),
        child: PhosphorIcon(
          PhosphorIconsBold.check,
          size: 12,
          color: Theme.of(context).colorScheme.onPrimary,
        ),
      );
    }

    return Container(
      width: iconSize,
      height: iconSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: colorScheme.appBorder, width: 1.5),
      ),
    );
  }
}
