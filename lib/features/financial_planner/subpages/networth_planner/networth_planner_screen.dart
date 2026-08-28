import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/metric_bar_row.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/sections/networth_summary_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/widgets/account_group_overview_tile.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/widgets/account_overview.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';
import 'package:getx_drift_app/features/widgets/app_tab_switcher.dart';
import 'package:getx_drift_app/features/widgets/cards/others_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NetworthPlannerScreen extends GetView<NetWorthController> {
  const NetworthPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          Obx(
            () => NetWorthSummaryContainerSection(
              netWorth: controller.netWorth,
              baselineNetWorth: controller.baselineNetWorth.value,
              comparisonType: controller.netWorthComparison.value,
              onComparisonChanged: controller.setNetWorthComparison,
            ),
          ),

          SizedBox(height: 24),
          AppSection(
            sectionTitle: 'Wealth Overview',
            trailingType: SectionTrailingType.textButton,
            trailingText: 'View Accounts',
            onTrailingPressed: () {
              Get.toNamed(Routes.NETWORTHDETAILS);
            },
            child: Column(
              spacing: 20,
              children: [
                AppSectionBody(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Obx(
                      () => Column(
                        spacing: 8,
                        children: [
                          MetricBarRow(
                            label: 'Assets',
                            amount: controller.totalAssets,
                            ratio: controller.assetRatio,
                            color: colorScheme.appInflow,
                          ),

                          MetricBarRow(
                            label: 'Liabilities',
                            amount: controller.totalLiabilities,
                            ratio: controller.liabilityRatio,
                            color: colorScheme.appOutflow,
                          ),

                          MetricBarRow(
                            label: 'Net Worth',
                            amount: controller.netWorth,
                            ratio: controller.netWorthRatio,
                            color: colorScheme.appInfo,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AppSectionBody(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      spacing: 16,
                      children: [
                        Obx(
                          () => Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: colorScheme.bg,
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(color: colorScheme.appBorder),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TabSwitcher(
                                      label: 'Assets',
                                      isActive:
                                          controller.selectedView.value ==
                                          BalanceSheetType.asset,
                                      onTap: () {
                                        controller.selectBalanceSheetType(
                                          BalanceSheetType.asset,
                                        );
                                      },
                                    ),
                                  ),
                                  Expanded(
                                    child: TabSwitcher(
                                      label: 'Liabilities',
                                      isActive:
                                          controller.selectedView.value ==
                                          BalanceSheetType.liability,
                                      onTap: () {
                                        controller.selectBalanceSheetType(
                                          BalanceSheetType.liability,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => Column(
                            spacing: 12,
                            children: controller.displayedGroupTotals.entries
                                .map((entry) {
                                  final group = entry.key;
                                  final amount = entry.value;

                                  return AccountOverview(
                                    icon: group.icon,
                                    type: group.label,
                                    amount: amount,
                                    percentage: controller.groupPercentage(
                                      group,
                                    ),
                                    color: group.color,
                                    percentageLabel:
                                        controller.selectedView.value ==
                                            BalanceSheetType.asset
                                        ? 'Assets'
                                        : 'Liabilities',
                                  );
                                })
                                .toList(),
                          ),
                        ),
                        Obx(
                          () => Column(
                            spacing: 12,
                            children: controller.displayedGroupTotals.entries
                                .map((entry) {
                                  final group = entry.key;
                                  final amount = entry.value;

                                  return AccountGroupOverviewTile(
                                    icon: group.icon,
                                    type: group.label,
                                    amount: amount,
                                    percentage: controller.groupPercentage(
                                      group,
                                    ),
                                    color: group.color,
                                    percentageLabel:
                                        controller.selectedView.value ==
                                            BalanceSheetType.asset
                                        ? 'Assets'
                                        : 'Liabilities',
                                  );
                                })
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          AppSection(
            sectionTitle: 'Others',
            child: Column(
              spacing: 8,
              children: [
                OthersCard(
                  icon: PhosphorIconsRegular.chartBar,
                  title: 'Charts',
                  onTap: () {
                    Get.toNamed(Routes.NETWORTHCHARTS);
                  },
                ),
                OthersCard(
                  icon: PhosphorIconsRegular.receipt,
                  title: 'Checks',
                  onTap: () {
                    Get.toNamed(Routes.CHECKMANAGEMENTS);
                  },
                ),
                OthersCard(
                  icon: PhosphorIconsRegular.export,
                  title: 'Export',
                  onTap: () {
                    Get.toNamed(Routes.NETWORTHEXPORT);
                  },
                ),
              ],
            ),
          ),
          SizedBox(height: 24),
        ],
      ),
    );
  }
}
