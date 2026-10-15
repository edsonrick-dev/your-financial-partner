import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/details_sheet/insurance_policy_details_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class InsuranceSourceCard extends StatelessWidget {
  const InsuranceSourceCard({
    super.key,
    required this.type,
    required this.amount,
    required this.issuer,
    required this.name,
  });

  final ProtectionType type;
  final String name;
  final String issuer;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppCard(
      onTap: () {
        Get.bottomSheet(
          InsurancePolicyDetailSheet(name: name, issuer: issuer),
          isScrollControlled: true,
        );
      },
      padding: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  issuer,
                  style: AppTextStyle.bodyS.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),
              ),
              Text(
                '${type.label.capitalizeFirst} benefit',
                style: AppTextStyle.bodyS.copyWith(
                  color: colorScheme.appTextMuted,
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 16,
            children: [
              Expanded(child: Text(name, style: AppTextStyle.titleL)),
              Text(amount.toCurrency(), style: AppTextStyle.amountL),
            ],
          ),
        ],
      ),
    );
  }
}
