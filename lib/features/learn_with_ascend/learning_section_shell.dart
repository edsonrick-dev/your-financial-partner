import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class LearningSection extends StatelessWidget {
  const LearningSection({super.key, this.contents = const []});
  final List<LearnThumbnail> contents;
  @override
  Widget build(BuildContext context) {
    return AppSection(
      sectionTitle: 'Learn With Ascend',
      // isHorizontalScrolling: true,
      child: Column(spacing: 12, children: contents),
    );
  }
}
