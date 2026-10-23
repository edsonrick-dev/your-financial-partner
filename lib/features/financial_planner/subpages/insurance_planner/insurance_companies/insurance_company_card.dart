import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/models/insurance_company_model.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class InsuranceCompanyCard extends StatelessWidget {
  const InsuranceCompanyCard({
    super.key,
    required this.company,
    this.onTap,
    this.isSelected = false,
  });

  final InsuranceCompany company;
  final VoidCallback? onTap;
  final bool isSelected;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppCard(
      borderColor: isSelected ? colorScheme.appText : colorScheme.appBorder,
      onTap: () {
        Get.back(result: company);
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            company.name,
            style: AppTextStyle.labelM.copyWith(
              color: colorScheme.appTextMuted,
            ),
          ),

          Text(company.displayName, style: AppTextStyle.titleL.copyWith()),
        ],
      ),
    );
  }
}
