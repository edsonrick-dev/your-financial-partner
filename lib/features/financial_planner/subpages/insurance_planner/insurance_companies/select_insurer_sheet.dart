import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/controller/insurance_company_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/insurance_company_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/models/insurance_company_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class SelectInsurerSheet extends StatelessWidget {
  const SelectInsurerSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InsuranceCompanyController>();
    final policyController = Get.find<InsurancePolicyController>();

    return AppSheet(
      adaptiveHeight: true,
      height: AppSheetHeight.full,
      title: 'Select Insurance Company',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: AppSection(
          child: Obx(() {
            if (controller.companies.isNotEmpty) {
              final companies = controller.companies.toList()
                ..sort(
                  (a, b) => a.displayName.toLowerCase().compareTo(
                    b.displayName.toLowerCase(),
                  ),
                );

              return Column(
                spacing: 12,
                children: companies.map((company) {
                  final isSelected =
                      policyController.selectedInsurer.value?.id == company.id;

                  return InsuranceCompanyCard(
                    company: company,
                    isSelected: isSelected,
                    onTap: () {
                      Get.back<InsuranceCompany>(result: company);
                    },
                  );
                }).toList(),
              );
            }

            if (controller.isLoading.value) {
              //Skeleton
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.errorMessage.value != null) {
              return Column(
                spacing: 12,
                children: [
                  Text(controller.errorMessage.value!),
                  AppButton(
                    text: 'Retry',
                    onTap: controller.refreshCatalogInBackground,
                    type: ButtonType.outline,
                  ),
                ],
              );
            }

            return const Center(
              child: Text('No insurance companies available.'),
            );
          }),
        ),
      ),
    );
  }
}
