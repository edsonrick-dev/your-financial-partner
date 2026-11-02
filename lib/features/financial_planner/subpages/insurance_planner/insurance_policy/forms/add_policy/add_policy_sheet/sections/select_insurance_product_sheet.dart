import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/adaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/add_button_state.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/models/insurance_company_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_product/create_insurance_product_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/insurance_product_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_products/models/insurance_product.dart';

import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SelectInsuranceProductSheet extends GetView<InsurancePolicyController> {
  const SelectInsuranceProductSheet({super.key, required this.insurer});

  final InsuranceCompany insurer;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSheet(
      height: AppSheetHeight.full,
      // adaptiveHeight: true,
      title: "Select ${insurer.displayName}'s Product",
      child: Obx(() {
        if (controller.isLoadingProducts.value) {
          return const Padding(
            padding: EdgeInsets.all(32),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        //Check if Online
        // final error = controller.productErrorMessage.value;

        // if (error != null) {
        //   return Padding(padding: const EdgeInsets.all(16), child: Text(error));
        // }

        final products = controller.availableProducts;

        return Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
                child: AppSection(
                  child: Column(
                    spacing: 20,
                    children: [
                      if (products.isEmpty &&
                          controller.createProductButtonState.value ==
                              AddButtonState.collapsed) ...[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 16,
                            right: 16,
                            top: 24,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 64,
                                height: 64,
                                decoration: BoxDecoration(
                                  // color: colorScheme.appSurfaceSecondary,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  PhosphorIconsRegular.shieldCheck,
                                  size: 32,
                                  color: colorScheme.appTextMuted,
                                ),
                              ),
                              const SizedBox(height: 16),
                              Text(
                                'No insurance products yet',
                                style: AppTextStyle.headlineM,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'There are no products listed for ${insurer.displayName}. '
                                'Add a product to continue setting up your policy.',
                                style: AppTextStyle.bodyM.copyWith(
                                  color: colorScheme.appTextMuted,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 24),
                              // CreateInsuranceProductButton(),
                            ],
                          ),
                        ),
                      ] else ...[
                        Column(
                          spacing: 16,
                          children: products.map((product) {
                            final isSelected =
                                controller.selectedProduct.value?.id ==
                                product.id;

                            return InsuranceProductCard(
                              product: product,
                              company: insurer,
                              isSelected: isSelected,
                              onTap: () {
                                Get.back<InsuranceProduct>(result: product);
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 8),
            AppSection(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 12,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Don't see your insurance product?",
                          style: AppTextStyle.labelM,
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Tap the button to add your purchased insurance product and track its benefits and coverage.",
                          style: AppTextStyle.bodyS,
                        ),

                        // CreateInsuranceProductButton(),
                      ],
                    ),
                  ),

                  AdaptivePressable(
                    onTap: () async {
                      // Start with a clean product creation form.
                      controller.resetCreateProductForm();

                      final product = await Get.bottomSheet<InsuranceProduct>(
                        CreateInsuranceProductSheet(insurer: insurer),
                        isScrollControlled: true,
                      );

                      if (product == null) {
                        // User cancelled or dismissed the sheet.
                        controller.resetCreateProductForm();
                        return;
                      }

                      // Return the newly saved product to the selector's parent.
                      debugPrint(
                        'Returning created product from selector: '
                        'local ID ${product.id}, insurer ID ${product.companyId}',
                      );
                      Get.back<InsuranceProduct>(result: product);
                    },

                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        // color: colorScheme.bgLight,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: colorScheme.appBorder),
                      ),
                      child: Center(child: Text('Add product')),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.bottomPaddingSub),
          ],
        );
      }),
    );
  }
}
