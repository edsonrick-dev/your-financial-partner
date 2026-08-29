import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/learn_with_ascend/article_block.dart';
import 'package:getx_drift_app/features/learn_with_ascend/article_block_type.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class LearningSheets {
  Future<void> whyFinancialPlanningMatters() async {
    return await Get.bottomSheet(
      AppSheet(
        title: 'Why Financial Planning Matters',
        child: Column(
          children: [
            ArticleBlock(
              type: ArticleBlockType.paragraph,
              content: 'Financial planning is...',
            ),
            ArticleBlock(
              type: ArticleBlockType.heading,
              content: 'Why it matters',
            ),
            ArticleBlock(
              type: ArticleBlockType.paragraph,
              content: 'A financial plan...',
            ),
            ArticleBlock(
              type: ArticleBlockType.callout,
              content: 'Ascend helps you turn information into action.',
            ),
          ],
        ),
      ),
    );
  }
}
