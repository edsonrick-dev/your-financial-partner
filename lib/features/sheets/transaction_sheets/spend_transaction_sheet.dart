import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/transaction_amount_holder.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/save_functions.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/transaction_validation_extension.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/split_transaction/split_expense_section.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum PaidBy { self, others }

class SpendTransactionSheet extends GetView<TransactionController> {
  const SpendTransactionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final transactionType = TransactionType.spend;
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
            color: colorScheme.surface,
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
                      title: 'Spend',
                      isDark: true,
                      // trailingOnPressed: () {
                      //   controller.saveSpendTransaction();
                      // },
                      // //trailingOnPressed:
                      // // controller.canSaveTransaction
                      // //     ? controller.saveSpendTransaction
                      // //     : null,
                      // leadingOnPressed: () {
                      //   controller.participants.clear();
                      //   Get.back();
                      // },
                    ),
                    TransactionAmountHolder(),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
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
                          label: 'Category',
                          iconKey:
                              controller.selectedCategory.value?.icon ??
                              'category',
                          value: controller.selectedCategory.value?.name,
                          hint: 'Select category',
                          onTap: () =>
                              controller.selectCategory(transactionType),
                        ),
                      ),
                      AppSection(
                        child: Row(
                          children: [
                            Text('Amount paid by:', style: AppTextStyle.titleM),
                            Spacer(),

                            Obx(
                              () => Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: colorScheme.bgLight,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: colorScheme.appBorderMuted,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    ModeButton(
                                      item: const ModeItem(
                                        selectedIcon: PhosphorIconsFill.user,
                                        unselectedIcon:
                                            PhosphorIconsRegular.user,
                                        title: 'Me',
                                      ),
                                      selected:
                                          controller.paidBy.value ==
                                          PaidBy.self,
                                      onTap: () {
                                        controller.setPaidBy(PaidBy.self);
                                      },
                                    ),
                                    ModeButton(
                                      item: const ModeItem(
                                        selectedIcon: PhosphorIconsFill.users,
                                        unselectedIcon:
                                            PhosphorIconsRegular.users,
                                        title: 'Others',
                                      ),
                                      selected:
                                          controller.paidBy.value ==
                                          PaidBy.others,
                                      onTap: () {
                                        controller.setPaidBy(PaidBy.others);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            // SizedBox(width: 16),
                          ],
                        ),
                      ),
                      // Obx(
                      //   () => AppDropdownField(
                      //     label: 'Account',
                      //     iconKey:
                      //         controller.selectedAccount.value?.icon ??
                      //         'account',
                      //     value: controller.selectedAccount.value?.name,
                      //     hint: 'Select account',
                      //     onTap: () =>
                      //         controller.selectAccount(transactionType),
                      //   ),
                      // ),
                      Obx(() {
                        final isPaidBySelf =
                            controller.paidBy.value == PaidBy.self;

                        if (isPaidBySelf) {
                          return AppDropdownField(
                            label: 'Personal Account',
                            iconKey:
                                controller.selectedAccount.value?.icon ??
                                'account',
                            value: controller.selectedAccount.value?.name,
                            hint: 'Select account',
                            onTap: () {
                              controller.selectAccount(transactionType);
                            },
                          );
                        }

                        return AppDropdownField(
                          label: 'Person',
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
                        );
                      }),
                      const SplitExpenseSection(),
                      AppTextField(
                        optional: true,
                        label: 'Notes',
                        controller: controller.noteController,
                        focusNode: controller.noteFocusNode,
                        multiLine: true,
                      ),
                      Obx(
                        () => AppButton(
                          text: 'Save Spend Transaction',
                          onTap: controller.isSpendTransactionValid
                              ? controller.saveSpendTransaction
                              : null,
                        ),
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

class ModeButton extends StatelessWidget {
  const ModeButton({
    super.key,
    required this.item,
    required this.selected,
    required this.onTap,
  });

  final ModeItem item;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      borderRadius: BorderRadius.circular(9),
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: selected ? colorScheme.appText : Colors.transparent,
          borderRadius: BorderRadius.circular(9),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            spacing: 6,
            children: [
              Icon(
                selected ? item.selectedIcon : item.unselectedIcon,
                size: 18,
                color: selected ? colorScheme.bg : colorScheme.appTextMuted,
              ),

              AnimatedSize(
                duration: const Duration(milliseconds: 180),
                curve: Curves.easeOut,
                child: item.title != null
                    ? Text(
                        item.title!,
                        style: AppTextStyle.labelM.copyWith(
                          color: selected
                              ? colorScheme.bg
                              : colorScheme.appText,
                        ),
                      )
                    : const SizedBox.shrink(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ModeItem {
  const ModeItem({
    required this.selectedIcon,
    required this.unselectedIcon,
    this.title,
  });

  final IconData selectedIcon;
  final IconData unselectedIcon;
  final String? title;
}
