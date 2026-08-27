import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPressed,
  });
  final VoidCallback? onTap;
  final VoidCallback? onLongPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AdaptivePressable(
      onTap: onTap,
      onLongPress: onLongPressed,
      child: Container(
        constraints: BoxConstraints(minHeight: 60),
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: colorScheme.bgLight,
          border: Border.all(color: colorScheme.appBorder),
          boxShadow: [
            BoxShadow(
              color: colorScheme.text.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(child: child),
      ),
    );
  }
}
