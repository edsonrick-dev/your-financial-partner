import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/save_functions.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/earn_transaction_sheet.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ReceiveMoneyTransactionSheet extends GetView<TransactionController> {
  const ReceiveMoneyTransactionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final transactionType = TransactionType.transfer;
    // final DateTime? selectedDate;
    return FractionallySizedBox(
      heightFactor: AppSheetHeight.full,
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
                      title: 'Receive Money',
                      isDark: true,
                      trailingOnPressed: () {
                        controller.saveReceiveMoneyTransaction();
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
                          label: 'From',
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

                      ApplyToDebtSection(
                        controller: controller,
                        transactionType: TransactionType.receive,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ApplyToDebtSection extends StatelessWidget {
  const ApplyToDebtSection({
    super.key,
    required this.controller,
    required this.transactionType,
  });

  final TransactionController controller;
  final TransactionType transactionType;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Obx(
      () => AnimatedContainer(
        duration: Duration(milliseconds: 180),
        width: double.infinity,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: colorScheme.appInfoSoft,
          borderRadius: BorderRadius.circular(
            controller.isDebt.value == true ? 24 : 12,
          ),
          border: Border.all(color: colorScheme.appInfo),
        ),
        child: Column(
          spacing: 8,
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        spacing: 4,
                        children: [
                          Icon(
                            PhosphorIconsRegular.coins,
                            color: colorScheme.appInfo,
                          ),
                          Text(
                            'Apply to Debt',
                            style: TextStyle(
                              // fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.appInfo,
                            ),
                          ),
                        ],
                      ),

                      Text(
                        'Balance automatically adjust with this person',
                        style: TextStyle(
                          color: colorScheme.appInfo,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                Obx(
                  () => Opacity(
                    opacity: controller.canEnableDebt ? 1 : .4,
                    child: IgnorePointer(
                      ignoring: !controller.canEnableDebt,
                      child: CupertinoSwitch(
                        value: controller.isDebt.value,
                        onChanged: (value) {
                          controller.isDebt.value = value;

                          // if (!value) {
                          //   controller.participants.clear();
                          // }
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Obx(() {
              // debugPrint(
              //   'Widget balance: '
              //   '${controller.selectedPersonBalance.value?.netBalance}',
              // );

              if (controller.isDebt.value == true) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _BalanceSection(
                      controller: controller,
                      label: controller.currentBalanceLabel,
                      sectionTitle: 'Current Balance',
                      amount:
                          (controller.selectedPersonBalance.value?.netBalance ??
                          0),
                    ),
                    Spacer(),
                    Icon(
                      PhosphorIconsRegular.arrowRight,
                      color: colorScheme.appInfo,
                      size: 24,
                    ),
                    Spacer(),
                    _BalanceSection(
                      controller: controller,
                      label: controller.projectedBalanceLabel(transactionType),
                      sectionTitle: 'Balance After',
                      amount: controller.projectedBalance(transactionType),
                    ),
                  ],
                );
              }
              return const SizedBox.shrink();
            }),
            // Obx(() {
            //   final person = controller.selectedPerson.value;

            //   if (person == null) {
            //     return const SizedBox.shrink();
            //   }

            //   return Text(
            //     controller.selectedPersonBalance.value?.netBalance
            //             .toCurrency() ??
            //         '',
            //   );
            // }),
          ],
        ),
      ),
    );
  }
}

class _BalanceSection extends StatelessWidget {
  const _BalanceSection({
    required this.controller,
    required this.sectionTitle,
    required this.label,
    this.amount = 0,
  });
  final String sectionTitle;
  final String label;
  final TransactionController controller;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(12),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        spacing: 8,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            spacing: 4,
            children: [
              Text(
                label,
                style: TextStyle(color: colorScheme.appInfo, fontSize: 12),
              ),
              Text(
                amount.abs().toCurrency(),
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: amount.isNegative
                      ? colorScheme.appOutflow
                      : colorScheme.appInflow,
                ),
              ),
            ],
          ),

          Text(sectionTitle, style: TextStyle(color: colorScheme.appInfo)),
        ],
      ),
    );
  }
}
