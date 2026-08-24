import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

class AppToolbar extends StatelessWidget {
  final bool isDark;
  final String title;

  final VoidCallback? trailingOnPressed;
  final VoidCallback? leadingOnPressed;

  final Color? leadingBackgroundColor;
  final Color? trailingBackgroundColor;

  final Color? leadingForegroundColor;
  final Color? trailingForegroundColor;

  final Widget? leadingIcon;
  final Widget? trailingIcon;

  final bool showLeading;
  final bool showTrailing;

  const AppToolbar({
    super.key,
    this.isDark = false,
    required this.title,
    this.leadingBackgroundColor,
    this.trailingBackgroundColor,
    this.leadingForegroundColor,
    this.trailingForegroundColor,
    this.trailingOnPressed,
    this.leadingOnPressed,
    this.leadingIcon,
    this.trailingIcon,
    this.showLeading = false,
    this.showTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    final leading = leadingIcon ?? const Icon(Icons.close, size: 20);
    final trailing = trailingIcon ?? const Icon(Icons.check, size: 20);
    final colorScheme = context.colors;
    final defaultButtonColor = isDark
        ? colorScheme.appInversedtext
        : Colors.grey[200];
    final defaultButtonForegroundColor = isDark
        ? colorScheme.appInversedtextMuted
        : colorScheme.appText;

    return SizedBox(
      height: 44,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Text(
              title,
              style: AppTextStyle.headlineM.copyWith(
                // fontSize: 17,
                // height: 24 / 17,
                // fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),

            Row(
              children: [
                if (showLeading && leadingOnPressed != null)
                  AdaptivePressable(
                    onTap: leadingOnPressed,
                    child: Container(
                      constraints: BoxConstraints(minWidth: 44),
                      height: 44,
                      width: leadingIcon == null ? 44 : null,
                      padding: leadingIcon == null
                          ? EdgeInsets.zero
                          : EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color:
                            leadingBackgroundColor ??
                            defaultButtonForegroundColor,
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Center(child: leading),
                    ),
                  ),

                const Spacer(),
                if (showTrailing)
                  Opacity(
                    opacity: trailingOnPressed == null ? 0.4 : 1.0,
                    child: AdaptivePressable(
                      onTap: trailingOnPressed,
                      child: Container(
                        constraints: const BoxConstraints(minWidth: 44),
                        height: 44,
                        width: trailingIcon == null ? 44 : null,
                        padding: trailingIcon == null
                            ? EdgeInsets.zero
                            : const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          color: trailingBackgroundColor ?? defaultButtonColor,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Center(child: trailing),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
