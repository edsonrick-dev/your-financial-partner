import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/insurance_company_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/models/insurance_company_model.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class SelectInsurerSheet extends StatelessWidget {
  const SelectInsurerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      adaptiveHeight: true,
      title: 'Select Insurance Company',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: AppSection(
          child: Column(
            spacing: 20,
            children: [
              Column(
                spacing: 12,
                children: insuranceCompanies.map((company) {
                  return InsuranceCompanyCard(company: company);
                }).toList(),
              ),
              AppButton(
                text: 'Add Insurance Company',
                onTap: () {},
                type: ButtonType.outline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
