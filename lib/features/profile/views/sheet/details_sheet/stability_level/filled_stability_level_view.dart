import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/widgets/financial_stability_guage.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class FilledStabilityLevelView extends GetView<FinancialProfileController> {
  const FilledStabilityLevelView({super.key});

  @override
  Widget build(BuildContext context) {
    final stability = controller.stability;
    final score = controller.financialScore;
    final colorScheme = context.colors;

    return Column(
      spacing: 20,
      children: [
        // -------------------------------------------------------------------
        // SCORE SUMMARY
        // -------------------------------------------------------------------
        AppSection(
          child: Column(
            children: [
              FinancialStabilityGauge(score: score, colorScheme: colorScheme),

              const SizedBox(height: 20),

              Text(
                stability.title,
                style: AppTextStyle.headlineL.copyWith(color: stability.color),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              Text(
                stability.shortDescription,
                style: AppTextStyle.bodyM,
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              Text('$score / 80', style: AppTextStyle.amountXL),

              const SizedBox(height: 4),

              Text(
                'Financial Stability Score',
                style: AppTextStyle.bodyS.copyWith(
                  color: colorScheme.appTextMuted,
                ),
              ),
            ],
          ),
        ),

        // -------------------------------------------------------------------
        // EXPLANATION
        // -------------------------------------------------------------------
        AppSection(
          sectionTitle: 'What this means',
          child: AppSectionBody(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(stability.longDescription, style: AppTextStyle.bodyM),
            ),
          ),
        ),

        // -------------------------------------------------------------------
        // SCORE COMPONENTS
        // -------------------------------------------------------------------
        AppSection(
          sectionTitle: 'How your score is built',
          child: AppSectionBody(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _ScoreFactor(
                    title: 'Debt Load',
                    description:
                        'Measures how much of your income is committed '
                        'to debt repayments.',
                  ),

                  const SizedBox(height: 16),

                  _ScoreFactor(
                    title: 'Wealth Building',
                    description:
                        'Measures how much of your income remains available '
                        'for building wealth.',
                  ),

                  const SizedBox(height: 16),

                  _ScoreFactor(
                    title: 'Emergency Fund',
                    description:
                        'Measures how many months your emergency funds '
                        'can cover your lifestyle.',
                  ),

                  const SizedBox(height: 16),

                  _ScoreFactor(
                    title: 'Lifestyle Coverage',
                    description:
                        'Measures how long your net worth could support '
                        'your planned lifestyle.',
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ScoreFactor extends StatelessWidget {
  const _ScoreFactor({required this.title, required this.description});

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: AppTextStyle.titleM),
        const SizedBox(height: 4),
        Text(
          description,
          style: AppTextStyle.bodyS.copyWith(
            color: context.colors.appTextMuted,
          ),
        ),
      ],
    );
  }
}
