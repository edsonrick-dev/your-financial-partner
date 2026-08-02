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
            sectionTitle: 'Overview',
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
                  Column(
                    spacing: 12,
                    children: [
                      AccountGroupOverviewTile(
                        icon: PhosphorIconsRegular.warehouse,
                        type: 'Real Estate',
                        amount: 1210000,
                      ),
                      AccountGroupOverviewTile(
                        icon: PhosphorIconsRegular.chartLine,
                        type: 'Investments',
                        amount: 275000,
                      ),
                      AccountGroupOverviewTile(
                        icon: PhosphorIconsRegular.money,
                        type: 'Cash & Bank',
                        amount: 210500,
                      ),
                      AccountGroupOverviewTile(
                        icon: PhosphorIconsRegular.handWithdraw,
                        type: 'Receivables',
                        amount: 18500,
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
                        title: 'People',
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
