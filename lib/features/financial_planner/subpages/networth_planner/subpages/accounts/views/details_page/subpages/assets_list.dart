import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sheets/create_cashflow_plan/create_income_plan_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_group/account_group_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_group/account_group_summary.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AssetsList extends GetView<NetWorthController> {
  const AssetsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final groups = controller.groupedAssetItems;
      final colorScheme = context.colors;
      if (groups.isEmpty) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  PhosphorIconsFill.piggyBank,
                  size: 48,
                  color: colorScheme.appTextMuted,
                ),
                const SizedBox(height: 16),
                Text(
                  'No asset accounts yet',
                  style: AppTextStyle.headlineM,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),
                Text(
                  "Add your first asset account so Ascend can help you picture how much you own.",
                  style: AppTextStyle.bodyM.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 16),

                AppButton(
                  text: 'Record your first asset account',
                  onTap: () {
                    // Get.bottomSheet(
                    //   const CreateIncomePlanSheet(),
                    //   backgroundColor: Colors.transparent,
                    //   isScrollControlled: true,
                    // ).whenComplete(() {
                    //   controller.resetIncomePlan();
                    // });
                  },
                ),
                const SizedBox(height: 8),
                AppButton(
                  type: ButtonType.outline,
                  text: 'Watch how to set up an asset account',
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
