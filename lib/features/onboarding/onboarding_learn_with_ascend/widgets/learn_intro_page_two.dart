import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_stability_guage.dart';

class LearnIntroPageTwo extends StatelessWidget {
  const LearnIntroPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Different profile, different topics',
            style: AppTextStyle.displayM,
          ),

          const SizedBox(height: 16),

          Text(
            '''If your profile is stronger, you'll see more topics on growing your wealth, investing, and long term planning.''',
            style: AppTextStyle.bodyL,
          ),

          const SizedBox(height: 8),

          // Temporary illustration area.
          // Replace this with your actual illustration.
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.fromLTRB(16, 16, 20, 16),
                    decoration: BoxDecoration(
                      color: colorScheme.bgLight,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: AppShadows.card(colorScheme.appText),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FinancialStabilityGauge(
                          score: 65,
                          colorScheme: colorScheme,
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Good Stability',
                                style: AppTextStyle.headlineM.copyWith(
                                  color: colorScheme.appText,
                                ),
                              ),

                              Text(
                                'Solid foundation with room to grow.',
                                style: AppTextStyle.bodyM.copyWith(
                                  color: colorScheme.appText,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    '''You'll get topics like''',
                    style: AppTextStyle.titleL,
                  ),
                  SizedBox(height: 20),

                  Column(
                    spacing: 16,
                    children: [
                      LearnThumbnail(
                        showThumbnail: false,
                        showHelper: false,
                        title: 'Building and growing wealth',
                        description: 'Make your savings work harder',
                      ),
                      LearnThumbnail(
                        showThumbnail: false,
                        showHelper: false,
                        title: 'Investing basics',
                        description: 'Learn how to start and build confidence',
                      ),
                      LearnThumbnail(
                        showThumbnail: false,
                        showHelper: false,
                        title: 'Insurance and protection',
                        description: '''Prepare for life's uncertainties''',
                      ),
                      LearnThumbnail(
                        showThumbnail: false,
                        showHelper: false,
                        title: 'Long term financial planning',
                        description: 'Set your self up for future goals',
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
