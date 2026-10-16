import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/controller/insurance_company_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/insurance_company_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class SelectInsurerSheet extends StatelessWidget {
  const SelectInsurerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InsuranceCompanyController>();

    return AppSheet(
      adaptiveHeight: true,
      height: AppSheetHeight.full,
      title: 'Select Insurance Company',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: AppSection(
          child: Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.errorMessage.value != null) {
              return Column(
                spacing: 12,
                children: [
                  Text(controller.errorMessage.value!),
                  AppButton(
                    text: 'Retry',
                    onTap: controller.loadCompanies,
                    type: ButtonType.outline,
                  ),
                ],
              );
            }

            if (controller.companies.isEmpty) {
              return const Center(
                child: Text('No insurance companies available.'),
              );
            }

            return Column(
              spacing: 20,
              children: [
                Column(
                  spacing: 12,
                  children:
                      (controller.companies.toList()..sort(
                            (a, b) => (a.shortName).toLowerCase().compareTo(
                              (b.shortName).toLowerCase(),
                            ),
                          ))
                          .map(
                            (company) => InsuranceCompanyCard(company: company),
                          )
                          .toList(),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
