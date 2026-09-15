import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_types/account_type_action_menu.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_page/subpages/assets_list.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_page/subpages/liabilities_list.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/shared/anchored_action_menu.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';

class NetWorthDetailsPage extends GetView<NetWorthController> {
  const NetWorthDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final LayerLink addButtonLink = LayerLink();

    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Obx(
                () => AppDetailsHeader(
                  title: 'Net Worth',
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            controller.netWorth.abs().toCurrency(),
                            style: AppTextStyle.amountXL.copyWith(
                              color: controller.netWorth < 0
                                  ? colorScheme.appOutflowInversed
                                  : colorScheme.appInversedtext,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        controller.totalAssets.toCurrency(),
                                        style: AppTextStyle.amountL.copyWith(
                                          color: colorScheme.appInflowInverse,
                                        ),
                                      ),
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
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 24,
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        controller.totalLiabilities
                                            .toCurrency(),
                                        style: AppTextStyle.amountL.copyWith(
                                          color: colorScheme.appOutflowInversed,
                                        ),
                                      ),
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
                      ),
                    ],
                  ),
                ),
              ),
              AppDetailsPageActionSection(
                selectedIndex: controller.seletectedDetailsTabIndex,
                actions: const ['Assets', 'Liabilities'],
                addButtonLink: addButtonLink,
                onAdd: controller.toggleNetWorthTypesMenu,
                isAddMenuOpen: controller.isNetWorthTypesMenuOpen,
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
          Obx(() {
            if (!controller.isNetWorthTypesMenuOpen.value) {
              return const SizedBox.shrink();
            }

            final isAsset = controller.seletectedDetailsTabIndex.value == 0;

            final accountTypes = AccountType.values
                .where((type) => isAsset ? type.isAsset : type.isLiability)
                .toList();

            return AnchoredActionMenu(
              isOpen: true,
              link: addButtonLink,
              onDismiss: controller.closeNetWorthTypesMenu,
              child: AccountTypeActionMenu(
                accountTypes: accountTypes,
                onSelected: (accountType) {
                  controller.closeNetWorthTypesMenu();
                  // controller.addAccount();
                  Get.find<AccountController>().openAddAccount(accountType);
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
