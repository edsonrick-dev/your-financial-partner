import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/domain/enums/app_snack_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/binding/insurance_company_binding.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/models/insurance_company_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/select_insurer_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/add_policy_controller_extension.dart';
// ignore: unused_import
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/add_policy_sheet/add_policy_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/add_policy_sheet/sections/select_insurance_product_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/models/insurance_product.dart';
import 'package:getx_drift_app/features/widgets/fields/app_dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class SelectProductDetailsSheet extends GetView<InsurancePolicyController> {
  const SelectProductDetailsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      adaptiveHeight: true,
      title: 'Product Details',
      child: AppSection(
        child: Column(
          spacing: 20,
          children: [
            Obx(
              () => AppDropdownField(
                label: 'Insurer',
                value: controller.selectedInsurer.value?.displayName ?? '',
                hint: 'Select insurer',
                onTap: () async {
                  final binding = InsuranceCompanyBinding();
                  binding.dependencies();
                  final insurer = await Get.bottomSheet<InsuranceCompany>(
                    const SelectInsurerSheet(),
                    isScrollControlled: true,
                  );

                  if (insurer != null) {
                    controller.setInsurer(insurer);
                  }
                },
                showIcon: false,
              ),
            ),
            Obx(
              () => AppDropdownField(
                label: 'Product Name',
                value: controller.selectedProduct.value?.name ?? '',
                hint: 'Select product',
                showIcon: false,

                onTap: () async {
                  final insurer = controller.selectedInsurer.value;

                  if (insurer == null) {
                    AppSnackbar.show(
                      title: 'Select an insurer first',
                      message:
                          'Choose an insurance company before selecting a policy.',
                      type: AppSnackType.warning,
                    );
                    return;
                  }

                  // if (controller.availableProducts.isEmpty) {
                  //   AppSnackbar.show(
                  //     title: 'No policies available',
                  //     message:
                  //         'No insurance products are currently available for ${insurer.name}.',
                  //     type: AppSnackType.warning,
                  //   );
                  // }

                  final product = await Get.bottomSheet<InsuranceProduct>(
                    SelectInsuranceProductSheet(insurer: insurer),
                    isScrollControlled: true,
                  );
                  // Stop if the user closes the product-selection sheet.
                  if (product == null) return;

                  controller.setInsuranceProduct(product);
                  Get.back(); // Close SelectProductDetailsSheet
                  // Initialize the policy controller before opening the next sheet.
                  // final binding = InsurancePolicyBinding();
                  // binding.dependencies();

                  // Open the next sheet only after a product is selected.
                  Get.bottomSheet(
                    const AddPolicySheet(),
                    isScrollControlled: true,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
