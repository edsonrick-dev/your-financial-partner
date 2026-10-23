import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/design_system/shifters/segment_shifter/app_segmented_selector.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/add_policy_controller_extension.dart';
// ignore: unused_import
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/add_policy_sheet/add_policy_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/premium_payment_type.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/app_dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:intl/intl.dart';

class PremiumDetailsSection extends GetView<InsurancePolicyController> {
  const PremiumDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => AppSection(
        sectionTitle: 'Premium Details',
        child: Column(
          spacing: 20,
          children: [
            if (controller.selectedProduct.value!.isUserGenerated
                ? controller.selectedPremiumPaymentType.value != 0
                : controller.selectedPaymentTerm.value?.paymentType !=
                      PremiumPaymentType.singlePay)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Premium Payment Schedule', style: AppTextStyle.titleM),
                  SizedBox(height: 8),
                  Obx(
                    () => AppSegmentedSelector(
                      style: AppTextStyle.titleS,
                      items: InsurancePolicyController.paymentSchedule
                          .map((frequency) => frequency.label)
                          .toList(),
                      selectedIndex: InsurancePolicyController.paymentSchedule
                          .indexOf(controller.selectedFrequency.value),
                      onChanged: (index) {
                        controller.selectedFrequency.value =
                            InsurancePolicyController.paymentSchedule[index];
                      },
                    ),
                  ),
                ],
              ),
            Obx(() {
              final product = controller.selectedProduct.value;
              final paymentTerm = controller.selectedPaymentTerm.value;

              final isSinglePay = product?.isUserGenerated == true
                  ? controller.selectedPremiumPaymentType.value == 0
                  : paymentTerm?.paymentType == PremiumPaymentType.singlePay;

              return AppAmountField(
                label: isSinglePay
                    ? 'Single Premium'
                    : '${controller.selectedFrequency.value.label} Premium',
                amount: controller.premiumAmount.value,
                onChanged: (value) => controller.premiumAmount.value = value,
              );
            }),
            if (controller.selectedPremiumPaymentType.value != 0)
              Obx(() {
                final date = controller.nextPaymentDate.value;

                return AppDropdownField(
                  label: 'Next Payment Date',
                  iconKey: 'calendar',
                  value: date == null
                      ? ''
                      : DateFormat('MMMM d, yyyy').format(date),
                  hint: 'Select date',
                  onTap: () {
                    controller.nextPaymentDate.value = DateTime.now();
                    AppDatePicker.show(
                      context: context,
                      initialDate: date ?? DateTime.now(),
                      onChanged: controller.setNextPaymentDate,
                    );
                  },
                );
              }),
          ],
        ),
      ),
    );
  }
}
