import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/design_system/shifters/segment_shifter/app_segmented_selector.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/controller/savings_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/investor_profile/investory_profile_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/asset_class/asset_class_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/portfolio_horizon_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/portfolio_recommendation/portfolio_recommendation.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/portfolio_recommendation/portfolio_recommendation_engine.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/portfolio/risk_return/risk_return_range_model.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class InvestorProfileSheet extends GetView<SavingsPlannerController> {
  const InvestorProfileSheet({super.key, required this.profile});

  final InvestorProfile profile;

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      height: AppSheetHeight.full,
      title: 'Your Investor Profile',
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 16,
                right: 16,
                bottom: context.bottomPaddingSub,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 24,
                children: [
                  _ProfileHeader(profile: profile),
                  _IntroText(),
                  Obx(() {
                    final index = controller.selectedHorizonTabIndex.value;

                    return Column(
                      children: [
                        AppSegmentedSelector(
                          items: PortfolioHorizon.values
                              .map((horizon) => horizon.label)
                              .toList(),
                          selectedIndex: index,
                          onChanged: controller.selectHorizonTab,
                        ),

                        const SizedBox(height: 12),

                        AnimatedSize(
                          duration: const Duration(milliseconds: 160),
                          curve: Curves.easeInOut,
                          alignment: Alignment.topCenter,
                          child: controller.selectedHorizonTabIndex.value == 0
                              ? _PortfolioSection(
                                  title: 'Short Horizon',
                                  subtitle: '0–2 years',
                                  recommendation:
                                      PortfolioRecommendationEngine.getRecommendation(
                                        profile: profile,
                                        horizon: PortfolioHorizon.short,
                                      ),
                                )
                              : controller.selectedHorizonTabIndex.value == 1
                              ? _PortfolioSection(
                                  title: 'Medium Horizon',
                                  subtitle: '2–5 years',
                                  recommendation:
                                      PortfolioRecommendationEngine.getRecommendation(
                                        profile: profile,
                                        horizon: PortfolioHorizon.medium,
                                      ),
                                )
                              : _PortfolioSection(
                                  title: 'Long Horizon',
                                  subtitle: '5+ years',
                                  recommendation:
                                      PortfolioRecommendationEngine.getRecommendation(
                                        profile: profile,
                                        horizon: PortfolioHorizon.long,
                                      ),
                                ),
                        ),
                      ],
                    );
                  }),

                  _WhyItChangesSection(),

                  _EmergencyFundNote(),
                ],
              ),
            ),
          ),

          // Padding(
          //   padding: EdgeInsets.fromLTRB(20, 12, 20, context.bottomPaddingSub),
          //   child: AppButton(
          //     text: 'Got it',
          //     onTap: () => Navigator.of(context).pop(),
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.profile});

  final InvestorProfile profile;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      spacing: 12,
      children: [
        Text(profile.label, style: AppTextStyle.headlineL),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: context.colors.appInflow.withAlpha(25),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            'Based on your risk assessment',
            style: AppTextStyle.bodyS,
          ),
        ),

        Text(
          profile.description,
          style: AppTextStyle.bodyL,
          textAlign: TextAlign.justify,
        ),
      ],
    );
  }
}

class _PortfolioSection extends StatelessWidget {
  const _PortfolioSection({
    required this.title,
    required this.subtitle,
    required this.recommendation,
  });

  final String title;
  final String subtitle;
  final PortfolioRecommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final range = recommendation.returnRange;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        AppSectionBody(
          padding: 16,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Text(title, style: AppTextStyle.headlineM),
                  Text(subtitle, style: AppTextStyle.bodyM),
                ],
              ),
              _AllocationBar(recommendation: recommendation),

              Column(
                spacing: 10,
                children: recommendation.allocations
                    .map(
                      (allocation) => _AllocationRow(
                        color: allocation.assetClass.color(context),
                        label: allocation.assetClass.label,
                        percentage: allocation.weight,
                      ),
                    )
                    .toList(),
              ),
              const Divider(),
              Row(
                children: [
                  Expanded(
                    child: _Metric(
                      label: 'Expected return',
                      value: '${(range.average * 100).toStringAsFixed(1)}%',
                    ),
                  ),
                  Expanded(
                    child: _Metric(
                      label: 'Volatility',
                      value:
                          '± ${(range.standardDeviation * 100).toStringAsFixed(1)}%',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        _ReturnScenarioSection(range: range),
      ],
    );
  }
}

