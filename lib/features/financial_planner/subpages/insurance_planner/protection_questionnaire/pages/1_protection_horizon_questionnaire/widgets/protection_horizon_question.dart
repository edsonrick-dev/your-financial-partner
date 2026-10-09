import 'package:flutter/material.dart';

import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/subpages/questionnaires/protection_horizon/models/protection_horizon_option.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/1_protection_horizon_questionnaire/widgets/protection_horizon_picker.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ProtectionHorizonQuestion extends StatelessWidget {
  final String title;
  final String subtitle;
  final List<ProtectionHorizonOption> options;
  final ProtectionHorizon selectedHorizon;
  final ValueChanged<ProtectionHorizon> onChanged;

  const ProtectionHorizonQuestion({
    super.key,
    required this.title,
    required this.subtitle,
    required this.options,
    required this.selectedHorizon,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final selectedOption = options.firstWhere(
      (option) => option.horizon == selectedHorizon,
    );

    return AppSection(
      sectionTitle: title,
      subtitle: subtitle,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: options.map((option) {
              return ProtectionHorizonPicker(
                horizon: option.horizon,
                isSelected: selectedHorizon == option.horizon,
                onTap: () {
                  onChanged(option.horizon);
                },
              );
            }).toList(),
          ),

          const SizedBox(height: 4),

          Text(selectedOption.description),

          const SizedBox(height: 12),

          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.bgLight,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 8,
              children: [
                Icon(PhosphorIconsRegular.info, size: 24),

                Expanded(
                  child: Column(
                    spacing: 2,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (selectedOption.isRecommended)
                        Text(
                          "Ascend's Recommendation",
                          style: AppTextStyle.titleL,
                        ),

                      Text(
                        selectedOption.whenToChoose,
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
    );
  }
}
