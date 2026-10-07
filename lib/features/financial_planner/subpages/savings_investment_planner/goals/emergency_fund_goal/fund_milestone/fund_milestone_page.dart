import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/emergency_fund_priority_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/fund_milestone/widget/fund_milestone_tile.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/profile/financial_ratios/emergency_fund_ratio_scoring.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class EmergencyFundMilestonePage extends GetView<FinancialProfileController> {
  const EmergencyFundMilestonePage({super.key, required this.amountSetAside});

  static const double targetMonths = 12.0;

  final double amountSetAside;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final monthlyBudget = controller.monthlyBudget;

    final currentMonths = monthlyBudget > 0.0
        ? amountSetAside / monthlyBudget
        : 0.0;

    final progress = (currentMonths / targetMonths).clamp(0.0, 1.0);
    final progressRate = progress * 100;
    final targetAmount = monthlyBudget * targetMonths;

    final nextMilestoneMonths = emergencyFundBands
        .where(
          (band) => band.threshold > 0 && band.milestoneMonths > currentMonths,
        )
        .map((band) => band.milestoneMonths)
        .fold<double?>(
          null,
          (current, months) =>
              current == null || months < current ? months : current,
        );
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Emergency Fund', style: AppTextStyle.headlineL),
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              AppSection(
                child: AppSectionBody(
                  padding: 16,
                  child: amountSetAside <= 0
                      ? _EmptyProgressState(targetAmount: targetAmount)
                      : _ProgressState(
                          currentMonths: currentMonths,
                          progress: progress,
                          progressRate: progressRate,
                          amountSetAside: amountSetAside,
                          targetAmount: targetAmount,
                        ),
                ),
              ),

              // AppSection(
              //   child: AppSectionBody(
              //     padding: 16,
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text('Your Progress', style: AppTextStyle.titleL),

              //         const SizedBox(height: 16),

              //         Text(
              //           '${currentMonths % 1 == 0 ? currentMonths.toInt() : currentMonths.toStringAsFixed(1)} ${currentMonths > 1.1 ? 'months' : 'month'}',
              //           style: AppTextStyle.amountXL,
              //         ),

              //         Text(
              //           'of your monthly budget',
              //           style: AppTextStyle.titleL.copyWith(
              //             color: colorScheme.appTextMuted,
              //           ),
              //         ),

              //         const SizedBox(height: 16),
              //         Row(
              //           children: [
              //             Expanded(
              //               child: LinearProgressIndicator(
              //                 value: progress,
              //                 minHeight: 8,
              //                 borderRadius: BorderRadius.circular(8),
              //                 color: colorScheme.appInflow,
              //                 backgroundColor: colorScheme.appTextMuted,
              //               ),
              //             ),
              //             const SizedBox(width: 16),
              //             Text(
              //               '${progressRate.toStringAsFixed(1)}%',
              //               style: AppTextStyle.amountS,
              //             ),
              //           ],
              //         ),

              //         const SizedBox(height: 8),

              //         FittedBox(
              //           fit: BoxFit.scaleDown,
              //           child: Row(
              //             spacing: 6,
              //             children: [
              //               Text(
              //                 amountSetAside.toCurrency(),
              //                 style: AppTextStyle.amountXL,
              //               ),
              //               Text('/', style: AppTextStyle.amountXL),
              //               Text(
              //                 targetAmount.toCurrency(),
              //                 style: AppTextStyle.amountXL.copyWith(
              //                   color: colorScheme.appTextMuted,
              //                 ),
              //               ),
              //             ],
              //           ),
              //         ),
              //         Text(
              //           'Current vs. Target',
              //           style: AppTextStyle.titleL.copyWith(
              //             color: colorScheme.appTextMuted,
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: 20),
              AppSection(
                child: AppSectionBody(
                  padding: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Fund Milestones', style: AppTextStyle.titleL),
                      const SizedBox(height: 8),
                      Text(
                        'Build your emergency fund step by step. Each milestone gives you a stronger financial safety net.',
                        style: AppTextStyle.bodyS.copyWith(),
                      ),
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
                                isNextMilestone:
                                    band.milestoneMonths == nextMilestoneMonths,
                              ),
                            ),
                          ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              AppSection(
                child: AppButton(
                  text: 'Plan My Emergency Fund Contribution',
                  onTap: () {
                    Get.to(
                      () => EmergencyFundPriorityPage(
                        currentAmount: amountSetAside,
                        monthlyBudget: monthlyBudget,
                        netMonthlyCashFlow: controller.monthlyNetCashflow,
                      ),
                    );
                  },
                ),
              ),
              SizedBox(height: context.bottomPaddingSub),
            ],
          ),
        ),
      ),
    );
  }
}

class _EmptyProgressState extends StatelessWidget {
  const _EmptyProgressState({required this.targetAmount});

  final double targetAmount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Progress', style: AppTextStyle.titleL),

        const SizedBox(height: 16),

        Text('No emergency fund yet', style: AppTextStyle.headlineM),

        // const SizedBox(height: 4),

        // Text(
        //   'Based on the previous page you have no emergency fund yet.',
        //   style: AppTextStyle.bodyM.copyWith(color: colorScheme.appTextMuted),
        // ),
        const SizedBox(height: 20),

        Row(
          children: [
            Expanded(
              child: LinearProgressIndicator(
                value: 0,
                minHeight: 8,
                borderRadius: BorderRadius.circular(8),
                color: colorScheme.appInflow,
                backgroundColor: colorScheme.appTextMuted,
              ),
            ),

            const SizedBox(width: 16),

            Text('0%', style: AppTextStyle.amountS),
          ],
        ),

        const SizedBox(height: 8),

        FittedBox(
          fit: BoxFit.scaleDown,
          child: Row(
            spacing: 6,
            children: [
              Text(0.0.toCurrency(), style: AppTextStyle.amountXL),
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
          style: AppTextStyle.titleL.copyWith(color: colorScheme.appTextMuted),
        ),
      ],
    );
  }
}

class _ProgressState extends StatelessWidget {
  const _ProgressState({
    required this.currentMonths,
    required this.progress,
    required this.progressRate,
    required this.amountSetAside,
    required this.targetAmount,
  });

  final double currentMonths;
  final double progress;
  final double progressRate;
  final double amountSetAside;
  final double targetAmount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Progress', style: AppTextStyle.titleL),

        const SizedBox(height: 16),

        Text(
          '${currentMonths % 1 == 0 ? currentMonths.toInt() : currentMonths.toStringAsFixed(1)} '
          '${currentMonths > 1.1 ? 'months' : 'month'}',
          style: AppTextStyle.amountXL,
        ),

        Text(
          'of your monthly budget',
          style: AppTextStyle.titleL.copyWith(color: colorScheme.appTextMuted),
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
              Text(amountSetAside.toCurrency(), style: AppTextStyle.amountXL),
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
          style: AppTextStyle.titleL.copyWith(color: colorScheme.appTextMuted),
        ),
      ],
    );
  }
}
