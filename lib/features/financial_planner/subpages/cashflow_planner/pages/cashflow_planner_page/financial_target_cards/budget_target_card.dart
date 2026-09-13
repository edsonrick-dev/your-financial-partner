import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BudgetTargetCard extends GetView<FinancialProfileController> {
  const BudgetTargetCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Obx(() {
      final idealAnnualBudget = controller.idealAnnualBudget;
      final idealMonthlyBudget = controller.idealMonthlyBudget;

      final monthlyBudgetGap = controller.monthlyBudgetGap;

      final isOverIncome = controller.isBudgetAboveIncome;
      final isOnTarget = controller.hasIdealBudget;

      final monthlyIncome = controller.monthlyIncome;

      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: colorScheme.appInfoSoft,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(PhosphorIconsRegular.coin),
                const SizedBox(width: 12),
                Expanded(
                  child: Text('Your Target Budget', style: AppTextStyle.titleL),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Target is ALWAYS 70% of income.
            Row(
              children: [
                Expanded(
                  child: Text(
                    idealMonthlyBudget.toCurrency(),
                    style: AppTextStyle.amountL,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  '${idealAnnualBudget.toCurrency()} / year',
                  style: AppTextStyle.amountXS.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            // Current situation
            if (isOnTarget)
              Text(
                'Your budget is within 70% of your income, leaving '
                'at least 30% available for savings and investments.',
                style: AppTextStyle.bodyS.copyWith(color: colorScheme.appText),
              )
            else if (isOverIncome)
              RichText(
                text: TextSpan(
                  style: AppTextStyle.bodyS.copyWith(
                    color: colorScheme.appText,
                  ),
                  children: [
                    const TextSpan(
                      text: 'You currently have an average monthly budget of ',
                    ),
                    TextSpan(
                      text: controller.monthlyBudget.toCurrency(),
                      style: AppTextStyle.amountS,
                    ),
                    const TextSpan(text: ' which is '),

                    TextSpan(
                      text: controller.monthlyBudgetGap.toCurrency(),
                      style: AppTextStyle.amountS,
                    ),
                    const TextSpan(text: ' above your monthly income of '),
                    TextSpan(
                      text: monthlyIncome.toCurrency(),
                      style: AppTextStyle.amountS,
                    ),
                    const TextSpan(
                      text:
                          '. Start by reducing your budget to bring it within your income.',
                    ),
                  ],
                ),
              )
            else
              RichText(
                text: TextSpan(
                  style: AppTextStyle.bodyS.copyWith(
                    color: colorScheme.appText,
                  ),
                  children: [
                    const TextSpan(
                      text:
                          'Your budget is within your income. Reduce it '
                          'by ',
                    ),
                    TextSpan(
                      text: monthlyBudgetGap.toCurrency(),
                      style: AppTextStyle.amountS,
                    ),
                    const TextSpan(
                      text:
                          ' per month to reach your 70% target and leave '
                          '30% for savings and investments.',
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 12),

            // Steps
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: colorScheme.bg.withAlpha(230),
              ),
              child: Text(
                isOverIncome
                    ? 'Bring your budget within your income. '
                          'Once sustainable, work toward your target of 70% of income '
                          'to create more room for savings and investments.'
                    : 'Achieving this budget allows you to save 30% of your current income.',
                style: AppTextStyle.bodyS,
              ),
            ),
          ],
        ),
      );
    });
  }
}
