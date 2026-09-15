import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AssessmentSummaryView extends GetView<OnboardingController> {
  const AssessmentSummaryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Text("Ascend's Assessment", style: AppTextStyle.headlineL),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSection(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Thanks, ${controller.name.value}.',
                            style: AppTextStyle.displayM,
                          ),

                          const SizedBox(height: 12),

                          Text(
                            'Now Ascend understands more about you.',
                            style: AppTextStyle.headlineM,
                          ),

                          const SizedBox(height: 20),

                          Text(
                            "You've shared your financial picture, your goals, "
                            "your confidence, and how you manage your finances. "
                            "That context helps Ascend understand not just "
                            "where you are, but what kind of guidance can "
                            "be most useful to you.",
                            style: AppTextStyle.bodyL,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    AppSection(
                      sectionTitle: 'What you’ll get from Ascend',
                      child: Column(
                        children: [
                          _BenefitItem(
                            icon: PhosphorIconsRegular.chartDonut,
                            title: 'Financial Stability Profile',
                            description:
                                'Understand where you stand across the '
                                'key areas of your financial life.',
                          ),

                          const SizedBox(height: 20),

                          _BenefitItem(
                            icon: PhosphorIconsRegular.bookOpenText,
                            title: 'Learn With Ascend',
                            description:
                                'Get learning content tailored to your '
                                'financial situation, goals, and priorities.',
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    AppSection(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Your profile is just the beginning.',
                            style: AppTextStyle.titleL,
                          ),

                          const SizedBox(height: 12),

                          Text(
                            'Ascend will use what you’ve shared, together '
                            'with your financial picture, to help surface '
                            'the topics and guidance that are most relevant '
                            'to your journey.',
                            style: AppTextStyle.bodyM,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            AppSection(
              child: AppButton(
                text: 'Reveal my Financial Stability Profile',
                onTap: controller.completeAssessment,
              ),
            ),

            // SizedBox(height: context.bottomPadding),
          ],
        ),
      ),
    );
  }
}

class _BenefitItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;

  const _BenefitItem({
    required this.icon,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Theme.of(context).colorScheme.buttonBackground,
          ),
          child: Icon(
            icon,
            size: 24,
            color: colorScheme.pageShifterTextSelected,
          ),
        ),

        const SizedBox(width: 16),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyle.titleM),

              const SizedBox(height: 4),

              Text(description, style: AppTextStyle.bodyM),
            ],
          ),
        ),
      ],
    );
  }
}
