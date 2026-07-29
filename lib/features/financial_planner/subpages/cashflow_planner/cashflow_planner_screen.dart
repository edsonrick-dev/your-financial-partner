import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CashflowPlannerScreen extends GetView<FinancialPlannerController> {
  const CashflowPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return SingleChildScrollView(
      child: Column(
        spacing: 12,
        children: [
          SizedBox(height: 12),
          _CashflowSummarySection(controller: controller),
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
                              child: Center(child: Text('Income')),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: 36,
                              decoration: BoxDecoration(
                                // color: colorScheme.appAccent,
                              ),
                              child: Center(child: Text('Allocation')),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  CashFlowOverviewTile(),
                ],
              ),
            ),
          ),
          // AppSection(
          //   sectionTitle: 'CTA',
          //   child: Column(
          //     spacing: 12,
          //     children: [
          //       Container(
          //         padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //         width: double.infinity,
          //         decoration: BoxDecoration(
          //           color: colorScheme.primary,
          //           borderRadius: BorderRadius.circular(8),
          //         ),
          //         child: Center(
          //           child: Text(
          //             'View Cashflow Plans',
          //             style: TextStyle(color: colorScheme.inversePrimary),
          //           ),
          //         ),
          //       ),
          //       GestureDetector(
          //         onTap: () {
          //           AppSheets.budgetSheets();
          //         },
          //         child: Container(
          //           padding: EdgeInsets.symmetric(
          //             horizontal: 16,
          //             vertical: 8,
          //           ),
          //           width: double.infinity,
          //           decoration: BoxDecoration(
          //             color: colorScheme.primary,
          //             borderRadius: BorderRadius.circular(8),
          //           ),
          //           child: Center(
          //             child: Text(
          //               'Add Plans',
          //               style: TextStyle(color: colorScheme.inversePrimary),
          //             ),
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
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
                        icon: PhosphorIconsRegular.coins,
                        title: 'Budgets',
                      ),
                    ),
                    Expanded(
                      child: OthersCard(
                        icon: PhosphorIconsRegular.receipt,
                        title: 'Bills',
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

class CashFlowOverviewTile extends StatelessWidget {
  const CashFlowOverviewTile({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Row(
      children: [
        Row(
          spacing: 12,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0.2,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.appInflow,
                    ),
                  ),
                ),
                Icon(
                  AppIcons.categories.resolve('wow'),
                  color: colorScheme.appInflow,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Passive Income',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  '3 sources',
                  style: TextStyle(
                    color: colorScheme.textMuted,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        Spacer(),
        Text(
          8120.toCurrency(),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            height: 20 / 15,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
        SizedBox(width: 12),
      ],
    );
  }
}

class _CashflowSummarySection extends StatelessWidget {
  const _CashflowSummarySection({required this.controller});

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
          // spacing: 12,
          children: [
            Text(
              'Annual Cashflow',
              style: TextStyle(
                color: colorScheme.inversePrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CashflowRingChart(
                    debtColor: colorScheme.appOutflow,
                    savingsColor: colorScheme.appNeutral,
                    expensesColor: colorScheme.appAccent,
                    debt: controller.annualDebtRepayment,
                    expenses: controller.annualExpense,
                    savings: controller.annualSavings,
                    centerText: 'Under\nIdeal',
                  ),
                ),

                Expanded(
                  child: Column(
                    spacing: 8,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CashFlowCardAmountSummary(
                        title: 'Debt Repayment',
                        color: colorScheme.appOutflow,
                        amount: controller.annualDebtRepayment,
                        percentage: controller.debtRepaymentPercentage,
                      ),
                      CashFlowCardAmountSummary(
                        title: 'Expenses',
                        color: colorScheme.appAccent,
                        amount: controller.annualExpense,
                        percentage: controller.expensePercentage,
                      ),
                      CashFlowCardAmountSummary(
                        title: 'Savings & Investments',
                        color: colorScheme.appNeutral,
                        amount: controller.annualSavings,
                        percentage: controller.savingsPercentage,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,

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
              '${(percentage * 100).toStringAsFixed(1)}%',
              style: TextStyle(
                color: colorScheme.appInversedtextMuted,
                fontSize: 11,
                height: 16 / 11,
                fontWeight: FontWeight.w400,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
            Text(
              amount.toCurrency(),
              style: TextStyle(
                color: colorScheme.inversePrimary,
                fontSize: 15,
                height: 20 / 15,
                fontWeight: FontWeight.w600,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class CashflowRingChart extends StatelessWidget {
  const CashflowRingChart({
    super.key,
    required this.debt,
    required this.expenses,
    required this.savings,
    required this.centerText,
    required this.debtColor,
    required this.expensesColor,
    required this.savingsColor,
  });

  final double debt;
  final double expenses;
  final double savings;
  final Color debtColor;
  final Color expensesColor;
  final Color savingsColor;
  final String centerText;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return SizedBox(
      width: 170,
      height: 170,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              startDegreeOffset: -90,
              sectionsSpace: 0,
              centerSpaceRadius: 54,
              borderData: FlBorderData(show: false),
              sections: [
                PieChartSectionData(
                  value: debt,
                  color: debtColor,
                  radius: 12,
                  showTitle: false,
                ),
                PieChartSectionData(
                  value: expenses,
                  color: expensesColor,
                  radius: 12,
                  showTitle: false,
                ),
                PieChartSectionData(
                  value: savings,
                  color: savingsColor,
                  radius: 12,
                  showTitle: false,
                ),
              ],
            ),
          ),

          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                centerText,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                  color: colorScheme.appInversedtext,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
