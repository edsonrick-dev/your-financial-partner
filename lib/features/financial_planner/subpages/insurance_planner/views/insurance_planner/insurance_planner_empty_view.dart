import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
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
          AppSectionBody(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    PhosphorIconsRegular.shieldPlus,
                    size: 56,
                    color: colorScheme.appInfo,
                  ),

                  const SizedBox(height: 24),

                  Text(
                    'Protection planning is coming soon',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    'We’re still building this part of Ascend. '
                    'Insurance planning will help you understand '
                    'your protection needs and identify gaps in your coverage.',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: colorScheme.appText,
                      height: 1.4,
                    ),
                  ),
                ],
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
