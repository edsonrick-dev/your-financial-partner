import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/enum/finanical_ratio_type_enum.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/debt_load_ratio_scoring.dart';
import 'package:getx_drift_app/features/profile/models/financial_ratio_model.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/ratio_scale_painter.dart';
import 'package:getx_drift_app/features/profile/widgets/metric_row.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class FilledDebtLoadView extends GetView<FinancialProfileController> {
  final FinancialRatio ratio;

  const FilledDebtLoadView({super.key, required this.ratio});

  @override
  Widget build(BuildContext context) {
    final value = ratio.value!;

    final score = ratio.scoreBand;
    final colorScheme = context.colors;

    final detailsTitle = score.threshold == 0
        ? score.category
        : '${score.category} ${ratio.type.displayName}';

    return Column(
      children: [
        AppSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(detailsTitle, style: AppTextStyle.headlineL),
              const SizedBox(height: 12),

              Text(
                'Your required debt repayments consume '
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
                  RatioScale(maxValue: 100, value: value, bands: debtLoadBands),

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
          ),
        ),

        const SizedBox(height: 20),

        AppSection(
          sectionTitle: 'What makes up your debt load',
          child: AppSectionBody(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  MetricRow(
                    label: 'Annual debt repayments',
                    value: controller.annualDebtRepayments.toCurrency(),
                  ),
                  const SizedBox(height: 8),
                  MetricRow(
                    label: 'Annual income',
                    value: controller.annualIncome.toCurrency(),
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
                          '= ${value.toStringAsFixed(1)}%',
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
      ],
    );
  }
}