class _ReturnScenarioSection extends StatelessWidget {
  const _ReturnScenarioSection({required this.range});

  final RiskReturnRange range;

  double _roundedPercentage(double value) {
    return double.parse((value * 100).toStringAsFixed(1));
  }

  @override
  Widget build(BuildContext context) {
    final average = _roundedPercentage(range.average);
    final volatility = _roundedPercentage(range.standardDeviation);

    final lower = average - volatility;
    final upper = average + volatility;

    return AppSectionBody(
      padding: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 12,
        children: [
          Text(
            'Illustrative annual return range',
            style: AppTextStyle.headlineM,
          ),

          Text(
            'Based on the portfolio’s expected return and '
            'modeled volatility.',
            style: AppTextStyle.bodyM,
          ),

          Row(
            children: [
              Expanded(
                child: _ScenarioMetric(
                  label: 'Worst case',
                  value: _formatSignedPercentage(lower),
                ),
              ),
              Expanded(
                child: _ScenarioMetric(
                  label: 'Average',
                  value: _formatSignedPercentage(average),
                ),
              ),
              Expanded(
                child: _ScenarioMetric(
                  label: 'Best case',
                  value: _formatSignedPercentage(upper),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatSignedPercentage(double value) {
    return '${value >= 0 ? '+' : ''}'
        '${value.toStringAsFixed(1)}%';
  }
}

class _ScenarioMetric extends StatelessWidget {
  const _ScenarioMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyS.copyWith(
            color: context.colors.appTextMuted,
          ),
        ),
        Text(value, style: AppTextStyle.amountL),
      ],
    );
  }
}

class _AllocationRow extends StatelessWidget {
  const _AllocationRow({
    required this.label,
    required this.percentage,
    required this.color,
  });

  final String label;
  final double percentage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          height: 8,
          width: 8,
        ),
        SizedBox(width: 8),
        Expanded(child: Text(label, style: AppTextStyle.bodyM)),
        Text(
          '${(percentage * 100).toStringAsFixed(0)}%',
          style: AppTextStyle.amountM,
        ),
      ],
    );
  }
}

class _AllocationBar extends StatelessWidget {
  const _AllocationBar({required this.recommendation});

  final PortfolioRecommendation recommendation;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: SizedBox(
        height: 16,
        child: Row(
          children: recommendation.allocations.map((allocation) {
            return Expanded(
              flex: (allocation.weight * 1000).round(),
              child: Container(color: allocation.assetClass.color(context)),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyS.copyWith(
            color: context.colors.appTextMuted,
          ),
        ),
        Text(value, style: AppTextStyle.amountL),
      ],
    );
  }
}

class _IntroText extends StatelessWidget {
  const _IntroText();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Your profile helps us understand how comfortable '
      'you are with investment risk. Your goal horizon then '
      'helps determine how that risk should be allocated.',
      style: AppTextStyle.bodyL,
      textAlign: TextAlign.justify,
    );
  }
}

class _WhyItChangesSection extends StatelessWidget {
  const _WhyItChangesSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 8,
      children: [
        Text('Why does the mix change?', style: AppTextStyle.headlineM),
        Text(
          'Money needed sooner generally has less time to '
          'recover from market declines. Longer-term goals '
          'can generally accommodate more investment risk '
          'within the model.',
          style: AppTextStyle.bodyL,
        ),
      ],
    );
  }
}

class _EmergencyFundNote extends StatelessWidget {
  const _EmergencyFundNote();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: context.colors.bgLight,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.appBorder),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 8,
        children: [
          Text('One important exception', style: AppTextStyle.headlineM),
          Text(
            'Your emergency fund is not included in these '
            'investment portfolios. It is kept in cash so '
            'it remains readily available when you need it.',
            style: AppTextStyle.bodyM,
          ),
        ],
      ),
    );
  }
}
