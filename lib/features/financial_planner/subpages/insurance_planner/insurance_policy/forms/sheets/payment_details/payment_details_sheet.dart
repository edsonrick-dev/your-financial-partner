import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/data/tables/payment_terms_table.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/add_policy_sheet/sections/payment_details/payment_details_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/controller/insurance_policy_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class SelectPaymentDetailsSheet extends GetView<InsurancePolicyController> {
  const SelectPaymentDetailsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      adaptiveHeight: true,
      title: 'Select Payment Details',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: AppSection(
          child: Obx(() {
            final terms = controller.availablePaymentTerms;

            if (controller.isLoadingPaymentTerms.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (terms.isEmpty) {
              return const Text('No payment terms available for this product.');
            }

            return Column(
              spacing: 12,
              children: terms.map((term) {
                final isSelected = controller.selectedPaymentTerm.value == term;
                return PaymentDetailsCard(
                  name: term.label,
                  description: term.description,
                  isSelected: isSelected,
                  onTap: () {
                    controller.selectPaymentTerm(term);
                    Get.back();
                  },
                );
              }).toList(),
            );
          }),
        ),
      ),
    );
  }
}
