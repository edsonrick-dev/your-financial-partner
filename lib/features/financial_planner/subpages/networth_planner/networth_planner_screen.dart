import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/sections/networth_summary_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/widgets/account_group_overview_tile.dart';
import 'package:getx_drift_app/features/sheets/create_sheets/create_payment_account/create_payment_account_controller.dart';
import 'package:getx_drift_app/features/widgets/app_tab_switcher.dart';
import 'package:getx_drift_app/features/widgets/cards/account_card.dart';
import 'package:getx_drift_app/features/widgets/cards/others_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

class NetworthPlannerScreen extends GetView<NetWorthController> {
  const NetworthPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return SingleChildScrollView(
      child: Column(
        spacing: 12,
        children: [
          SizedBox(height: 12),
          Obx(
            () =>
                NetWorthSummaryContainerSection(netWorth: controller.netWorth),
          ),
          AppSection(
            sectionTitle: 'Wealth Overview',
            trailingType: SectionTrailingType.textButton,
            trailingText: 'See more',
            onTrailingPressed: () {
              Get.toNamed(Routes.NETWORTHDETAILS);
            },
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.bgLight,
                borderRadius: BorderRadius.circular(24),
              ),
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
                  Container(
                    height: 8,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorScheme.text,
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ),
                  Obx(
                    () => Column(
                      spacing: 12,
                      children: controller.displayedGroupTotals.entries.map((
                        entry,
                      ) {
                        final group = entry.key;
                        final amount = entry.value;

                        return AccountGroupOverviewTile(
                          icon: group.icon,
                          type: group.label,
                          amount: amount,
                          percentage: controller.groupPercentage(group),
                          color: group.color,
                          percentageLabel:
                              controller.selectedView.value ==
                                  BalanceSheetType.asset
                              ? 'Assets'
                              : 'Liabilities',
                        );
                      }).toList(),
                    ),
                  ),
                  Obx(
                    () => Column(
                      spacing: 8,
                      children: [
                        _WealthMetricRow(
                          label: 'Assets',
                          amount: controller.totalAssets,
                          ratio: controller.assetRatio,
                          color: colorScheme.appInflow,
                        ),

                        _WealthMetricRow(
                          label: 'Liabilities',
                          amount: controller.totalLiabilities,
                          ratio: controller.liabilityRatio,
                          color: colorScheme.appOutflow,
                        ),

                        _WealthMetricRow(
                          label: 'Net Worth',
                          amount: controller.netWorth,
                          ratio: controller.netWorthRatio,
                          color: colorScheme.appInfo,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          AppSection(
            sectionTitle: 'Others',
            child: Column(
              spacing: 12,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: OthersCard(
                        icon: PhosphorIconsRegular.chartBar,
                        title: 'Charts',
                        onTap: () {
                          Get.toNamed(Routes.NETWORTHCHARTS);
                        },
                      ),
                    ),
                    Expanded(
                      child: OthersCard(
                        icon: PhosphorIconsRegular.users,
                        title: 'Personal Balances',
                        onTap: () {
                          Get.toNamed(Routes.PEOPLEBALANCES);
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: OthersCard(
                        icon: PhosphorIconsRegular.receipt,
                        title: 'Checks',
                        onTap: () {
                          Get.toNamed(Routes.CHECKMANAGEMENTS);
                        },
                      ),
                    ),
                    Expanded(
                      child: OthersCard(
                        icon: PhosphorIconsRegular.export,
                        title: 'Export',
                        onTap: () {
                          Get.toNamed(Routes.NETWORTHEXPORT);
                        },
                      ),
                    ),
                  ],
                ),

                // BudgetCard(
                //   title: 'Food',
                //   iconKey: 'bowlFood',
                //   consumption: 250,
                //   budget: 400,
                // ),
              ],
            ),
          ),
          // AppSection(
          //   sectionTitle: 'Bills',
          //   trailingType: SectionTrailingType.textButton,
          //   trailingText: 'View all',
          //   onTrailingPressed: () {
          //     Get.toNamed(Routes.TRANSACTION);
          //   },
          //   // showTrailing: true,
          //   child: Column(
          //     spacing: 12,
          //     children: [
          //       BillsCard(
          //         iconKey: 'internet',
          //         billName: 'Internet Home Fiber',
          //         billType: 'Internet Bill',
          //         dueDate: DateTime(2026, 6, 4),
          //         amountDue: 6000,
          //       ),
          //     ],
          //   ),
          // ),

          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemCount: controller.projections.length,
          //   itemBuilder: (_, index) {
          //     final item = controller.projections[index];

          //     return Card(
          //       child: ListTile(
          //         title: Text(item.month.fullName),
          //         subtitle: Text(
          //           'Income: ${item.income}'
          //           '\nAllocated: ${item.allocated}'
          //           '\nSurplus: ${item.surplus}',
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}

class _WealthMetricRow extends StatelessWidget {
  final String label;
  final double amount;
  final double ratio;
  final Color color;

  const _WealthMetricRow({
    required this.label,
    required this.amount,
    required this.ratio,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 80, child: Text(label)),

        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 8,
                  width: constraints.maxWidth * ratio,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
              );
            },
          ),
        ),

        const SizedBox(width: 8),

        Text(amount.toCompactCurrency(), textAlign: TextAlign.right),
      ],
    );
  }
}
