import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/sections/networth_summary_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/widgets/account_group_overview_tile.dart';
import 'package:getx_drift_app/features/widgets/app_tab_switcher.dart';
import 'package:getx_drift_app/features/widgets/cards/others_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

class NetworthPlannerScreen extends GetView<FinancialPlannerController> {
  const NetworthPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return SingleChildScrollView(
      child: Column(
        spacing: 12,
        children: [
          SizedBox(height: 12),
          NetWorthSummaryContainerSection(),
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
                  Container(
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
                            child: TabSwitcher(label: 'Assets', onTap: () {}),
                          ),
                          Expanded(
                            child: TabSwitcher(
                              label: 'Liabilities',
                              isActive: false,
                              onTap: () {},
                            ),
                          ),
                        ],
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
                  Column(
                    spacing: 12,
                    children: [
                      AccountGroupOverviewTile(
                        icon: PhosphorIconsRegular.handDeposit,
                        type: 'Receivables',
                        amount: 300000,
                        percentage: 0.342,
                      ),
                      AccountGroupOverviewTile(
                        icon: PhosphorIconsRegular.warehouse,
                        type: 'Tangible Properties',
                        amount: 250000,
                        percentage: 0.285,
                      ),
                      AccountGroupOverviewTile(
                        icon: PhosphorIconsRegular.chartLine,
                        type: 'Financial Instruments',
                        amount: 177351.2,
                        percentage: 0.202,
                      ),
                      AccountGroupOverviewTile(
                        icon: PhosphorIconsRegular.money,
                        type: 'Cash & Bank',
                        amount: 88648.8,
                        percentage: 0.101,
                      ),
                      AccountGroupOverviewTile(
                        icon: PhosphorIconsRegular.handWithdraw,
                        type: 'Intangible Properties',
                        amount: 60000,
                        percentage: 0.068,
                      ),
                    ],
                  ),

                  Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 80, child: Text('Assets')),
                          Container(
                            height: 8,
                            width: 175,
                            decoration: BoxDecoration(
                              color: colorScheme.appInflow,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(876000.toCompactCurrency()),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 80, child: Text('Liabilities')),
                          Container(
                            height: 8,
                            width: 133,
                            decoration: BoxDecoration(
                              color: colorScheme.appOutflow,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(400000.toCompactCurrency()),
                        ],
                      ),
                      Row(
                        children: [
                          SizedBox(width: 80, child: Text('Net Worth')),
                          Container(
                            height: 8,
                            width: 143,
                            decoration: BoxDecoration(
                              color: colorScheme.appInfo,
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          SizedBox(width: 8),
                          Text(476000.toCompactCurrency()),
                        ],
                      ),
                    ],
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
