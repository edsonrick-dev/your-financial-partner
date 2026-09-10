import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/icon_picker_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class LoanAccountForm extends GetView<AccountController> {
  const LoanAccountForm({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSection(
      child: Column(
        spacing: 20,
        children: [
          Row(
            children: [
              // Obx(
              //   () => AppIconPickerField(
              //     iconKey: controller.selectedIconKey.value,
              //     onTap: () {},
              //   ),
              // ),
              // const SizedBox(width: 8),
              Expanded(
                child: AppTextField(
                  label: 'Name',
                  focusNode: controller.nameFocusNode,
                  controller: controller.nameController,
                  onChanged: controller.setAccountName,
                ),
              ),
            ],
          ),

          Obx(
            () => AppAmountField(
              label: 'Current Balance',
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
