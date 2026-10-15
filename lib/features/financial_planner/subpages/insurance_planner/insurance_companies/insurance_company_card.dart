import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/models/insurance_company_model.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class InsuranceCompanyCard extends StatelessWidget {
  const InsuranceCompanyCard({super.key, required this.company, this.onTap});

  final InsuranceCompany company;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return AppCard(
      onTap: () {
        Get.back(result: company);
      },
      child: Row(children: [Text(company.name, style: AppTextStyle.titleL)]),
    );
  }
}
