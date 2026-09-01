import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/wealth_building_rate_scoring.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/ratio_scale_painter.dart';
import 'package:getx_drift_app/features/profile/widgets/metric_row.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class FilledWealthBuildingView extends GetView<FinancialProfileController> {
  final FinancialRatio ratio;

  const FilledWealthBuildingView({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
    final value = ratio.value!;
    final score = ratio.scoreBand;
    final colorScheme = context.colors;

    return Column(
      children: [
        AppSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(score.category, style: AppTextStyle.headlineL),

              const SizedBox(height: 12),

              Text(
                'You are saving up to '
                '${value.toStringAsFixed(2)}% of your income. '
                '${score.interpretation}',
                style: AppTextStyle.bodyM,
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        AppSection(
          child: AppSectionBody(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  RatioScale(
                    maxValue: 40,
                    value: value,
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
          ),
        ),

        const SizedBox(height: 20),

        AppSection(
          sectionTitle: 'What makes up your wealth-building rate',
          child: AppSectionBody(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  MetricRow(
                    label: 'Annual income',
                    value: controller.annualIncome.toCurrency(),
                  ),

                  const SizedBox(height: 8),

                  MetricRow(
                    label: 'Annual budget',
                    value: controller.annualBudget.toCurrency(),
                  ),

                  const SizedBox(height: 8),

                  MetricRow(
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
                            '= ${value.toStringAsFixed(2)}%',
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
      ],
    );
  }
}
