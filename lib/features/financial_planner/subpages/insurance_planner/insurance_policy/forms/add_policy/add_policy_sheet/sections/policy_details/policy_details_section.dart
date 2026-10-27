import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/design_system/shifters/segment_shifter/app_segmented_selector.dart';
import 'package:getx_drift_app/data/tables/payment_terms_table.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/add_policy_controller_extension.dart';
// ignore: unused_import
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/add_policy_sheet/add_policy_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/sheets/payment_details/payment_details_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/premium_payment_type.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/widgets/fields/app_dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:intl/intl.dart';

class PolicyDetailsSection extends GetView<InsurancePolicyController> {
  const PolicyDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSection(
      sectionTitle: 'Policy Details',
      child: Column(
        spacing: 20,
        children: [
          AppTextField(
            label: 'Policy Number',
            focusNode: controller.policyNumberFocusNode,
            controller: controller.policyNumberTextController,
            onChanged: (value) {},
          ),
          Obx(() {
            final today = DateUtils.dateOnly(DateTime.now());
            final date = controller.issueDate.value;

            return AppDropdownField(
              label: 'Issue Date',
              iconKey: 'calendar',
              value: date == null
                  ? ''
                  : DateFormat('MMMM d, yyyy').format(date),
              hint: 'Select date',
              onTap: () {
                AppDatePicker.show(
                  context: context,
                  initialDate: date ?? today,
                  onChanged: controller.setIssueDate,
                  maximumDate: today,
                );
              },
            );
          }),
          if (!controller.selectedProduct.value!.isUserGenerated)
            Obx(
              () => AppDropdownField(
                label: 'Payment Details',
                value: controller.selectedPaymentTerm.value?.label ?? '',
                hint: 'Select payment term',
                showIcon: false,
                onTap: () {
                  Get.bottomSheet(
                    isScrollControlled: true,
                    const SelectPaymentDetailsSheet(),
                  );
                },
              ),
            )
          else ...[
            Column(
              children: [
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Payment details', style: AppTextStyle.titleM),
                      SizedBox(height: 8),
                      AppSegmentedSelector(
                        style: AppTextStyle.titleM,
                        items: PremiumPaymentType.values
                            .map((type) => type.label)
                            .toList(),
                        selectedIndex:
                            controller.selectedPremiumPaymentType.value,
                        onChanged: (index) {
                          controller.selectedPremiumPaymentType.value = index;
                          controller.premiumPaymentController.clear();
                          controller.premiumPaymentFocusNode.unfocus();
                        },
                      ),
                    ],
                  ),
                ),
                Obx(() {
                  if (controller.selectedPremiumPaymentType.value == 0) {
                    return SizedBox.shrink();
                  }
                  return Column(
                    children: [
                      SizedBox(height: 20),
                      AppTextField(
                        label: controller.selectedPremiumPaymentType.value == 1
                            ? 'Years to Pay'
                            : 'End of Payment Age',
                        hintText: 'Enter value',
                        keyboardType: TextInputType.numberWithOptions(),
                        focusNode: controller.premiumPaymentFocusNode,
                        controller: controller.premiumPaymentController,
                      ),
                    ],
                  );
                }),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
