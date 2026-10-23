import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPressed,
    this.padding = 16,
    this.borderColor,
    this.width,
    this.height,
    this.maxHeight,
  });
  final VoidCallback? onTap;
  final VoidCallback? onLongPressed;
  final Widget child;
  final double padding;
  final Color? borderColor;
  final double? width;
  final double? height;
  final double? maxHeight;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AdaptivePressable(
      onTap: onTap,
      onLongPress: onLongPressed,
      child: Container(
        constraints: BoxConstraints(
          minHeight: height ?? 52,
          maxHeight: maxHeight ?? double.infinity,
        ),
        width: width ?? double.infinity,
        height: height,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: colorScheme.bgLight,
          border: Border.all(color: borderColor ?? colorScheme.appBorder),
          boxShadow: [
            BoxShadow(
              color: colorScheme.text.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
