import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/split_transaction/track_as_debt_section.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';

class ReceiveMoneyTransactionForm extends GetView<TransactionController> {
  const ReceiveMoneyTransactionForm({super.key});

  @override
  Widget build(BuildContext context) {
    final transactionType = TransactionType.transfer;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
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
                iconKey: 'user',
                value: controller.selectedPerson.value?.name,
                hint: 'Select person',
                onTap: () async {
                  final me = await database.entitiesDao.getCurrentUserEntity();
                  final person = await AppSheets.selection
                      .selectTransactionParticipant(
                        excludedPersonIds: [if (me != null) me.id],
                      );

                  if (person == null) return;

                  controller.selectPerson(person);
                },
              ),
            ),
            Obx(
              () => AppDropdownField(
                label: 'Account',
                iconKey: controller.selectedAccount.value?.icon ?? 'wallet',
                value: controller.selectedAccount.value?.name,
                hint: 'Select account',
                onTap: () => controller.selectAccount(transactionType),
              ),
            ),

            TrackAsDebtSection(transactionType: TransactionType.receive),
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
