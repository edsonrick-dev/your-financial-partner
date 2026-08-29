import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/add_account/add_account_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_page/subpages/assets_list.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_page/subpages/liabilities_list.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';

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
                          ? colorScheme.appOutflowInversed
                          : colorScheme.appInversedtext,
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
                                color: colorScheme.appInflowInverse,
                              ),
                            ),
                            Text(
                              'Assets',
                              style: AppTextStyle.titleM.copyWith(
                                color: colorScheme.appInversedtextMuted,
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
                                color: colorScheme.appOutflowInversed,
                              ),
                            ),
                            Text(
                              'Liabilities',
                              style: AppTextStyle.titleM.copyWith(
                                color: colorScheme.appInversedtextMuted,
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
            onAdd: () async {
              final isAsset = controller.seletectedDetailsTabIndex.value == 0;

              final availableTypes = AccountType.values
                  .where((type) => isAsset ? type.isAsset : type.isLiability)
                  .toList();

              final selectedType = await AppSheets.selection
                  .selectPaymentAccountType(accountTypes: availableTypes);
              if (selectedType == null) return;

              final accountController = Get.find<AccountController>();
              accountController.selectAccountType(selectedType);

              Get.bottomSheet(
                AddAccountSheet(accountType: selectedType),
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
              ).whenComplete(() {
                accountController.resetForm();
              });
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
