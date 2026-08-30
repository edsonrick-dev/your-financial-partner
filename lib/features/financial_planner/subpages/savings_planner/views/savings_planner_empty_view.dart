import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SavingsPlannerEmptyView extends StatelessWidget {
  const SavingsPlannerEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          AppSection(
            child: AppSectionBody(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 64,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      PhosphorIconsRegular.chartLineUp,
                      size: 56,
                      color: colorScheme.appAccent,
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Savings & investment planner\nis coming soon',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.headlineL,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      "We're still building this part of Ascend. Soon, you'll be able to set savings and investment goals, plan how much to put toward them, and track your progress over time.",
                      textAlign: TextAlign.center,
                      style: AppTextStyle.bodyL,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
          LearningSection(
            subtitle: 'Learn how to turn money into long-term wealth.',
            state: LearningSectionState.available,
            contents: [
              LearnThumbnail(title: 'When to Save Vs When to Invest'),
              LearnThumbnail(title: 'Know When You Are Ready To Invest'),
              // LearnThumbnail(title: 'What Are Liabilities?'),
            ],
          ),
        ],
      ),
    );
  }
}
