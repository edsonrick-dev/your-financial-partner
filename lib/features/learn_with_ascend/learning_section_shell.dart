import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

enum LearningSectionState { noContent, available, allCompleted }

class LearningSection extends StatelessWidget {
  const LearningSection({
    super.key,
    this.contents = const [],
    this.subtitle,
    this.onTrailingPress,
    this.state = LearningSectionState.noContent,
  });

  final List<LearnThumbnail> contents;
  final String? subtitle;
  final VoidCallback? onTrailingPress;
  final LearningSectionState state;

  @override
  Widget build(BuildContext context) {
    return AppSection(
      sectionTitle: 'Learn With Ascend',
      trailingType: SectionTrailingType.textButton,
      trailingText: 'See More',
      onTrailingPressed: () {
        Get.bottomSheet(
          AppSheet(
            title: 'AscendYFP Learning Library',
            child: SingleChildScrollView(),
          ),
        );
      },
      subtitle: subtitle,
      child: switch (state) {
        LearningSectionState.available => Column(
          spacing: 12,
          children: contents,
        ),

        LearningSectionState.noContent => const _LearningEmptyView(
          icon: Icons.menu_book_outlined,
          title: 'No lessons available yet',
          description: 'New lessons are coming soon.',
        ),

        LearningSectionState.allCompleted => const _LearningEmptyView(
          icon: Icons.check_circle_outline,
          title: "You're all caught up",
          description: 'You’ve completed all available lessons.',
        ),
      },
    );
  }
}

class _LearningEmptyView extends StatelessWidget {
  const _LearningEmptyView({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 32, color: colorScheme.appText),
          const SizedBox(height: 12),
          Text(title, style: AppTextStyle.titleM, textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(
            description,
            style: AppTextStyle.bodyS.copyWith(color: colorScheme.appTextMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
