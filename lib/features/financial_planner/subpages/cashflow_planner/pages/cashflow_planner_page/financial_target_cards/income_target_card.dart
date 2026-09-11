import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class IncomeTargetCard extends GetView<FinancialProfileController> {
  const IncomeTargetCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Obx(() {
      final idealAnnualIncome = controller.idealAnnualIncome;
      final idealMonthlyIncome = controller.idealMonthlyIncome;
      final isOnTarget = controller.hasIdealIncome;
      final incomeGap = controller.idealIncomeGap;
      final monthlyIncomeGap = controller.monthlyIncomeGap;

      if (idealAnnualIncome == null || idealMonthlyIncome == null) {
        return const SizedBox.shrink();
      }

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
                Icon(PhosphorIconsRegular.target),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    isOnTarget ? 'Income On Target' : 'Your Target Income',
                    style: AppTextStyle.titleL,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Row(
              children: [
                Expanded(
                  child: Text(
                    idealMonthlyIncome.toCurrency(),
                    style: AppTextStyle.amountL,
                  ),
                ),
                SizedBox(width: 12),
                Text(
                  '${idealAnnualIncome.toCurrency()} / year',
                  style: AppTextStyle.amountXS.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),
            if (isOnTarget)
              Text(
                'Your income is sufficient to maintain your current budget '
                'while keeping spending within 70% of income.',
                style: AppTextStyle.bodyS.copyWith(color: colorScheme.appText),
              )
            else ...[
              RichText(
                text: TextSpan(
                  style: AppTextStyle.bodyS.copyWith(
                    color: colorScheme.appText,
                  ),
                  children: [
                    const TextSpan(text: 'You need '),
                    TextSpan(
                      text: incomeGap!.toCurrency(),
                      style: AppTextStyle.amountS,
                    ),
                    const TextSpan(text: ' more annual income or '),
                    TextSpan(
                      text: monthlyIncomeGap!.toCurrency(),
                      style: AppTextStyle.amountS,
                    ),
                    const TextSpan(
                      text: ' more per month to reach your target.',
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 12),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                // border: Border.all(color: colorScheme.appBorder),
                color: colorScheme.bg.withAlpha(230),
              ),
              child: Text(
                'Achieving this income allows you to maintain '
                'your current budget while saving 30% of your income.',
                style: AppTextStyle.bodyS,
              ),
            ),
          ],
        ),
      );
    });
  }
}
