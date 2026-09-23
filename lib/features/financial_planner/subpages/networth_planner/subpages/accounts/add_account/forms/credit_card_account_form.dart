import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/app_dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class CreditCardAccountForm extends GetView<AccountController> {
  const CreditCardAccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        AppSection(
          child: Column(
            children: [
              AppTextField(
                label: 'Name',
                focusNode: controller.nameFocusNode,
                controller: controller.nameController,
                onChanged: controller.setAccountName,
              ),
            ],
          ),
        ),
        AppSection(
          sectionTitle: 'Financial Details',
          child: Column(
            spacing: 20,
            children: [
              Obx(
                () => AppAmountField(
                  label: 'Starting Balance',
                  amount: controller.enteredBalance.value,
                  onChanged: (value) {
                    controller.enteredBalance.value = value;
                  },
                ),
              ),

              Obx(
                () => AppAmountField(
                  label: 'Credit Limit',
                  amount: controller.enteredCreditLimit.value,
                  onChanged: (value) {
                    controller.enteredCreditLimit.value = value;
                  },
                ),
              ),
            ],
          ),
        ),
        AppSection(
          sectionTitle: 'Billing Details',
          child: Column(
            spacing: 20,
            children: [
              Obx(
                () => AppDropdownField(
                  label: 'Next Statement Date',
                  iconKey: 'calendar',
                  value: controller.formattedStatementDate,
                  hint: 'Select date',
                  onTap: () {
                    AppDatePicker.show(
                      context: context,
                      initialDate: controller.selectedStatementDate.value,
                      onChanged: controller.setStatementDate,
                    );
                  },
                ),
              ),
              Obx(
                () => AppDropdownField(
                  label: 'Next Payment Due Date',
                  iconKey: 'calendar',
                  value: controller.formattedPaymentDueDate,
                  hint: 'Select date',
                  onTap: () {
                    AppDatePicker.show(
                      context: context,
                      initialDate: controller.selectedPaymentDueDate.value,
                      onChanged: controller.setPaymentDueDate,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
