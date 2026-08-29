import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/learn_with_ascend/article_block_type.dart';

class ArticleBlock extends StatelessWidget {
  const ArticleBlock({super.key, required this.type, required this.content});

  final ArticleBlockType type;
  final String content;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    switch (type) {
      case ArticleBlockType.paragraph:
        return Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(content, style: AppTextStyle.bodyM),
          ),
        );

      case ArticleBlockType.heading:
        return Padding(
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 12,
            left: 16,
            right: 16,
          ),
          // padding: const EdgeInsets.only(top: 8, bottom: 12),
          child: Text(
            content,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        );

      case ArticleBlockType.callout:
        return Padding(
          padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
          child: Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: colorScheme.appInfoSoft,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: colorScheme.appBorderMuted),
            ),
            child: Text(
              content,
              style: AppTextStyle.titleM.copyWith(color: colorScheme.appText),
            ),
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }
}
