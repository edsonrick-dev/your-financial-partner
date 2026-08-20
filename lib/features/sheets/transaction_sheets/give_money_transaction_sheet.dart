import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/split_transaction/track_as_debt_section.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/save_functions.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/earn_transaction_sheet.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';

class GiveMoneyTransactionSheet extends GetView<TransactionController> {
  const GiveMoneyTransactionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final transactionType = TransactionType.transfer;
    // final DateTime? selectedDate;
    return FractionallySizedBox(
      heightFactor: 0.92,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(top: Radius.circular(38)),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ///Header
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(38),
                    bottom: Radius.circular(20),
                  ),
                  color: colorScheme.appOnSurfaceSecondary,
                ),
                child: Column(
                  children: [
                    ///Grabber
                    AppGrabber(isDark: true),

                    ///Toolbar
                    AppToolbar(
                      title: 'Give Money',
                      isDark: true,
                      trailingOnPressed: () {
                        controller.saveGiveMoneyTransaction();
                      },
                      leadingOnPressed: () {
                        Get.back();
                      },
                    ),

                    TransactionAmountHolder(),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16,
                  ),
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
                          label: 'To',
                          iconKey: 'user',
                          value: controller.selectedPerson.value?.name,
                          hint: 'Select person',
                          onTap: () async {
                            final me = await database.entitiesDao
                                .getCurrentUserEntity();
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
                          iconKey:
                              controller.selectedAccount.value?.icon ??
                              'wallet',
                          value: controller.selectedAccount.value?.name,
                          hint: 'Select account',
                          onTap: () =>
                              controller.selectAccount(transactionType),
                        ),
                      ),
                      TrackAsDebtSection(transactionType: TransactionType.give),
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
