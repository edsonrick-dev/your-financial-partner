import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/enum/finanical_ratio_type_enum.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/debt_load_ratio_scoring.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details/financial_score_disclaimer_section.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details/ratio_scale_painter.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class DebtLoadDetails extends GetView<FinancialProfileController> {
  final FinancialRatio ratio;
  const DebtLoadDetails({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
    final score = controller.debtLoad.scoreBand;
    final colorScheme = context.colors;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 12),
          //Score Summary
          Obx(
            () => AppSection(
              // sectionTitle: ratio.type.displayName,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${score.category} ${ratio.type.displayName}',
                    style: AppTextStyle.headlineL,
                  ),
                  SizedBox(height: 12),

                  // Row(
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   children: [
                  //     Text(
                  //       controller.debtLoadRatio.toStringAsFixed(2),
                  //       style: AppTextStyle.amountXL.copyWith(color: score.color),
                  //     ),
                  //     SizedBox(width: 3),
                  //     Text(
                  //       '%',
                  //       style: AppTextStyle.displayS.copyWith(
                  //         color: score.color!.withAlpha(120),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Text(
                    'Your required debt repayments consume ${controller.debtLoadRatio.toStringAsFixed(2)}% of your income. ${score.interpretation}',
                    style: AppTextStyle.bodyM,
                  ),
                  // Text(score.interpretation, style: AppTextStyle.bodyM),

                  // Text(ratio.type.longDescription, style: AppTextStyle.bodyS),
                ],
              ),
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
                          maxValue: 100,
                          value: controller.debtLoadRatio,
                          bands: debtLoadBands,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Lighter burden',
                              style: AppTextStyle.bodyS.copyWith(
                                color: colorScheme.appTextMuted,
                              ),
                            ),
                            Text(
                              'Heavier burden',
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
            sectionTitle: 'What makes up your debt load',
            child: AppSectionBody(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _MetricRow(
                      label: 'Annual debt repayments',
                      value: controller.annualDebtRepayments.value.toCurrency(),
                    ),
                    const SizedBox(height: 8),
                    _MetricRow(
                      label: 'Annual income',
                      value: controller.annualIncome.value.toCurrency(),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Debt Repayments ÷ Income',
                            style: AppTextStyle.bodyM,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '= ${controller.debtLoadRatio.toStringAsFixed(2)}%',
                            style: AppTextStyle.amountL,
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
            subtitle: 'Build a better understanding of your debt.',
            contents: [
              LearnThumbnail(
                title: 'What is debt load and why is it important to keep low?',
              ),
              LearnThumbnail(title: 'What counts as debt repayment?'),
              LearnThumbnail(title: 'How to improve your Debt Load'),
            ],
          ),
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
