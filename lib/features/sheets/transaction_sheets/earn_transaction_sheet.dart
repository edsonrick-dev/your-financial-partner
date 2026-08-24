import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/domain/app_calculator.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/transaction_amount_holder.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/save_functions.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';

class EarnTransactionSheet extends GetView<TransactionController> {
  const EarnTransactionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final transactionType = TransactionType.earn;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: FractionallySizedBox(
        heightFactor: AppSheetHeight.full,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(38),
              bottom: Radius.circular(38),
            ),
            color: colorScheme.surface,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            // mainAxisSize: MainAxisSize.min,
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
                      title: 'Earn',
                      isDark: true,
                      trailingOnPressed: () {
                        controller.saveEarnTransaction();
                      },
                      leadingOnPressed: () {
                        Get.back();
                      },
                      // trailingIcon: Icons.check,
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
                            FocusManager.instance.primaryFocus?.unfocus();
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
                          hint: 'Select account',
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            controller.selectCategory(transactionType);
                          },
                        ),
                      ),
                      Obx(
                        () => AppDropdownField(
                          label: 'Account',
                          iconKey:
                              controller.selectedAccount.value?.icon ??
                              'account',
                          value: controller.selectedAccount.value?.name,
                          hint: 'Select account',
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            controller.selectAccount(transactionType);
                          },
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
