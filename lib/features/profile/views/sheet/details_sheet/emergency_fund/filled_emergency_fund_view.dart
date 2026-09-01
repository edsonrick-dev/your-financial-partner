import 'package:flutter/widgets.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_emergency_fund_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/emergency_fund_ratio_scoring.dart';
import 'package:getx_drift_app/features/profile/views/sheet/details_sheet/ratio_scale_painter.dart';
import 'package:getx_drift_app/features/profile/widgets/metric_row.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class FilledEmergencyFundView extends StatelessWidget {
  const FilledEmergencyFundView({super.key, required this.controller});

  final FinancialProfileController controller;

  @override
  Widget build(BuildContext context) {
    final ratio = controller.emergencyFundRatio!;
    final months = controller.emergencyFundMonths!;
    final score = controller.emergencyFund.scoreBand;
    final colorScheme = context.colors;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),

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
                  'Your emergency fund can cover approximately '
                  '${months.toStringAsFixed(1)} months of your lifestyle '
                  'allocation. ${score.interpretation}',
                  style: AppTextStyle.bodyM,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // ---------------------------------------------------------------
          // SCALE
          // ---------------------------------------------------------------
          AppSection(
            child: AppSectionBody(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    RatioScale(maxValue: 100, value: ratio, bands: fundBands),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Shorter Protection',
                          style: AppTextStyle.bodyS.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),
                        Text(
                          'Longer Protection',
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

          // ---------------------------------------------------------------
          // COMPOSITION
          // ---------------------------------------------------------------
          AppSection(
            sectionTitle: 'What makes up your emergency fund',
            child: AppSectionBody(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    MetricRow(
                      label: 'Liquid funds',
                      value: controller.liquidFunds.toCurrency(),
                    ),

                    const SizedBox(height: 8),

                    MetricRow(
                      label: 'Average daily balance',
                      value: controller.averageDailyBalance!.toCurrency(),
                    ),

                    const SizedBox(height: 8),

                    MetricRow(
                      label: 'Available emergency funds',
                      value: controller.emergencyFundAvailable!.toCurrency(),
                    ),

                    const SizedBox(height: 8),

                    MetricRow(
                      label: 'Annual lifestyle allocation',
                      value: (controller.annualBudget / 0.70).toCurrency(),
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
                            Text(
                              'Emergency Funds ÷ Required Liquidity',
                              style: AppTextStyle.bodyM,
                            ),
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
        ],
      ),
    );
  }
}
