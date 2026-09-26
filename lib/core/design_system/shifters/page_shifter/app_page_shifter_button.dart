import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class AppPageShifterButton extends StatelessWidget {
  const AppPageShifterButton({
    super.key,
    required this.isSelected,
    required this.colorScheme,
    required this.title,
    this.onTap,
  });

  final bool isSelected;
  final ColorScheme colorScheme;
  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return AdaptivePressable(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.ease,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? colorScheme.pageShifterFillSelected
              : colorScheme.pageShifterFillUnselected,
          borderRadius: BorderRadius.circular(999),
          boxShadow: AppShadows.pill(colorScheme.text),
        ),
        child: AnimatedDefaultTextStyle(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          style: TextStyle(
            color: isSelected
                ? colorScheme.pageShifterTextSelected
                : colorScheme.pageShifterTextUnselected,

            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
          ),
          child: Text(title),
        ),
      ),
    );
  }
}
