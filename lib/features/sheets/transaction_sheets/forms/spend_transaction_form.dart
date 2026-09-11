import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/transaction_validation_extension.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/split_transaction/split_expense_section.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/organize_THIS/app_mode_item.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

enum PaidBy { self, others }

class SpendTransactionForm extends GetView<TransactionController> {
  const SpendTransactionForm({super.key, required this.transactionType});

  final TransactionType transactionType;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: AppSection(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                label: controller.selectedBill.value != null
                    ? 'Bill'
                    : 'Category',
                iconKey:
                    controller.selectedBill.value?.category?.icon ??
                    controller.selectedCategory.value?.icon ??
                    'category',
                value:
                    controller.selectedBill.value?.bill.name ??
                    controller.selectedCategory.value?.name,
                hint: 'Select category or bill',
                onTap: () async {
                  FocusManager.instance.primaryFocus?.unfocus();

                  await controller.selectCategoryOrBill(transactionType);
                  debugPrint(
                    '>>> EFFECTIVE TYPE: ${controller.effectiveTransactionType.name}',
                  );
                  debugPrint(
                    '>>> SELECTED BILL: ${controller.selectedBill.value?.bill.name}',
                  );
                  debugPrint(
                    '>>> IS LOAN: ${controller.selectedBill.value?.isLoanPayment}',
                  );
                  debugPrint(
                    '>>> LINKED ACCOUNT: ${controller.selectedLinkedAccount.value?.id}',
                  );
                  debugPrint(
                    '>>> IS TRANSACTION VALIE: ${controller.effectiveTransactionType.name == 'spend' ? controller.isSpendTransactionValid : controller.isDebtRepaymentTransactionValid}',
                  );
                },
                // onTap: () async {
                //   FocusManager.instance.primaryFocus?.unfocus();

                //   final selectedTransactionType =
                //       await controller.selectCategoryOrBill(transactionType);

                //   if (selectedTransactionType == null) return;

                //   transactionType = selectedTransactionType;
                // },
              ),
            ),
            // Obx(
            //   () => AppDropdownField(
            //     label: 'Category',
            //     iconKey: controller.selectedCategory.value?.icon ?? 'category',
            //     value: controller.selectedCategory.value?.name,
            //     hint: 'Select category',
            //     onTap: () => controller.selectCategory(transactionType),
            //   ),
            // ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text('Amount paid by:', style: AppTextStyle.titleM),
                ),

                const SizedBox(height: 16),

                Obx(
                  () => Container(
                    // height: 44,
                    // width: double.infinity,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: colorScheme.bgLight,
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: colorScheme.appBorderMuted),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AmountPaidByShifter(
                          isFullWidth: false,
                          item: const ModeItem(
                            selectedIcon: PhosphorIconsFill.user,
                            unselectedIcon: PhosphorIconsRegular.user,
                            title: 'Me',
                          ),
                          selected: controller.paidBy.value == PaidBy.self,
                          onTap: () {
                            controller.setPaidBy(PaidBy.self);
                          },
                        ),
                        AmountPaidByShifter(
                          isFullWidth: false,
                          item: const ModeItem(
                            selectedIcon: PhosphorIconsFill.users,
                            unselectedIcon: PhosphorIconsRegular.users,
                            title: 'Others',
                          ),
                          selected: controller.paidBy.value == PaidBy.others,
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
            Obx(() {
              final isPaidBySelf = controller.paidBy.value == PaidBy.self;
              if (isPaidBySelf) {
                return Column(
                  spacing: 16,
                  children: [
                    AppDropdownField(
                      label: 'Personal Account',
                      iconKey:
                          controller.selectedAccount.value?.icon ?? 'account',
                      value: controller.selectedAccount.value?.name,
                      hint: 'Select account',
                      onTap: () {
                        controller.selectAccount(
                          controller.effectiveTransactionType,
                        );
                      },
                    ),
                    SplitExpenseSection(
                      key: controller.splitExpenseKey,
                      onExpand: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          controller.ensureVisible(controller.splitExpenseKey);
                        });
                      },
                    ),
                  ],
                );
              }

              return AppDropdownField(
                label: 'Payor',
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
              );
            }),

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

class AmountPaidByShifter extends StatelessWidget {
  const AmountPaidByShifter({
    super.key,
    required this.item,
    required this.selected,
    required this.onTap,
    this.isFullWidth = true,
  });

  final ModeItem item;
  final bool selected;
  final VoidCallback onTap;
  final bool isFullWidth;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      borderRadius: BorderRadius.circular(999),
      onTap: onTap,
      child: AnimatedContainer(
        // height: 44,
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.pageShifterFillSelected
              : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              spacing: 6,
              children: [
                Icon(
                  selected ? item.selectedIcon : item.unselectedIcon,
                  size: 24,
                  color: selected ? colorScheme.bg : colorScheme.appTextMuted,
                ),

                if (isFullWidth)
                  Expanded(
                    child: item.title != null
                        ? Align(
                            alignment: Alignment.centerLeft,
                            child: FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                item.title!,
                                style: AppTextStyle.titleS.copyWith(
                                  color: selected
                                      ? colorScheme.bg
                                      : colorScheme.appText,
                                ),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  )
                else if (item.title != null)
                  Text(
                    item.title!,
                    style: AppTextStyle.titleS.copyWith(
                      color: selected ? colorScheme.bg : colorScheme.appText,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
