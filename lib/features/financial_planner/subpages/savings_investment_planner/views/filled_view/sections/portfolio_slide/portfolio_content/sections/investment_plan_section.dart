import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/controller/savings_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/views/sheet/goal_setting_sheet.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InvestmentPlanSection extends GetView<SavingsPlannerController> {
  const InvestmentPlanSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Obx(() {
      final targetInvestment = controller.investmentTarget;
      final currentInvestment = controller.currentInvestment;
      final hasGoals = controller.goals.isNotEmpty;

      if (!hasGoals) {
        return const _NoInvestmentTarget();
      }

      final remainingAmount = (targetInvestment - currentInvestment).clamp(
        0.0,
        double.infinity,
      );

      final completionRate = targetInvestment > 0
          ? (currentInvestment / targetInvestment).clamp(0.0, 1.0)
          : 0.0;

      return AppSection(
        child: Container(
          padding: const EdgeInsets.all(24),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: AppGradient.gradientA(colorScheme),
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '2026 Savings & Investment Target',
                style: AppTextStyle.titleL.copyWith(
                  color: colorScheme.appInversedtextMuted,
                ),
              ),

              const SizedBox(height: 16),

              LinearProgressIndicator(
                value: completionRate,
                minHeight: 8,
                borderRadius: BorderRadius.circular(10),
                backgroundColor: colorScheme.appInversedtext.withAlpha(40),
                color: colorScheme.appAccent,
              ),

              const SizedBox(height: 8),

              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Year-to-date',
                          style: AppTextStyle.bodyS.copyWith(
                            color: colorScheme.appInversedtextMuted,
                          ),
                        ),
                        Text(
                          currentInvestment.toCurrency(),
                          style: AppTextStyle.amountL.copyWith(
                            color: colorScheme.appInversedtext,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'End of year target',
                          style: AppTextStyle.bodyS.copyWith(
                            color: colorScheme.appInversedtextMuted,
                          ),
                        ),
                        Text(
                          targetInvestment.toCurrency(),
                          style: AppTextStyle.amountL.copyWith(
                            color: colorScheme.appInversedtext,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              Column(
                spacing: 4,
                children: [
                  Divider(color: colorScheme.appInversedtext),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Remaining',
                          style: AppTextStyle.bodyM.copyWith(
                            color: colorScheme.appInversedtextMuted,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24,
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            remainingAmount.toCurrency(),
                            style: AppTextStyle.amountL.copyWith(
                              color: colorScheme.appInversedtext,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _NoInvestmentTarget extends StatelessWidget {
  const _NoInvestmentTarget();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSection(
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: AppGradient.gradientA(colorScheme),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Icon(
              PhosphorIconsRegular.target,
              size: 48,
              color: colorScheme.appAccent,
            ),

            const SizedBox(height: 12),

            Text(
              'No investment target yet',
              style: AppTextStyle.titleL.copyWith(
                color: colorScheme.appInversedtext,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 4),

            Text(
              'Set a financial goal to give your savings and investments a target to work toward.',
              style: AppTextStyle.bodyM.copyWith(
                color: colorScheme.appInversedtextMuted,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 16),

            AppButton(
              type: ButtonType.outline,
              text: 'Set Financial Goals',
              onTap: () {
                Get.bottomSheet(GoalSettingSheet(), isScrollControlled: true);
              },
            ),
          ],
        ),
      ),
    );
  }
}
