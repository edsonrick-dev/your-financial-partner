import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_page/subpages/assets_list.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_page/subpages/liabilities_list.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_page_action_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/core/num_extension.dart';

class NetWorthDetailsPage extends GetView<NetWorthController> {
  const NetWorthDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Scaffold(
      body: Column(
        children: [
          Obx(
            () => AppDetailsHeader(
              title: 'Net Worth',
              child: Column(
                children: [
                  Text(
                    controller.netWorth.abs().toCurrency(),
                    style: AppTextStyle.amountXL.copyWith(
                      color: controller.netWorth <= 0
                          ? colorScheme.appOutflow
                          : colorScheme.appInflow,
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              controller.totalAssets.toCurrency(),
                              style: AppTextStyle.amountL.copyWith(
                                color: colorScheme.appInflow,
                              ),
                            ),
                            Text(
                              'Assets',
                              style: AppTextStyle.titleM.copyWith(
                                color: colorScheme.inversePrimary.withAlpha(
                                  150,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            Text(
                              controller.totalLiabilities.toCurrency(),
                              style: AppTextStyle.amountL.copyWith(
                                color: colorScheme.appOutflow,
                              ),
                            ),
                            Text(
                              'Liabilities',
                              style: AppTextStyle.titleM.copyWith(
                                color: colorScheme.inversePrimary.withAlpha(
                                  150,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          AppDetailsPageActionSection(
            selectedIndex: controller.seletectedDetailsTabIndex,
            actions: const ['Assets', 'Liabilities'],
            onAdd: () {
              Get.bottomSheet(AddAccountSheet());
            },
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.seletectedDetailsTabIndex.value,
                children: const [AssetsList(), LiabilitiesList()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AddAccountSheet extends GetView<NetWorthController> {
  const AddAccountSheet({super.key});

  BalanceSheetType get balanceSheetType {
    return controller.seletectedDetailsTabIndex.value == 0
        ? BalanceSheetType.asset
        : BalanceSheetType.liability;
  }

  List<AccountType> get availableAccountTypes {
    switch (balanceSheetType) {
      case BalanceSheetType.asset:
        return AccountType.values.where((account) => account.isAsset).toList();

      case BalanceSheetType.liability:
        return AccountType.values
            .where((account) => account.isLiability)
            .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    final accountController = Get.find<AccountController>();
    final colorScheme = context.colors;
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AppSheet(
        adaptiveHeight: true,
        title: 'Add new ${balanceSheetType.name}',
        child: AppSection(
          child: Column(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    Obx(() {
                      final type = accountController.selectedAccountType.value;

                      return Column(
                        spacing: 20,
                        children: [
                          AppDropdownField(
                            label: 'Type',
                            value: type?.label,
                            onTap: () async {
                              final selected = await AppSheets.selection
                                  .selectPaymentAccountType(
                                    accountTypes: availableAccountTypes,
                                  );

                              if (selected != null) {
                                accountController.selectAccountType(selected);
                              }
                            },
                          ),
                          AppTextField(
                            label: 'Name',
                            focusNode: accountController.nameFocusNode,
                            controller: accountController.nameController,
                          ),
                          AppTextField(
                            label: 'Initial Balance',
                            prefixText: '₱',
                            keyboardType: TextInputType.numberWithOptions(),
                            focusNode: accountController.balanceFocusNode,
                            controller: accountController.balanceController,
                          ),
                          if (type == AccountType.creditCard)
                            AppTextField(
                              label: 'Credit Limit',
                              controller:
                                  accountController.creditLimitController,
                              focusNode: accountController.creditLimitFocusNode,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                            ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
              SizedBox(height: 24),
              AdaptivePressable(
                onTap: () async {
                  final createdAccount = await accountController.saveAccount(
                    initialBalance: accountController.initialBalance,
                  );

                  if (createdAccount == null) return;

                  Get.back();
                },
                child: Container(
                  height: 44,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorScheme.appAccent,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Center(child: Text('Save Account')),
                  // your button UI
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
