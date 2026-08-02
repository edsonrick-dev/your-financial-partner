import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class TabSwitcher extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isActive;
  const TabSwitcher({
    super.key,
    required this.label,
    required this.onTap,
    this.isActive = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return isActive
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Container(
              height: 36,
              width: double.infinity,
              decoration: BoxDecoration(
                color: isActive ? colorScheme.appAccent : Colors.transparent,
              ),
              child: Center(child: Text(label, style: AppTextStyle.titleM)),
            ),
          )
        : AdaptivePressable(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Container(
                height: 36,
                decoration: BoxDecoration(
                  color: isActive ? colorScheme.appAccent : Colors.transparent,
                ),
                child: Center(child: Text(label, style: AppTextStyle.titleM)),
              ),
            ),
          );
  }
}
