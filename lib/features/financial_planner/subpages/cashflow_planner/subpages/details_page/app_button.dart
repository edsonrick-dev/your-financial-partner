import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

enum ButtonType { primary, outline, ghost }

enum ButtonSize {
  small(height: 28, textStyle: AppTextStyle.titleS, iconSize: 12),
  medium(height: 36, textStyle: AppTextStyle.titleM, iconSize: 16),
  large(height: 40, textStyle: AppTextStyle.titleL, iconSize: 20),
  xLarge(height: 52, textStyle: AppTextStyle.titleL, iconSize: 20);

  const ButtonSize({
    required this.height,
    required this.textStyle,
    required this.iconSize,
  });

  final double height;
  final TextStyle textStyle;
  final double iconSize;
}

class AppButton extends StatelessWidget {
  final String text;
  final ButtonType type;
  final VoidCallback? onTap;
  final bool isInversed;
  final double borderRadius;
  final ButtonSize size;
  final IconData? leadingIcon;
  final IconData? trailingIcon;

  const AppButton({
    super.key,
    this.type = ButtonType.primary,
    this.size = ButtonSize.large,
    this.onTap,
    this.isInversed = false,
    this.borderRadius = 8,
    this.leadingIcon,
    this.trailingIcon,
    required this.text,
  });

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
      ButtonType.outline =>
        isInversed ? colorScheme.appInversedtext : colorScheme.appText,
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
      ButtonType.outline => Border.all(
        color: isInversed ? colorScheme.appInversedtext : colorScheme.appText,
      ),
      ButtonType.ghost => null,
    };
  }

  @override
  Widget build(BuildContext context) {
    final foregroundColor = _foregroundColor(context);
    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        height: size.height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: _backgroundColor(context),
          border: _border(context),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leadingIcon != null) ...[
                Icon(leadingIcon, color: foregroundColor, size: size.iconSize),
                const SizedBox(width: 8),
              ],

              Flexible(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    text,
                    style: size.textStyle.copyWith(color: foregroundColor),
                  ),
                ),
              ),

              if (trailingIcon != null) ...[
                const SizedBox(width: 8),
                Icon(trailingIcon, color: foregroundColor),
              ],
            ],
          ),
        ),
        // Stack(
        //   alignment: Alignment.center,
        //   // spacing: 12,
        //   // mainAxisAlignment: MainAxisAlignment.center,
        //   children: [
        //     Row(
        //       children: [
        //         if (leadingIcon != null)
        //           Icon(leadingIcon, color: _foregroundColor(context)),

        //         Spacer(),

        //         if (trailingIcon != null)
        //           Icon(trailingIcon, color: _foregroundColor(context)),
        //       ],
        //     ),

        //     Center(
        //       child: Row(
        //         children: [
        //           if (leadingIcon != null) SizedBox(width: 32),
        //           Expanded(
        //             child: FittedBox(
        //               fit: BoxFit.scaleDown,
        //               child: Text(
        //                 text,
        //                 style: size.textStyle.copyWith(color: foregroundColor),
        //               ),
        //             ),
        //           ),
        //           if (trailingIcon != null) SizedBox(width: 32),
        //         ],
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
