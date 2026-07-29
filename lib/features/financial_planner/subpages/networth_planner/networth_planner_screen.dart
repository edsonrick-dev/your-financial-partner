import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/cashflow_planner_screen.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

import 'package:fl_chart/fl_chart.dart';
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
          _NetWorthSummaryContainer(controller: controller),
          AppSection(
            sectionTitle: 'Overview',
            trailingType: SectionTrailingType.textButton,
            trailingText: 'View all',
            onTrailingPressed: () {
              Get.toNamed(Routes.TRANSACTION);
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
                            child: Container(
                              height: 36,
                              decoration: BoxDecoration(
                                color: colorScheme.appAccent,
                              ),
                              child: Center(child: Text('Assets')),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 36,
                              decoration: BoxDecoration(
                                // color: colorScheme.appAccent,
                              ),
                              child: Center(child: Text('Liabilities')),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CashFlowOverviewTile(),
                  CashFlowOverviewTile(),
                  CashFlowOverviewTile(),
                  CashFlowOverviewTile(),
                ],
              ),
            ),
          ),

          AppSection(
            sectionTitle: 'Others',
            trailingType: SectionTrailingType.textButton,

            onTrailingPressed: () {
              Get.toNamed(Routes.TRANSACTION);
            },
            // showTrailing: true,
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
                      ),
                    ),
                    Expanded(
                      child: OthersCard(
                        icon: PhosphorIconsRegular.users,
                        title: 'People',
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
                      ),
                    ),
                    Expanded(
                      child: OthersCard(
                        icon: PhosphorIconsRegular.export,
                        title: 'Export',
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

class OthersCard extends StatelessWidget {
  final IconData icon;
  final String title;
  const OthersCard({
    super.key,
    this.icon = PhosphorIconsRegular.flipHorizontal,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      constraints: BoxConstraints(minHeight: 44),
      decoration: BoxDecoration(
        color: colorScheme.bgLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 12),
          Text(title),
          Spacer(),
          Icon(PhosphorIconsRegular.caretRight, size: 16),
        ],
      ),
    );
  }
}

class _NetWorthSummaryContainer extends StatelessWidget {
  const _NetWorthSummaryContainer({required this.controller});

  final FinancialPlannerController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSection(
      // sectionTitle: 'Annual Cashflow',
      child: Container(
        padding: EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.text, colorScheme.gradient2],
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text(
              'Net Worth',
              style: TextStyle(
                color: colorScheme.inversePrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  123456789.1.toCurrency(),
                  style: TextStyle(
                    color: colorScheme.inversePrimary,
                    fontSize: 32,
                    height: 40 / 32,
                    fontFeatures: [FontFeature.tabularFigures()],
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Icon(
                      PhosphorIconsFill.caretUp,
                      color: colorScheme.appInflow,
                      size: 16,
                    ),
                    RichText(
                      text: TextSpan(
                        text: '${(0.2 * 100).toStringAsFixed(1)}%',
                        style: TextStyle(
                          color: colorScheme.appInflow,
                          fontSize: 15,
                          height: 20 / 15,
                          fontFeatures: [FontFeature.tabularFigures()],
                          fontWeight: FontWeight.w700,
                        ),
                        children: [
                          TextSpan(
                            text: ' vs yesterday',
                            style: TextStyle(
                              color: colorScheme.textInversed,
                              fontSize: 15,
                              height: 20 / 15,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
