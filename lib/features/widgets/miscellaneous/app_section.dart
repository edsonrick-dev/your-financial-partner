import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_header.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';

class AppSection extends StatelessWidget {
  final SectionTrailingType? trailingType;
  final Widget child;
  final Widget? trailingWidget;
  final String? sectionTitle;
  final String? trailingText;
  final VoidCallback? onTrailingPressed;
  final bool isHorizontalScrolling;

  const AppSection({
    required this.child,
    this.trailingWidget,
    this.sectionTitle,
    this.trailingText,
    this.onTrailingPressed,
    this.trailingType,
    this.isHorizontalScrolling = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final shouldShowHeader =
        sectionTitle != null || trailingText != null || trailingType != null;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 4,
      children: [
        if (shouldShowHeader)
          AppSectionHeader(
            trailingText: trailingText,
            sectionTitle: sectionTitle!,
            onTrailingPressed: onTrailingPressed,
            trailingType: trailingType,
            child: trailingWidget,
          ),
        isHorizontalScrolling
            ? SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                clipBehavior: Clip.none,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                child: child,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: child,
              ),
      ],
    );
  }
}
