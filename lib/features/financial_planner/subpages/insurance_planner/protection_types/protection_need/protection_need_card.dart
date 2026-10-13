import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_action_resolver.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_amount_resolver.dart';

import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class ProtectionNeedCard extends GetView<InsurancePlannerController> {
  const ProtectionNeedCard({
    super.key,
    required this.needType,
    required this.type,
    this.amount,

    this.onTap,
  });

  final double? amount;
  final ProtectionType type;
  final VoidCallback? onTap;
  final ProtectionNeedType needType;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppCard(
      onTap:
          onTap ??
          ProtectionNeedActionResolver.resolve(
            type: type,
            needType: needType,
            controller: controller,
          ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(needType.icon),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(needType.title, style: AppTextStyle.titleL),
                    ),
                    const SizedBox(width: 12),
                    Obx(() {
                      final resolvedAmount = resolveProtectionNeedAmount(
                        type: type,
                        needType: needType,
                        controller: controller,
                      );

                      final amountText = switch (resolvedAmount) {
                        null => 'Not configured',
                        0 => resolvedAmount.toCurrency(decimalDigits: 0),
                        _ => resolvedAmount.toCompactCurrency(),
                      };

                      return Text(amountText, style: AppTextStyle.amountL);
                    }),
                    // Text(() {
                    //   final resolvedAmount = resolveProtectionNeedAmount(
                    //     type: type,
                    //     needType: needType,
                    //     controller: controller,
                    //   );

                    //   if (resolvedAmount == null) {
                    //     return 'Not configured';
                    //   }

                    //   return resolvedAmount == 0
                    //       ? resolvedAmount.toCurrency(decimalDigits: 0)
                    //       : resolvedAmount.toCompactCurrency();
                    // }(), style: AppTextStyle.amountL),
                  ],
                ),
                Text(
                  needType.description,
                  style: AppTextStyle.labelM.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
