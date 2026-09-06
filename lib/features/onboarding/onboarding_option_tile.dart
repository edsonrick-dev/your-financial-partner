import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/onboarding/enums/onboarding_selection_type.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class OnboardingOptionTile extends StatelessWidget {
  const OnboardingOptionTile({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.selectionType = OnboardingSelectionType.multiple,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final OnboardingSelectionType selectionType;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final icon = selectionType == OnboardingSelectionType.single
        ? (isSelected
              ? PhosphorIconsFill.radioButton
              : PhosphorIconsRegular.circle)
        : (isSelected
              ? PhosphorIconsFill.checkSquare
              : PhosphorIconsRegular.square);

    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.appInflow.withAlpha(30)
              : colorScheme.bgLight,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? colorScheme.appInflow : colorScheme.appBorder,
          ),
        ),
        child: Row(
          children: [
            Expanded(child: Text(title, style: AppTextStyle.bodyL)),
            Icon(
              icon,
              color: isSelected
                  ? colorScheme.appInflow
                  : colorScheme.appTextMuted,
            ),
          ],
        ),
      ),
    );
  }
}
