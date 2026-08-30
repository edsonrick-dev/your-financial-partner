import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class SavingsAccountForm extends GetView<AccountController> {
  const SavingsAccountForm({super.key});

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
            onChanged: controller.setAccountName,
          ),
          Obx(
            () => AppDropdownField(
              iconKey: 'bank',
              label: 'Bank / Financial Institution',
              value:
                  controller.selectedInstitution.value?.displayName ??
                  controller.selectedInstitution.value?.name,
              onTap: () async {
                final institution = await AppSheets.selection
                    .selectInstitution();

                if (institution == null) return;

                controller.selectInstitution(institution);
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
