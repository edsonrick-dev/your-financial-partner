import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';

class AppDetailsPageShifter extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback? onTap;

  const AppDetailsPageShifter({
    super.key,
    required this.text,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptivePressable(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        opacity: isSelected ? 1 : 0.5,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          alignment: Alignment.center,
          constraints: const BoxConstraints(minHeight: 52, minWidth: 80),
          child: Text(text, style: AppTextStyle.headlineM),
        ),
      ),
    );
  }
}
