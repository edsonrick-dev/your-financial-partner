import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sections/cashflow_summary_container_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/metric_bar_row.dart';
import 'package:getx_drift_app/features/widgets/cards/others_card.dart';
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
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                            textColor: controller.annualBudgetDifference >= 0
                                ? colorScheme.appInflow
                                : colorScheme.appOutflow,
                          ),

                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: Text(
                          //         'Min. Emergency Fund Need (3mo.)',
                          //         style: AppTextStyle.labelS,
                          //       ),
                          //     ),
                          //     Text(
                          //       controller.minimumEmergencyFund
                          //           .toCompactCurrency(),
                          //       style: AppTextStyle.labelS,
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: Text(
                          //         'Ideal Annual Income',
                          //         style: AppTextStyle.labelS,
                          //       ),
                          //     ),
                          //     Text(
                          //       controller.idealAnnualIncome
                          //           .toCompactCurrency(),
                          //       style: AppTextStyle.labelS,
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: Text(
                          //         'Target Monthly Income',
                          //         style: AppTextStyle.labelS,
                          //       ),
                          //     ),
                          //     Text(
                          //       controller.idealMonthlyIncome
                          //           .toCompactCurrency(),
                          //       style: AppTextStyle.labelS,
                          //     ),
                          //   ],
                          // ),
                          // Row(
                          //   children: [
                          //     Expanded(
                          //       child: Text(
                          //         'Budget Gap',
                          //         style: AppTextStyle.labelS,
                          //       ),
                          //     ),
                          //     Text(
                          //       controller.annualBudgetGap.toCompactCurrency(),
                          //       style: AppTextStyle.labelS,
                          //     ),
                          //   ],
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          // AppSection(
          //   sectionTitle: 'Cashflow Interpretation',

          //   child: AppSectionBody(
          //     child: Padding(
          //       padding: const EdgeInsets.all(8.0),
          //       child: Column(
          //         spacing: 16,
          //         children: [
          //           Text(
          //             'These targets are based on the 70/30 rule--70% for your lifestyle'
          //             ' and 30% for savings and investments. We identify the next steps '
          //             'based on your planned income and',
          //           ),
          //           IncomeTargetCard(),
          //           BudgetTargetCard(),
          //         ],
          //       ),
          //     ),
          //   ),
          // ),
          // SizedBox(height: 20),
          AppSection(
            sectionTitle: 'Cashflow Tools',
            child: Column(
              spacing: 16,
              children: [
                OthersCard(
                  title: 'Bill Manager',
                  onTap: () {
                    Get.toNamed(Routes.BILLS);
                  },
                ),
                OthersCard(title: 'Categories'),
                // AppSectionBody(
                //   child: Column(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(16.0),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Icon(PhosphorIconsRegular.receipt, size: 40),
                //             SizedBox(height: 20),
                //             Text(
                //               'No Bills Created Yet',
                //               style: AppTextStyle.headlineL,
                //             ),
                //             SizedBox(height: 8),
                //             FittedBox(
                //               child: Text(
                //                 textAlign: TextAlign.center,
                //                 'Go to Bill Manager to create your first bill',
                //                 style: AppTextStyle.bodyM,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: AppButton(
                //           text: 'Go to Bill Manager',
                //           onTap: () {
                //             Get.toNamed(Routes.BILLS);
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),

          SizedBox(height: 24),
        ],
      ),
    );
  }
}
