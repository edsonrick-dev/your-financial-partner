import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/app_border_radius.dart';
import 'package:getx_drift_app/core/constants/app_scale.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
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
  final String? subtitle;
  const AppSectionHeader({
    super.key,
    required this.sectionTitle,
    this.subtitle,
    this.textColor = Colors.black,
    this.onTrailingPressed,
    this.trailingText,
    this.trailingType,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final minHeight = AppTapArea.medium;

    return Padding(
      padding: AppPadding.pageHorizontal,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  constraints: BoxConstraints(minHeight: minHeight),
                  // color: colorScheme.appOutflow,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(sectionTitle, style: AppTextStyle.titleL),
                      if (subtitle != null && subtitle!.isNotEmpty) ...[
                        // SizedBox(height: 4),
                        Text(
                          subtitle!,
                          style: AppTextStyle.labelM.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),
                        SizedBox(height: 12),
                      ],
                    ],
                  ),
                ),
              ),

              if (trailingType != null) ...[
                SizedBox(width: AppScale.x3),
                switch (trailingType) {
                  SectionTrailingType.textButton => AdaptivePressable(
                    onTap: onTrailingPressed,
                    child: Container(
                      constraints: BoxConstraints(minHeight: minHeight),
                      child: Center(
                        child: Text(
                          trailingText ?? 'See all',
                          style: AppTextStyle.labelM,
                        ),
                      ),
                    ),
                  ),

                  SectionTrailingType.custom => child!,

                  _ => const SizedBox.shrink(),
                },
              ]
              // No trailing type, but trailing text exists.
              else if (trailingText != null && trailingText!.isNotEmpty)
                Text(trailingText!, style: AppTextStyle.labelM),
            ],
          ),
        ],
      ),
    );
  }
}
