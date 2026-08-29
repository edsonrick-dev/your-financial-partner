import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class CheckingAccountForm extends GetView<AccountController> {
  const CheckingAccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSection(
      child: Column(
        spacing: 20,
        children: [
          AppTextField(
            label: 'Name',
            focusNode: controller.nameFocusNode,
            controller: controller.nameController,
          ),

          Obx(
            () => AppDropdownField(
              iconKey: 'bank',
              label: 'Bank / Financial Institution',
              value: controller.selectedInstitution.value?.name,
              onTap: () async {
                // Select financial institution
              },
            ),
          ),

          Obx(
            () => AppAmountField(
              label: 'Initial Balance',
              amount: controller.enteredBalance.value,
              onChanged: (value) {
                controller.enteredBalance.value = value;
              },
            ),
          ),
        ],
      ),
    );
  }
}
