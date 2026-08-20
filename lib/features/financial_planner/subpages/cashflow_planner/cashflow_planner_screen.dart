import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sections/cashflow_summary_container_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/widgets/cashflow_overview_tile.dart';
import 'package:getx_drift_app/features/home/views/section_views/cashflow_history_section.dart';
import 'package:getx_drift_app/features/widgets/app_tab_switcher.dart';
import 'package:getx_drift_app/features/widgets/cards/others_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/core/num_extension.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

class CashflowPlannerScreen extends GetView<CashflowController> {
  const CashflowPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return SingleChildScrollView(
      child: Column(
        spacing: 12,
        children: [
          SizedBox(height: 12),
          CashflowSummaryContainerSection(),

          AppSection(
            sectionTitle: 'Overview',
            trailingType: SectionTrailingType.textButton,
            trailingText: 'See more',
            onTrailingPressed: () {
              Get.toNamed(Routes.CASHFLOWDETAILS);
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
                            child: TabSwitcher(label: 'Income', onTap: () {}),
                          ),
                          Expanded(
                            child: TabSwitcher(
                              label: 'Allocation',
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
                      CashFlowOverviewTile(
                        type: 'Active Income',
                        amount: 540000,
                        icon: PhosphorIconsRegular.money,
                      ),
                      CashFlowOverviewTile(
                        type: 'Passive Income',
                        amount: 12000,
                        icon: PhosphorIconsRegular.money,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          CashflowHistorySection(),
          AppSection(
            sectionTitle: 'Charts',

            // showTrailing: true,
            child: Column(
              spacing: 12,
              children: [
                // BudgetCard(
                //   title: 'Food',
                //   iconKey: 'bowlFood',
                //   consumption: 250,
                //   budget: 400,
                // ),
              ],
            ),
          ),
          AppSection(
            sectionTitle: 'Others',

            // showTrailing: true,
            child: Column(
              spacing: 12,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: OthersCard(
                        icon: PhosphorIconsRegular.coins,
                        title: 'Budgets',
                        onTap: () {
                          Get.toNamed(Routes.BUDGETS);
                        },
                      ),
                    ),
                    Expanded(
                      child: OthersCard(
                        icon: PhosphorIconsRegular.receipt,
                        title: 'Bills',
                        onTap: () {
                          Get.toNamed(Routes.BILLS);
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

class CashFlowCardAmountSummary extends GetView<FinancialPlannerController> {
  final String title;
  final double amount;
  final Color color;
  final double percentage;
  const CashFlowCardAmountSummary({
    super.key,
    required this.title,
    required this.amount,
    required this.color,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: colorScheme.gradient2.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 4,
        children: [
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 13,
              height: 16 / 13,
              fontWeight: FontWeight.w600,
            ),
          ),
          Row(
            spacing: 8,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                amount.toCurrency(),
                style: AppTextStyle.amountM.copyWith(
                  color: colorScheme.appInversedtext,
                ),
              ),
              Text(
                '${(percentage * 100).toStringAsFixed(1)}%',
                style: TextStyle(
                  color: colorScheme.appInversedtextMuted,
                  fontSize: 11,
                  height: 16 / 11,
                  fontWeight: FontWeight.w400,
                  fontFeatures: [FontFeature.tabularFigures()],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
