import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_lifestyle_coverage_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/lifestyle_coverage_ratio.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/ratio_scale_painter.dart';
import 'package:getx_drift_app/features/profile/widgets/metric_row.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class FilledLifestyleCoverageView extends GetView<FinancialProfileController> {
  const FilledLifestyleCoverageView({super.key});

  @override
  Widget build(BuildContext context) {
    final score = controller.lifestyleCoverage.scoreBand;
    final ratio = controller.lifestyleCoverageRatio!;
    final duration = controller.lifestyleCoverageDuration;
    final colorScheme = context.colors;

    return Column(
      spacing: 20,
      children: [
        // ---------------------------------------------------------------
        // SCORE SUMMARY
        // ---------------------------------------------------------------
        AppSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(score.category, style: AppTextStyle.headlineL),
              const SizedBox(height: 12),
              Text(
                'Your net worth currently covers approximately '
                '${duration ?? '0 months'} of your planned lifestyle. '
                '${score.interpretation}',
                style: AppTextStyle.bodyM,
              ),
            ],
          ),
        ),

        // ---------------------------------------------------------------
        // SCALE
        // ---------------------------------------------------------------
        AppSection(
          child: AppSectionBody(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  RatioScale(
                    value: ratio,
                    bands: lifestyleCoverageBands,
                    minValue: -1,
                    maxValue: 12,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Lower Coverage',
                        style: AppTextStyle.bodyS.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),
                      Text(
                        'Higher Coverage',
                        style: AppTextStyle.bodyS.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),

        // ---------------------------------------------------------------
        // COMPOSITION
        // ---------------------------------------------------------------
        AppSection(
          sectionTitle: 'What makes up your lifestyle coverage',
          child: AppSectionBody(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  MetricRow(
                    label: 'Net worth',
                    value: controller.netWorth.toCurrency(),
                  ),

                  const SizedBox(height: 8),

                  MetricRow(
                    label: 'Annual lifestyle budget',
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
                                'Net Worth ÷ Annual Budget =',
                                style: AppTextStyle.bodyM,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '${ratio.toStringAsFixed(2)}x',
                                style: AppTextStyle.amountL,
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 8),

                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Approximately ${duration ?? '0 months'}',
                            style: AppTextStyle.bodyM,
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
      ],
    );
  }
}
