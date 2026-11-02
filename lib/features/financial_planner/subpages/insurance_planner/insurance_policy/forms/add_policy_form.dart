import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/adaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_gradient_card.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/app_snack_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/binding/insurance_company_binding.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/models/insurance_company_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/select_insurer_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/add_policy_controller_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/save_policy_controller_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/add_policy_sheet/sections/benefit_details_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/add_policy_sheet/sections/policy_details/policy_details_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/add_policy_sheet/sections/premium_details_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/add_policy_sheet/sections/select_insurance_product_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/models/insurance_product.dart';
import 'package:getx_drift_app/features/widgets/fields/app_dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddPolicyForm extends GetView<InsurancePolicyController> {
  const AddPolicyForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final isSelectingProduct =
          controller.currentPolicyStep.value == AddPolicyStep.selectProduct;

      return AppSheet(
        // height: isSelectingProduct ? AppSheetHeight.half : AppSheetHeight.full,
        // adaptiveHeight: isSelectingProduct,
        title: isSelectingProduct
            ? 'Select Product Details'
            : 'Add Insurance Policy',

        // child: const SelectProductStep(),
        child: isSelectingProduct
            ? const SelectProductStep()
            : const EnterPolicyDetailsStep(),
      );
    });
  }
}

class SelectProductStep extends GetView<InsurancePolicyController> {
  const SelectProductStep({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSection(
      child: Padding(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 20,
          children: [
            Obx(
              () => AppDropdownField(
                label: 'Insurer',
                value: controller.selectedInsurer.value?.displayName ?? '',
                hint: 'Select insurer',
                showIcon: false,
                onTap: () async {
                  InsuranceCompanyBinding().dependencies();

                  final insurer = await Get.bottomSheet<InsuranceCompany>(
                    const SelectInsurerSheet(),
                    isScrollControlled: true,
                  );

                  if (insurer != null) {
                    controller.setInsurer(insurer);
                  }
                },
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
                          'Choose an insurance company before selecting a product.',
                      type: AppSnackType.warning,
                    );
                    return;
                  }

                  final product = await Get.bottomSheet<InsuranceProduct>(
                    SelectInsuranceProductSheet(insurer: insurer),
                    isScrollControlled: true,
                  );

                  if (product == null) return;

                  debugPrint(
                    'Add policy received product: local ID ${product.id}, '
                    'insurer ID ${product.companyId}',
                  );
                  await controller.setInsuranceProduct(product);
                  controller.goToPolicyDetails();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EnterPolicyDetailsStep extends GetView<InsurancePolicyController> {
  const EnterPolicyDetailsStep({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
      child: Column(
        spacing: 20,
        children: [
          AppSection(
            child: Column(
              children: [
                AppGradientCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              controller.selectedInsurer.value?.name ?? '',
                              style: AppTextStyle.bodyM.copyWith(
                                color: colorScheme.appInversedtext,
                              ),
                            ),
                          ),
                          AdaptivePressable(
                            child: Container(
                              height: 38,
                              width: 38,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: colorScheme.appInversedtext.withValues(
                                  alpha: 0.3,
                                ),
                              ),
                              child: Icon(
                                PhosphorIconsRegular.arrowsCounterClockwise,
                                size: 20,
                                color: colorScheme.appInversedtext,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        controller.selectedProduct.value?.name ?? '',
                        style: AppTextStyle.headlineM.copyWith(
                          color: colorScheme.appInversedtext,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                AppButton(
                  leadingIcon: PhosphorIconsRegular.arrowsCounterClockwise,
                  text: 'Change policy',

                  onTap: () {
                    controller.changeProduct();
                  },
                  size: ButtonSize.medium,
                  type: ButtonType.outline,
                ),
              ],
            ),
          ),
          BenefitsDetailsSection(),
          PolicyDetailsSection(),
          PremiumDetailsSection(),
          AppSection(
            child: Column(
              spacing: 8,
              children: [
                AppButton(
                  text: 'Save policy information',
                  onTap: () {
                    controller.savePolicy();
                    // Get.back();
                    // AppSnackbar.show(
                    //   title: 'Insurance policy has been saved',
                    //   message:
                    //       'AIA Health Invest Plus has been saved. A bill has also been created for this policy.',
                    //   type: AppSnackType.success,
                    // );
                  },
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: 4,
                  children: [
                    Icon(
                      PhosphorIconsRegular.floppyDisk,
                      size: 16,
                      color: colorScheme.appTextMuted,
                    ),
                    Text(
                      'Saving this creates a bill for this policy',
                      style: AppTextStyle.labelM.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
