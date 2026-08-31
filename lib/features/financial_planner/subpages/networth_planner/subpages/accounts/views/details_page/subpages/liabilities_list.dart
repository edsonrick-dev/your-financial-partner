import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_group/account_group_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_group/account_group_summary.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/add_account/add_account_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LiabilitiesList extends GetView<NetWorthController> {
  const LiabilitiesList({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Obx(() {
      final groups = controller.groupedLiabilityItems;

      if (groups.isEmpty) {
        return Center(
          child: Padding(
            padding: EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  PhosphorIconsFill.piggyBank,
                  size: 48,
                  color: colorScheme.appTextMuted,
                ),
                SizedBox(height: 16),
                Text(
                  'No liabilities yet',
                  style: AppTextStyle.headlineM,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  "Add your first liability so AscendYFP can help you picture how much you own.",
                  style: AppTextStyle.bodyM.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: 16),

                AppButton(
                  text: 'Record your first liabilities',
                  onTap: () async {
                    final isAsset =
                        controller.seletectedDetailsTabIndex.value == 0;

                    final availableTypes = AccountType.values
                        .where(
                          (type) => isAsset ? type.isAsset : type.isLiability,
                        )
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
                SizedBox(height: 8),
                AppButton(
                  type: ButtonType.outline,
                  text: 'Watch how to set up a liability',
                  onTap: () {},
                ),
              ],
            ),
          ),
        );
      }

      return SingleChildScrollView(
        child: Column(
          children: [
            for (final entry in groups.entries)
              AccountGroupSection(
                summary: AccountGroupSummary(
                  group: entry.key,
                  items: entry.value,
                ),
              ),
          ],
        ),
      );
    });
  }
}
