import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/app_border_radius.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';

class AppSectionHeader extends StatelessWidget {
  final String sectionTitle;
  final String? trailingText;
  final SectionTrailingType? trailingType;
  final VoidCallback? onTrailingPressed;
  final Color textColor;
  final Widget? child;

  const AppSectionHeader({
    super.key,
    required this.sectionTitle,
    this.textColor = Colors.black,
    this.onTrailingPressed,
    this.trailingText,
    this.trailingType,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Padding(
      padding: AppPadding.pageHorizontal,
      child: SizedBox(
        height: 44,
        child: Row(
          children: [
            Text(sectionTitle, style: AppTextStyle.titleL),

            const Spacer(),

            // Explicit trailing type takes priority.
            if (trailingType != null)
              switch (trailingType) {
                SectionTrailingType.text => Text(
                  trailingText ?? '',
                  style: TextStyle(
                    fontSize: 15,
                    height: 20 / 15,
                    color: colorScheme.primary,
                  ),
                ),

                SectionTrailingType.textButton => TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: colorScheme.appText,
                  ),
                  onPressed: onTrailingPressed,
                  child: Text(
                    trailingText ?? 'See all',
                    style: const TextStyle(fontSize: 15, height: 20 / 15),
                  ),
                ),

                SectionTrailingType.custom => child!,

                _ => const SizedBox.shrink(),
              }
            // No trailing type, but trailing text exists.
            else if (trailingText != null && trailingText!.isNotEmpty)
              Text(
                trailingText!,
                style: TextStyle(
                  fontSize: 15,
                  height: 20 / 15,
                  color: colorScheme.primary,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
