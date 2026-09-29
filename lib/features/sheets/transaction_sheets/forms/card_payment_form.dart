import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_group_enum.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/transactions/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/app_dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class CardPaymentForm extends GetView<TransactionController> {
  const CardPaymentForm({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionType = TransactionType.cardPayment;
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: AppSection(
        child: Column(
          spacing: 16,
          children: [
            Obx(
              () => AppDropdownField(
                label: 'Date',

                iconKey: 'calendar',

                value: controller.formattedDate,

                hint: 'Select date',

                onTap: () {
                  AppDatePicker.show(
                    context: context,

                    initialDate: controller.selectedDate.value,

                    onChanged: controller.setDate,
                  );
                },
              ),
            ),
            Obx(
              () => AppDropdownField(
                label: 'From',
                showIcon: controller.selectedAccount.value?.icon != null,
                iconKey: controller.selectedAccount.value?.icon ?? 'account',
                value: controller.selectedAccount.value?.name,
                hint: 'Select account',
                onTap: () => controller.selectAccount(transactionType),
              ),
            ),

            Obx(
              () => AppDropdownField(
                label: 'Card to pay',
                showIcon: controller.selectedLinkedAccount.value?.icon != null,
                iconKey:
                    controller.selectedLinkedAccount.value?.icon ?? 'account',
                value: controller.selectedLinkedAccount.value?.name,
                hint: 'Select credit card',
                onTap: () => controller.selectLinkedAccount(
                  transactionType,
                  accountGroup: AccountGroup.creditCards,
                ),
              ),
            ),
            AppTextField(
              optional: true,
              label: 'Notes',
              controller: controller.noteController,
              focusNode: controller.noteFocusNode,
              multiLine: true,
            ),
          ],
        ),
      ),
    );
  }
}
