import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_header.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';

class AppSection extends StatelessWidget {
  final SectionTrailingType? trailingType;
  final Widget child;
  final Widget? sectionChild;
  final String? sectionTitle;
  final String? trailingText;
  final VoidCallback? onTrailingPressed;

  const AppSection({
    required this.child,
    this.sectionChild,
    this.sectionTitle,
    this.trailingText,
    this.onTrailingPressed,
    this.trailingType,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final shouldShowHeader =
        sectionTitle != null || trailingText != null || trailingType != null;
    return Column(
      spacing: 4,
      children: [
        if (shouldShowHeader)
          AppSectionHeader(
            trailingText: trailingText,
            sectionTitle: sectionTitle!,
            onTrailingPressed: onTrailingPressed,
            trailingType: trailingType,
            child: sectionChild,
          ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: child,
        ),
      ],
    );
  }
}
