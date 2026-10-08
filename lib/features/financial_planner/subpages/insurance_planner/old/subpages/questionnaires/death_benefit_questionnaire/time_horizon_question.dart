import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/death_benefit_horizon_options.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/protection_horizon_questionnaire/widgets/protection_horizon_picker.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class TimeHorizonQuestion extends GetView<InsurancePlannerController> {
  const TimeHorizonQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
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
