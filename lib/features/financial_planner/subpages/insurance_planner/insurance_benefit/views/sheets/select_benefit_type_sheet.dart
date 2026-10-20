import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/benefit_type.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class SelectBenefitTypeSheet extends StatelessWidget {
  const SelectBenefitTypeSheet({super.key, required this.onSelected});

  final ValueChanged<BenefitType> onSelected;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSheet(
      title: 'Select Benefit Type',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: AppSection(
          child: Column(
            spacing: 12,
            children: BenefitType.values.map((type) {
              return AppCard(
                onTap: () {
                  onSelected(type);
                  Get.back();
                },
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(type.label, style: AppTextStyle.titleL),
                    Text(
                      type.description,
                      style: AppTextStyle.bodyM.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
