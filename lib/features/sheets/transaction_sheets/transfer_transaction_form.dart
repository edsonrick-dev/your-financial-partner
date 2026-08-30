import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class TransferTransactionForm extends GetView<TransactionController> {
  const TransferTransactionForm({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionType = TransactionType.transfer;
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
                iconKey: controller.selectedAccount.value?.icon ?? 'account',
                value: controller.selectedAccount.value?.name,
                hint: 'Select account',
                onTap: () => controller.selectAccount(transactionType),
              ),
            ),
            Obx(
              () => AppDropdownField(
                label: 'To',
                iconKey:
                    controller.selectedLinkedAccount.value?.icon ?? 'account',
                value: controller.selectedLinkedAccount.value?.name,
                hint: 'Select account',
                onTap: () => controller.selectLinkedAccount(transactionType),
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
