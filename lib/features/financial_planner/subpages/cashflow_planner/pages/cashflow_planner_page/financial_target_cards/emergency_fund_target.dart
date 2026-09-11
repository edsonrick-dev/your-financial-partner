import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_emergency_fund_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EmergencyFundTargetCard extends GetView<FinancialProfileController> {
  const EmergencyFundTargetCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Obx(() {
      final targetBand = controller.currentEmergencyFundTargetBand;
      final target = controller.currentEmergencyFundTarget;
      final targetMonths = controller.currentEmergencyFundTargetMonths;
      final gap = controller.emergencyFundTargetGap;

      return Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: colorScheme.bgLight,
          boxShadow: AppShadows.card(colorScheme.appText),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Stack(children: [Icon(PhosphorIconsRegular.shield)]),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    targetBand == null
                        ? 'Emergency Fund Complete'
                        : '${targetMonths!.round()}-Month Emergency Fund',
                    style: AppTextStyle.titleL,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            if (target != null) ...[
              Text(target.toCurrency(), style: AppTextStyle.amountL),

              Text(
                '${targetMonths!.round()}x your average monthly budget',
                style: AppTextStyle.bodyS,
              ),

              RichText(
                text: TextSpan(
                  style: AppTextStyle.bodyS.copyWith(
                    color: colorScheme.appText,
                  ),
                  children: [
                    const TextSpan(text: '('),
                    TextSpan(
                      text: controller.averageMonthlyBudget.toCurrency(),
                      style: AppTextStyle.amountS,
                    ),
                    const TextSpan(text: '/mo)'),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              RichText(
                text: TextSpan(
                  style: AppTextStyle.bodyS.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                  children: [
                    const TextSpan(text: 'Your emergency fund is '),
                    TextSpan(
                      text: gap!.toCurrency(),
                      style: AppTextStyle.amountS,
                    ),
                    const TextSpan(text: ' short of your target.'),
                  ],
                ),
              ),
            ],
          ],
        ),
      );
    });
  }
}
