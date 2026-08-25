import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/domain/app_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/app_date_picker.dart';
import 'package:getx_drift_app/features/sheets/transaction_sheets/transaction_amount_holder.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/save_functions.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/transaction_validation_extension.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_grabber.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_toolbar.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';

class EarnTransactionSheet extends GetView<TransactionController> {
  const EarnTransactionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final transactionType = TransactionType.earn;
    final spacing = 16.0;
    return AppSheet(
      adaptiveHeight: false,
      showHeader: false,
      height: AppSheetHeight.full,
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).unfocus();
        },
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
                  Obx(
                    () => AppToolbar(
                      title: 'Earn',
                      isDark: true,
                      showLeading: false,
                      trailingForegroundColor: colorScheme.appInversedtext,
                      trailingBackgroundColor: colorScheme.appInflowInverse,
                      trailingOnPressed: controller.isEarnTransactionValid
                          ? controller.saveEarnTransaction
                          : null,
                      leadingOnPressed: () {
                        Get.back();
                      },
                    ),
                  ),

                  TransactionAmountHolder(),
                ],
              ),
            ),
            SingleChildScrollView(
              child: AppSection(
                child: Column(
                  children: [
                    SizedBox(height: spacing),
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
                    SizedBox(height: spacing),
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
                    SizedBox(height: spacing),
                    Obx(
                      () => AppDropdownField(
                        label: 'Account',
                        iconKey:
                            controller.selectedAccount.value?.icon ?? 'account',
                        value: controller.selectedAccount.value?.name,
                        hint: 'Select account',
                        onTap: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          controller.selectAccount(transactionType);
                        },
                      ),
                    ),
                    SizedBox(height: spacing),
                    AppTextField(
                      optional: true,
                      label: 'Notes',
                      controller: controller.noteController,
                      focusNode: controller.noteFocusNode,
                      multiLine: true,
                    ),
                    SizedBox(height: 24),
                    Obx(
                      () => AppButton(
                        text: 'Save Earn Transaction',
                        onTap: controller.isEarnTransactionValid
                            ? controller.saveEarnTransaction
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
    );
  }
}
