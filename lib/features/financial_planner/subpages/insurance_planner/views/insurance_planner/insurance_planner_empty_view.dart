import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsurancePlannerEmptyView extends StatelessWidget {
  const InsurancePlannerEmptyView({super.key});

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
                      PhosphorIconsRegular.shieldPlus,
                      size: 56,
                      color: colorScheme.appAccent,
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Protection planning\nis coming soon',
                      textAlign: TextAlign.center,
                      style: AppTextStyle.headlineL,
                    ),

                    const SizedBox(height: 12),

                    Text(
                      'We’re still building this part of Ascend. '
                      'Insurance planning will help you understand '
                      'your protection needs and identify gaps in your coverage.',
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
            subtitle: 'Build a good understanding of your net worth',
            state: LearningSectionState.available,
            contents: [
              LearnThumbnail(title: 'What is Life Insurance'),
              LearnThumbnail(title: 'Insurance Might Not Be For You'),
              // LearnThumbnail(title: 'What Are Liabilities?'),
            ],
          ),
        ],
      ),
    );
  }
}
