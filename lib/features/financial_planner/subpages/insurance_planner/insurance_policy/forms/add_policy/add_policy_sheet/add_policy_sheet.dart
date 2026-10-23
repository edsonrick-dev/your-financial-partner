import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_gradient_card.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/app_snack_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_companies/models/insurance_company_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/binding/insurance_policy_binding.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/add_policy_sheet/sections/benefit_details_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/add_policy_sheet/sections/policy_details/policy_details_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/add_policy_sheet/sections/premium_details_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/select_product/select_product_details_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AddPolicySheet extends GetView<InsurancePolicyController> {
  const AddPolicySheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSheet(
      adaptiveHeight: true,
      height: AppSheetHeight.full,
      title: 'Add Insurance Policy',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: Obx(() {
          final productSelected = controller.selectedProduct.value != null;
          return Column(
            spacing: 20,
            children: [
              AppSection(
                child: AppGradientCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Text(
                          controller.selectedInsurer.value?.name ?? '',
                          style: AppTextStyle.bodyS.copyWith(
                            color: colorScheme.appInversedtext,
                          ),
                        ),
                      ),
                      Text(
                        controller.selectedProduct.value?.name ?? '',
                        style: AppTextStyle.headlineM.copyWith(
                          color: colorScheme.appInversedtext,
                        ),
                      ),
                      SizedBox(height: 16),
                      AppButton(
                        leadingIcon:
                            PhosphorIconsRegular.arrowsCounterClockwise,
                        text: 'Change policy',
                        isInversed: true,
                        onTap: () {
                          InsurancePolicyBinding().dependencies();

                          Get.bottomSheet(
                            SelectProductDetailsSheet(),
                            isScrollControlled: true,
                          );
                        },
                        size: ButtonSize.medium,
                        type: ButtonType.outline,
                      ),
                    ],
                  ),
                ),
              ),

              // ProductDetailsSection(),
              if (productSelected) ...[
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
            ],
          );
        }),
      ),
    );
  }
}
