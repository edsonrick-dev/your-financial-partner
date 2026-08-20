import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/icon_picker_field.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/add_button_state.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';

class AddPaymentAccountButton extends GetView<AccountController> {
  final TransactionType transactionType;
  final VoidCallback? onExpand;
  const AddPaymentAccountButton({
    super.key,
    required this.transactionType,
    this.onExpand,
  });
  List<AccountType> get availableAccountTypes {
    switch (transactionType) {
      case TransactionType.earn:
        return AccountType.values.where((account) => account.isAsset).toList();

      case TransactionType.spend:
        return AccountType.values;

      case TransactionType.transfer:
      case TransactionType.give:
      case TransactionType.receive:
        return AccountType.values
            .where((account) => account.group == AccountGroup.cashAndBank)
            .toList();

      case TransactionType.balanceUpdate:
        return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Obx(() {
      final state = controller.buttonState.value;

      final isExpanded = state != AddButtonState.collapsed;

      return AnimatedContainer(
        duration: Duration(milliseconds: 180),

        padding: isExpanded
            ? const EdgeInsets.all(12)
            : const EdgeInsets.all(0),
        decoration: BoxDecoration(
          // color: isExpanded ? colorScheme.secondaryBg : Colors.transparent,
          borderRadius: BorderRadius.circular(isExpanded ? 20 : 12),
          border: Border.all(color: colorScheme.appBorder),
        ),

        child: isExpanded
            ? _BuildExpanded(
                controller: controller,
                availableAccountTypes: availableAccountTypes,
              )
            : _BuildCollapsed(controller: controller, onExpand: onExpand),
      );
    });
  }
}

class _BuildExpanded extends StatelessWidget {
  const _BuildExpanded({
    required this.controller,
    required this.availableAccountTypes,
  });

  final AccountController controller;
  final List<AccountType> availableAccountTypes;

  @override
  Widget build(BuildContext context) {
    final state = controller.buttonState.value;
    return Column(
      spacing: 12,
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() {
          final type = controller.selectedAccountType.value;

          return Column(
            spacing: 12,
            children: [
              AppDropdownField(
                iconKey: type?.iconKey,
                label: 'Account Type',
                value: type?.label,
                hint: 'Select account type',
                onTap: () async {
                  final selected = await AppSheets.selection
                      .selectPaymentAccountType(
                        accountTypes: availableAccountTypes,
                      );

                  if (selected == null) return;

                  controller.selectAccountType(selected);
                },
              ),

              Row(
                children: [
                  AppIconPickerField(
                    iconKey: controller.selectedIconKey.value,
                    onTap: () {},
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: AppTextField(
                      label: 'Name',
                      focusNode: controller.nameFocusNode,
                      controller: controller.nameController,
                    ),
                  ),
                  // Expanded(
                  //   child: Container(
                  //     color: Colors.red,
                  //     child: AppTextField(
                  //       label: 'Name',
                  //       focusNode: controller.nameFocusNode,
                  //       controller: controller.nameController,
                  //     ),
                  //   ),
                  // ),
                ],
              ),

              if (type == AccountType.creditCard)
                AppTextField(
                  label: 'Credit Limit',
                  controller: controller.creditLimitController,
                  focusNode: controller.creditLimitFocusNode,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
            ],
          );
        }),

        Row(
          spacing: 8,
          children: [
            ///CANCEL BUTTON
            AdaptivePressable(
              child: GestureDetector(
                onTap: controller.collapseButton,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    // color: colorScheme.text,
                    border: Border.all(color: context.colors.appText),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  height: 44,
                  child: Row(
                    spacing: 8,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text('Cancel', style: TextStyle())],
                  ),
                ),
              ),
            ),

            ///SAVE BUTTON
            Expanded(
              child: AdaptivePressable(
                child: GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    final createdCategory = await controller.saveAccount();

                    if (createdCategory != null) {
                      Get.back(result: createdCategory);
                    }
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24),
                    decoration: BoxDecoration(
                      color: context.colors.appText,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: 44,
                    child: Row(
                      spacing: 8,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        state == AddButtonState.loading
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: context.colors.surface,
                                ),
                              )
                            : Text(
                                'Save Account',
                                style: TextStyle(color: context.colors.surface),
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _BuildCollapsed extends StatelessWidget {
  final AccountController controller;
  final VoidCallback? onExpand;

  const _BuildCollapsed({required this.controller, this.onExpand});

  @override
  Widget build(BuildContext context) {
    return AdaptivePressable(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          controller.expandButton();

          WidgetsBinding.instance.addPostFrameCallback((_) {
            onExpand?.call();
          });
        },
        child: SizedBox(
          height: 52,
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(Icons.add),
              SizedBox(width: 8),
              Text('Add New Payment Account'),
            ],
          ),
        ),
      ),
    );
  }
}
