import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sections/cashflow_summary_container_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/metric_bar_row.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class CashflowPlannerContentView extends GetView<CashflowController> {
  const CashflowPlannerContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 20),
          CashflowSummaryContainerSection(),
          SizedBox(height: 24),
          AppSection(
            sectionTitle: 'Plan Overview',
            trailingType: SectionTrailingType.textButton,
            trailingText: 'See plans',
            onTrailingPressed: () {
              Get.toNamed(Routes.CASHFLOWDETAILS);
            },
            child: Column(
              spacing: 20,
              children: [
                Obx(
                  () => AppSectionBody(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          MetricBarRow(
                            label: 'Income',
                            amount: controller.plannedAnnualIncome.value,
                            ratio: controller.annualIncomeRatio,
                            color: colorScheme.appInflow,
                          ),
                          MetricBarRow(
                            label: 'Budget',
                            amount: controller.annualBudget.value,
                            ratio: controller.annualBudgetRatio,
                            color: colorScheme.appOutflow,
                          ),

                          MetricBarRow(
                            label: controller.annualBudgetDifference >= 0
                                ? 'Surplus'
                                : 'Deficit',
                            amount: controller.annualBudgetDifference.abs(),
                            ratio: controller.annualBudgetDifferenceRatio,
                            color: controller.annualBudgetDifference >= 0
                                ? colorScheme.appInflow
                                : colorScheme.appOutflow,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // AppSectionBody(
                //   child: Padding(
                //     padding: const EdgeInsets.all(8.0),
                //     child: Column(
                //       spacing: 16,
                //       children: [
                //         Container(
                //           width: double.infinity,
                //           decoration: BoxDecoration(
                //             color: colorScheme.bg,
                //             borderRadius: BorderRadius.circular(8),
                //             border: Border.all(color: colorScheme.appBorder),
                //           ),
                //           child: ClipRRect(
                //             borderRadius: BorderRadius.circular(8),

                //             child: Row(
                //               children: [
                //                 Expanded(
                //                   child: TabSwitcher(
                //                     label: 'Income',
                //                     onTap: () {},
                //                   ),
                //                 ),
                //                 Expanded(
                //                   child: TabSwitcher(
                //                     label: 'Allocation',
                //                     isActive: false,
                //                     onTap: () {},
                //                   ),
                //                 ),
                //               ],
                //             ),
                //           ),
                //         ),
                //         Column(
                //           spacing: 12,
                //           children: [
                //             CashFlowOverviewTile(
                //               type: 'Active Income',
                //               amount: 540000,
                //               icon: PhosphorIconsRegular.money,
                //             ),
                //             CashFlowOverviewTile(
                //               type: 'Passive Income',
                //               amount: 12000,
                //               icon: PhosphorIconsRegular.money,
                //             ),
                //           ],
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // CashflowHistorySection(),
          // AppSection(
          //   sectionTitle: 'Bills Management',

          //   // showTrailing: true,
          //   child: Column(
          //     spacing: 12,
          //     children: [
          //       OthersCard(
          //         icon: PhosphorIconsRegular.receipt,
          //         title: 'Bills',
          //         onTap: () {
          //           Get.toNamed(Routes.BILLS);
          //         },
          //       ),

          //       // BudgetCard(
          //       //   title: 'Food',
          //       //   iconKey: 'bowlFood',
          //       //   consumption: 250,
          //       //   budget: 400,
          //       // ),
          //     ],
          //   ),
          // ),
          // LearningSection(contents: [LearnThumbnail()]),
          SizedBox(height: 24),
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
