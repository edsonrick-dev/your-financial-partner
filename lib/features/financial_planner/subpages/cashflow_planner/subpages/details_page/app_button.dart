import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

enum ButtonType { primary, outline, ghost }

enum ButtonSize { small, medium, large }

class AppButton extends StatelessWidget {
  final String text;
  final ButtonType type;
  final VoidCallback? onTap;
  final bool isInversed;
  final double borderRadius;
  final ButtonSize size;
  const AppButton({
    super.key,
    this.type = ButtonType.primary,
    this.size = ButtonSize.large,
    this.onTap,
    this.isInversed = false,
    this.borderRadius = 8,
    required this.text,
  });
  double _buttonSize(ButtonSize size) {
    return switch (size) {
      ButtonSize.small => 28,
      ButtonSize.medium => 36,
      ButtonSize.large => 40,
    };
  }

  Color _backgroundColor(BuildContext context) {
    final colorScheme = context.colors;

    if (onTap == null) {
      return colorScheme.appText.withValues(alpha: 0.08);
    }

    return switch (type) {
      ButtonType.primary =>
        isInversed ? colorScheme.appAccent : colorScheme.buttonBackground,
      ButtonType.outline => Colors.transparent,
      ButtonType.ghost => Colors.transparent,
    };
  }

  Color _foregroundColor(BuildContext context) {
    final colorScheme = context.colors;

    if (onTap == null) {
      return colorScheme.appText.withValues(alpha: 0.35);
    }

    return switch (type) {
      ButtonType.primary =>
        isInversed ? colorScheme.color900 : colorScheme.pageShifterTextSelected,
      ButtonType.outline => colorScheme.appText,
      ButtonType.ghost => colorScheme.appText,
    };
  }

  Border? _border(BuildContext context) {
    final colorScheme = context.colors;

    if (onTap == null) {
      return null;
    }

    return switch (type) {
      ButtonType.primary => null,
      ButtonType.outline => Border.all(color: colorScheme.appText),
      ButtonType.ghost => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        height: _buttonSize(size),
        width: double.infinity,
        decoration: BoxDecoration(
          color: _backgroundColor(context),
          border: _border(context),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: FittedBox(
            child: Text(
              text,
              style: AppTextStyle.titleL.copyWith(
                color: _foregroundColor(context),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
