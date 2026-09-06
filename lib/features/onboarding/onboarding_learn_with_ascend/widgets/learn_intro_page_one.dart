import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_stability_guage.dart';

class LearnIntroPageOne extends StatelessWidget {
  const LearnIntroPageOne({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('For example...', style: AppTextStyle.displayM),

          const SizedBox(height: 16),

          Text(
            'If your profile shows high debt, Ascend will focus on topics that help you reduce debt and regain financial control.',
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
                          score: 18,
                          colorScheme: colorScheme,
                        ),

                        const SizedBox(width: 12),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Critical Stability',
                                style: AppTextStyle.headlineM.copyWith(
                                  color: colorScheme.appText,
                                ),
                              ),

                              Text(
                                'High debt load and low emergency fund.',
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
                        title: 'Understanding your debt',
                        description:
                            'Types of debt, interests, and how they affect your finances',
                      ),
                      LearnThumbnail(
                        showThumbnail: false,
                        showHelper: false,
                        title: 'Debt repayment strategies',
                        description: 'Practical ways to pay off debt faster',
                      ),
                      LearnThumbnail(
                        showThumbnail: false,
                        showHelper: false,
                        title: 'Building an emergency fund',
                        description: 'Start small and build consistency',
                      ),
                      LearnThumbnail(
                        showThumbnail: false,
                        showHelper: false,
                        title: 'Creating a sustainable budget',
                        description: 'Manage expenses and new debt',
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
