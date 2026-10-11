import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class ProtectionNeedCard extends GetView<InsurancePlannerController> {
  const ProtectionNeedCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.amount,
    this.countLabel,
    this.count,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final String description;
  final double amount;
  final double? count;
  final String? countLabel;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: Text(title, style: AppTextStyle.titleL)),
                    SizedBox(width: 12),
                    Text(
                      amount == 0
                          ? amount.toCurrency(decimalDigits: 0)
                          : amount.toCompactCurrency(),
                      style: AppTextStyle.amountL,
                    ),
                  ],
                ),
                // SizedBox(height: 8),
                Text(
                  description,
                  style: AppTextStyle.labelM.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),
                // if (count != null && countLabel != null)
                //   Text(
                //     '${count!.toStringAsFixed(0)} $countLabel',
                //     style: AppTextStyle.titleL,
                //   ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
