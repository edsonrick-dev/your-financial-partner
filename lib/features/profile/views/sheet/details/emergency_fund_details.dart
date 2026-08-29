import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/emergency_fund_controller_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/emergency_fund_ratio_scoring.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details/financial_score_disclaimer_section.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details/ratio_scale_painter.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class EmergencyFundDetails extends GetView<FinancialProfileController> {
  final FinancialRatio ratio;
  const EmergencyFundDetails({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
    final score = controller.emergencyFund.scoreBand;
    final ratio = controller.emergencyFundRatio;
    final colorScheme = context.colors;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 12),
          //Score Summary
          AppSection(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${score.category} ', style: AppTextStyle.headlineL),
                SizedBox(height: 12),

                Text(score.interpretation, style: AppTextStyle.bodyM),
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
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                'Ideal Emergency Fund',
                                style: AppTextStyle.titleM,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  controller.annualBudget.toCurrency(),
                                  style: AppTextStyle.amountM,
                                ),
                                Text(
                                  '${(controller.annualBudget / 2).toCurrency()} - ${(controller.annualBudget).toCurrency()}',
                                  style: AppTextStyle.amountXS.copyWith(
                                    color: colorScheme.appTextMuted,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        RatioScale(
                          value: controller.emergencyFundRatio ?? 0,
                          bands: emergencyFundBands,
                          minValue: 0,
                          maxValue: 100,
                          labelBuilder: controller.emergencyFundScaleLabel,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'No Fund',
                              style: AppTextStyle.bodyS.copyWith(
                                color: colorScheme.appTextMuted,
                              ),
                            ),
                            Text(
                              'Optimal Fund',
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
          if (controller.isOpportunityFundEnabled)
            AppSection(
              // sectionTitle: 'Debt Load Scale',
              child: AppSectionBody(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Text(
                                  'Opportunity Fund',
                                  style: AppTextStyle.titleM,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    (controller.emergencyFundAvailable -
                                            controller.annualBudget)
                                        .toCurrency(),
                                    style: AppTextStyle.amountM,
                                  ),
                                  Text(
                                    'Available beyond your emergency fund',
                                    style: AppTextStyle.labelXS.copyWith(
                                      color: colorScheme.appTextMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          RatioScale(
                            value: controller.emergencyFundRatio ?? 100,
                            bands: opportunityFundBands,
                            minValue: 100,
                            maxValue: 142.86,
                            labelBuilder: controller.opportunityFundScaleLabel,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Enhanced Fund',
                                style: AppTextStyle.bodyS.copyWith(
                                  color: colorScheme.appTextMuted,
                                ),
                              ),
                              Text(
                                'Wealth-Secured Fund',
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
            sectionTitle: 'Your Available Funds',
            child: AppSectionBody(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _MetricRow(
                      label: 'Liquid funds',
                      value: controller.emergencyFundAvailable.toCurrency(),
                    ),
                    const SizedBox(height: 8),
                    _MetricRow(
                      label: 'Annual budget',
                      value: controller.annualBudget.toCurrency(),
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
                      child: Column(
                        children: [
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Net Worth ÷ Budget =',
                                  style: AppTextStyle.bodyM,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  ratio == null
                                      ? 'N/A'
                                      : '${ratio.toStringAsFixed(2)}%',
                                  style: AppTextStyle.amountL,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 8),
                          FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  controller.emergencyFundDuration == null
                                      ? 'Not assessed'
                                      : 'Approximately ${controller.emergencyFundDuration}',
                                  style: AppTextStyle.bodyM,
                                ),
                              ],
                            ),
                          ),
                        ],
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
            subtitle: 'Build a better understanding of your liquid funds.',
            contents: [
              LearnThumbnail(title: 'What is a Liquid Fund?'),
              LearnThumbnail(title: 'How to Quickly Build Emergency Fund'),
              LearnThumbnail(title: 'What is Opportunity Fund?'),
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
