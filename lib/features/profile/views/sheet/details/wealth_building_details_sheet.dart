import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/wealth_building_rate_scoring.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details/financial_score_disclaimer_section.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details/ratio_scale_painter.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class WealthBuildingDetailsSheet extends GetView<FinancialProfileController> {
  final FinancialRatio ratio;
  const WealthBuildingDetailsSheet({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
    final score = controller.wealthBuilding.scoreBand;
    final ratio = controller.wealthBuildingRatio;
    final colorScheme = context.colors;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 12),
          //Score Summary
          AppSection(
            // sectionTitle: ratio.type.displayName,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${score.category} ', style: AppTextStyle.headlineL),
                SizedBox(height: 12),

                Text(
                  'You are saving up to ${ratio.toStringAsFixed(2)}% of your income. ${score.interpretation}',
                  style: AppTextStyle.bodyM,
                ),
                // Text(score.interpretation, style: AppTextStyle.bodyM),

                // Text(ratio.type.longDescription, style: AppTextStyle.bodyS),
              ],
            ),
          ),

          SizedBox(height: 20),
          AppSection(
            // sectionTitle: 'Debt Load Scale',
            child: AppSectionBody(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        RatioScale(
                          maxValue: 40,
                          value: ratio,
                          bands: wealthBuildingBands,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Slower Pace',
                              style: AppTextStyle.bodyS.copyWith(
                                color: colorScheme.appTextMuted,
                              ),
                            ),
                            Text(
                              'Higher Pace',
                              style: AppTextStyle.bodyS.copyWith(
                                color: colorScheme.appTextMuted,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          AppSection(
            sectionTitle: 'What makes up your wealth-building rate',
            child: AppSectionBody(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _MetricRow(
                      label: 'Annual income',
                      value: controller.annualIncome.toCurrency(),
                    ),
                    const SizedBox(height: 8),
                    _MetricRow(
                      label: 'Annual budget',
                      value: controller.annualBudget.toCurrency(),
                    ),

                    const SizedBox(height: 8),
                    _MetricRow(
                      label: 'Annual surplus',
                      value: controller.annualSavings.toCurrency(),
                    ),

                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: context.colors.appInfoSoft,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Surplus ÷ Income', style: AppTextStyle.bodyM),
                            const SizedBox(width: 8),
                            Text(
                              '= ${ratio.toStringAsFixed(2)}%',
                              style: AppTextStyle.amountL,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 20),

          LearningSection(
            state: LearningSectionState.available,
            subtitle: 'Build a better understanding of wealth building.',
            contents: [
              LearnThumbnail(
                title: 'What is debt load and why is it important to keep low?',
              ),
              LearnThumbnail(title: 'What counts as debt repayment?'),
              LearnThumbnail(title: 'How to improve your Debt Load'),
            ],
          ),
          SizedBox(height: 20),
          FinancialScoreDisclaimerSection(),
          SizedBox(height: 40),
          //Score Explanation
          //Insights
          //Score General
        ],
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: AppTextStyle.bodyM)),
        Text(value, style: AppTextStyle.amountL),
      ],
    );
  }
}
