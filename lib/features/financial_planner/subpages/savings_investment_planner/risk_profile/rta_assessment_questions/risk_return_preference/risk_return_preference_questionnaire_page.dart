import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/risk_tolerance_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/risk_profile/rta_assessment_questions/risk_return_preference/risk_return_preference_model.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RiskReturnPreferenceQuestionnairePage
    extends GetView<RiskToleranceController> {
  const RiskReturnPreferenceQuestionnairePage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 16,
        children: [
          Text(
            RiskReturnPreferenceQuestion.question,
            style: AppTextStyle.bodyL,
          ),

          Obx(
            () => Column(
              spacing: 12,
              children: RiskReturnPreferenceQuestion.options.map((option) {
                return _RiskReturnOption(
                  preference: option,
                  isSelected: controller.riskReturnPreference.value == option,
                  onTap: () {
                    controller.setRiskReturnPreference(option);
                  },
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _RiskReturnOption extends StatelessWidget {
  const _RiskReturnOption({
    required this.preference,
    required this.isSelected,
    required this.onTap,
  });

  final RiskReturnPreference preference;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final range = preference.returnRange;

    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? colors.appInflow.withAlpha(30) : colors.bgLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colors.appInflow : colors.appBorder,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(preference.label, style: AppTextStyle.titleL),

                  Row(
                    children: [
                      Expanded(
                        child: _ReturnValue(
                          label: 'Worst',
                          value: range.worstCase,
                        ),
                      ),
                      Expanded(
                        child: _ReturnValue(
                          label: 'Average',
                          value: range.average,
                        ),
                      ),
                      Expanded(
                        child: _ReturnValue(
                          label: 'Best',
                          value: range.bestCase,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            Icon(
              isSelected
                  ? PhosphorIconsFill.radioButton
                  : PhosphorIconsRegular.circle,
              color: isSelected ? colors.appInflow : colors.appTextMuted,
            ),
          ],
        ),
      ),
    );
  }
}

class _ReturnValue extends StatelessWidget {
  const _ReturnValue({required this.label, required this.value});

  final String label;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyS.copyWith(
            color: context.colors.appTextMuted,
          ),
        ),
        Text('${value.toStringAsFixed(1)}%', style: AppTextStyle.bodyM),
      ],
    );
  }
}
