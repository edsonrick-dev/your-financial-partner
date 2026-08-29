import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/learn_with_ascend/article_block_type.dart';

class ArticleBlock extends StatelessWidget {
  const ArticleBlock({super.key, required this.type, required this.content});

  final ArticleBlockType type;
  final String content;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case ArticleBlockType.paragraph:
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
          ),
        );

      case ArticleBlockType.heading:
        return Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 12),
          child: Text(
            content,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),
        );

      case ArticleBlockType.callout:
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 8, bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            content,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
          ),
        );
      default:
        return SizedBox.shrink();
    }
  }
}
