import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/2_financial_dependency_questionnaire/financial_dependency_question.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/3_lifestyle_continuity_questionnaire/lifestyle_continuity_questionnaire.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/subpages/questionnaires/death_benefit_questionnaire/time_horizon_question.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/death_benefit_horizon_options.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/1_protection_horizon_questionnaire/widgets/protection_horizon_picker.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class FinancialExpensesQuestion extends StatelessWidget {
  const FinancialExpensesQuestion({
    super.key,
    required this.colorScheme,
    required this.controller,
  });

  final ColorScheme colorScheme;
  final InsurancePlannerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSection(
          child: Container(
            constraints: BoxConstraints(minHeight: 52),
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: colorScheme.bgInversed,
            ),
            child: Text(
              "Life's uncertainties shouldn't derail your dependents’ future. Let's define how long your income should be protected if the unexpected happens.",
              style: AppTextStyle.bodyL.copyWith(
                color: colorScheme.appInversedtext,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        AppSection(
          sectionTitle:
              'How many years do you want to continue providing for your family after passing away?',
          child: Obx(() {
            final selectedOption = deathBenefitHorizonOptions.firstWhere(
              (option) =>
                  option.horizon == controller.deathBenefitHorizon.value,
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: deathBenefitHorizonOptions.map((option) {
                    return ProtectionHorizonPicker(
                      horizon: option.horizon,
                      isSelected:
                          controller.deathBenefitHorizon.value ==
                          option.horizon,
                      onTap: () {
                        controller.setDeathBenefitHorizon(option.horizon);
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 12),

                Text(
                  selectedOption.description,
                  style: AppTextStyle.labelM.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.bgLight,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('When to choose this?', style: AppTextStyle.titleL),

                      const SizedBox(height: 12),

                      Text(
                        selectedOption.whenToChoose,
                        style: AppTextStyle.bodyL,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

class FinalExpensesQuestion extends StatelessWidget {
  const FinalExpensesQuestion({
    super.key,
    required this.colorScheme,
    required this.controller,
  });

  final ColorScheme colorScheme;
  final InsurancePlannerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSection(
          child: Container(
            constraints: BoxConstraints(minHeight: 52),
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: colorScheme.appText,
            ),
            child: Text(
              "Life's uncertainties shouldn't derail your dependents’ future. Let's define how long your income should be protected if the unexpected happens.",
              style: AppTextStyle.bodyL.copyWith(
                color: colorScheme.appInversedtext,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        AppSection(
          sectionTitle:
              'How many years do you want to continue providing for your family after passing away?',
          child: Obx(() {
            final selectedOption = deathBenefitHorizonOptions.firstWhere(
              (option) =>
                  option.horizon == controller.deathBenefitHorizon.value,
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: deathBenefitHorizonOptions.map((option) {
                    return ProtectionHorizonPicker(
                      horizon: option.horizon,
                      isSelected:
                          controller.deathBenefitHorizon.value ==
                          option.horizon,
                      onTap: () {
                        controller.setDeathBenefitHorizon(option.horizon);
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 12),

                Text(
                  selectedOption.description,
                  style: AppTextStyle.labelM.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.bgLight,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('When to choose this?', style: AppTextStyle.titleL),

                      const SizedBox(height: 12),

                      Text(
                        selectedOption.whenToChoose,
                        style: AppTextStyle.bodyL,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

class ObligationsQuestion extends StatelessWidget {
  const ObligationsQuestion({
    super.key,
    required this.colorScheme,
    required this.controller,
  });

  final ColorScheme colorScheme;
  final InsurancePlannerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSection(
          child: Container(
            constraints: BoxConstraints(minHeight: 52),
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: colorScheme.appText,
            ),
            child: Text(
              "Life's uncertainties shouldn't derail your dependents’ future. Let's define how long your income should be protected if the unexpected happens.",
              style: AppTextStyle.bodyL.copyWith(
                color: colorScheme.appInversedtext,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        AppSection(
          sectionTitle:
              'How many years do you want to continue providing for your family after passing away?',
          child: Obx(() {
            final selectedOption = deathBenefitHorizonOptions.firstWhere(
              (option) =>
                  option.horizon == controller.deathBenefitHorizon.value,
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: deathBenefitHorizonOptions.map((option) {
                    return ProtectionHorizonPicker(
                      horizon: option.horizon,
                      isSelected:
                          controller.deathBenefitHorizon.value ==
                          option.horizon,
                      onTap: () {
                        controller.setDeathBenefitHorizon(option.horizon);
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 12),

                Text(
                  selectedOption.description,
                  style: AppTextStyle.labelM.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.bgLight,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('When to choose this?', style: AppTextStyle.titleL),

                      const SizedBox(height: 12),

                      Text(
                        selectedOption.whenToChoose,
                        style: AppTextStyle.bodyL,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

class ExistingProtectionQuestion extends StatelessWidget {
  const ExistingProtectionQuestion({
    super.key,
    required this.colorScheme,
    required this.controller,
  });

  final ColorScheme colorScheme;
  final InsurancePlannerController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSection(
          child: Container(
            constraints: BoxConstraints(minHeight: 52),
            width: double.infinity,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: colorScheme.appText,
            ),
            child: Text(
              "Life's uncertainties shouldn't derail your dependents’ future. Let's define how long your income should be protected if the unexpected happens.",
              style: AppTextStyle.bodyL.copyWith(
                color: colorScheme.appInversedtext,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        AppSection(
          sectionTitle:
              'How many years do you want to continue providing for your family after passing away?',
          child: Obx(() {
            final selectedOption = deathBenefitHorizonOptions.firstWhere(
              (option) =>
                  option.horizon == controller.deathBenefitHorizon.value,
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: deathBenefitHorizonOptions.map((option) {
                    return ProtectionHorizonPicker(
                      horizon: option.horizon,
                      isSelected:
                          controller.deathBenefitHorizon.value ==
                          option.horizon,
                      onTap: () {
                        controller.setDeathBenefitHorizon(option.horizon);
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 12),

                Text(
                  selectedOption.description,
                  style: AppTextStyle.labelM.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),

                const SizedBox(height: 12),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: colorScheme.bgLight,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('When to choose this?', style: AppTextStyle.titleL),

                      const SizedBox(height: 12),

                      Text(
                        selectedOption.whenToChoose,
                        style: AppTextStyle.bodyL,
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
        ),
      ],
    );
  }
}

class DeathBenefitQuestionnaire extends GetView<InsurancePlannerController> {
  const DeathBenefitQuestionnaire({super.key});
  Widget buildDeathBenefitPage(BuildContext context) {
    switch (controller.deathBenefitPage.value) {
      case DeathBenefitPage.financialDependency:
        return FinancialDependencyQuestion();

      case DeathBenefitPage.protectionHorizon:
        return TimeHorizonQuestion();

      case DeathBenefitPage.survivorBudget:
        return LifestyleContinuityQuestionnaire();

      case DeathBenefitPage.finalExpenses:
        return FinalExpensesQuestion(
          colorScheme: context.colors,
          controller: controller,
        );

      case DeathBenefitPage.obligations:
        return ObligationsQuestion(
          colorScheme: context.colors,
          controller: controller,
        );

      case DeathBenefitPage.existingProtection:
        return ExistingProtectionQuestion(
          colorScheme: context.colors,
          controller: controller,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    // final colorScheme = context.colors;

    return Scaffold(
      appBar: AppBar(
        title: Text('Death Benefit Assessment', style: AppTextStyle.headlineL),
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (controller.canGoBackDeathBenefit) {
              controller.previousDeathBenefitPage();
            } else {
              Get.back();
            }
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () =>
                  SingleChildScrollView(child: buildDeathBenefitPage(context)),
            ),
          ),
          const SizedBox(height: 8),
          AppSection(
            child: AppButton(
              text: 'Continue',
              onTap: controller.nextDeathBenefitPage,
            ),
          ),
          SizedBox(height: context.bottomPaddingSub),
        ],
      ),
    );
  }
}
