import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/emergency_fund_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/fund_milestone/widget/fund_milestone_tile.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/emergency_fund_ratio_scoring.dart';
import 'package:getx_drift_app/features/profile/models/ratio_score_band.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class FundMilestonePage extends GetView<FinancialProfileController> {
  const FundMilestonePage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final amountSetAside = controller.emergencyFundAvailable ?? 0;
    final monthlyBudget = controller.monthlyBudget;

    final currentMonths = monthlyBudget > 0.0
        ? amountSetAside / monthlyBudget
        : 0.0;

    const targetMonths = 12.0;
    final progress = (currentMonths / targetMonths).clamp(0.0, 1.0);
    final progressRate = progress * 100;
    final targetAmount = monthlyBudget * targetMonths;
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppSection(
              child: AppSectionBody(
                padding: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Your Progress', style: AppTextStyle.titleL),

                    const SizedBox(height: 16),

                    Text(
                      '${currentMonths % 1 == 0 ? currentMonths.toInt() : currentMonths.toStringAsFixed(1)} months',
                      style: AppTextStyle.amountXL,
                    ),

                    Text(
                      'of your monthly budget',
                      style: AppTextStyle.titleL.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),

                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: LinearProgressIndicator(
                            value: progress,
                            minHeight: 8,
                            borderRadius: BorderRadius.circular(8),
                            color: colorScheme.appInflow,
                            backgroundColor: colorScheme.appTextMuted,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Text(
                          '${progressRate.toStringAsFixed(1)}%',
                          style: AppTextStyle.amountS,
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        spacing: 6,
                        children: [
                          Text(
                            amountSetAside.toCurrency(),
                            style: AppTextStyle.amountXL,
                          ),
                          Text('/', style: AppTextStyle.amountXL),
                          Text(
                            targetAmount.toCurrency(),
                            style: AppTextStyle.amountXL.copyWith(
                              color: colorScheme.appTextMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      'Current vs. Target',
                      style: AppTextStyle.titleL.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            AppSection(
              child: AppSectionBody(
                padding: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Fund Milestones', style: AppTextStyle.titleL),
                    const SizedBox(height: 16),

                    ...emergencyFundBands.reversed
                        .where((band) => band.threshold > 0)
                        .map(
                          (band) => Padding(
                            padding: const EdgeInsets.only(bottom: 16),
                            child: FundMilestoneTile(
                              band: band,
                              monthlyBudget: monthlyBudget,
                              currentMonths: currentMonths,
                            ),
                          ),
                        ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
