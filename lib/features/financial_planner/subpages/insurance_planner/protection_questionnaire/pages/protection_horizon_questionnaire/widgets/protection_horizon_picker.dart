import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';

class ProtectionHorizonPicker extends StatelessWidget {
  const ProtectionHorizonPicker({
    super.key,
    required this.horizon,
    this.isSelected = false,
    this.onTap,
  });

  final ProtectionHorizon horizon;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(minHeight: 44, minWidth: 44),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.pageShifterFillSelected
              : colorScheme.pageShifterFillUnselected,
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(999),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            horizon.years?.toString() ?? 'Until Retirement',
            style: isSelected
                ? AppTextStyle.titleL.copyWith(
                    color: colorScheme.pageShifterTextSelected,
                  )
                : AppTextStyle.titleL.copyWith(
                    color: colorScheme.pageShifterTextUnselected,
                  ),
          ),
        ),
      ),
    );
  }
}
