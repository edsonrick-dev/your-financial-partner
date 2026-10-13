import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/controller/protection_questionnaire_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/expense_continuity/inputs/protection_continuity/protection_continuity_questionnaire.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class ProtectionContinuityFundCard
    extends GetView<ProtectionQuestionnaireController> {
  const ProtectionContinuityFundCard({super.key, required this.type});
  final ProtectionType type;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppCard(
      onTap: () async {
        await Get.to(() => ProtectionContinuityQuestionnaire(type: type));
      },
      padding: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(type.continuityFundTitle, style: AppTextStyle.titleL),
          SizedBox(height: 8),
          Text(
            type.continuityFundDescription,
            style: AppTextStyle.labelM.copyWith(
              color: colorScheme.appTextMuted,
            ),
          ),

          SizedBox(height: 16),

          Obx(() {
            final hasMonthlyTotal = controller.continuityMonthlyTotals
                .containsKey(type);

            if (!hasMonthlyTotal) {
              return Text(
                'Tap to configure the expenses used to calculate this fund.',
                style: AppTextStyle.bodyM.copyWith(
                  color: colorScheme.appTextMuted,
                ),
              );
            }
            final monthlyAmount =
                controller.continuityMonthlyTotals[type] ?? 0.0;

            final annualAmount = monthlyAmount * 12;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Annual', style: AppTextStyle.titleL),
                      Text(
                        DateTime.now().year.toString(),
                        style: AppTextStyle.bodyS.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      annualAmount.toCurrency(),
                      style: AppTextStyle.amountL,
                    ),
                    Text(
                      '${monthlyAmount.toCurrency()}/mo',
                      style: AppTextStyle.amountS.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}
