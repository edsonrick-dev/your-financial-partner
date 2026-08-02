import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/cashflow_planner_screen.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/widgets/cashflow_ring_chart.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class CashflowSummaryContainerSection
    extends GetView<FinancialPlannerController> {
  const CashflowSummaryContainerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    Color debtColor = colorScheme.appOutflow;
    Color expenseColor = colorScheme.appAccent;
    Color savingsColor = colorScheme.appInflow;

    return AppSection(
      // sectionTitle: 'Annual Cashflow',
      child: Container(
        padding: EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppGradient.gradientA(colorScheme),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          // spacing: 12,
          children: [
            Text(
              'Annual Cashflow',
              style: AppTextStyle.titleL.copyWith(
                color: colorScheme.appInversedtextMuted,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CashflowRingChart(
                    debtColor: debtColor,
                    savingsColor: savingsColor,
                    expensesColor: expenseColor,
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
                        color: debtColor,
                        amount: controller.annualDebtRepayment,
                        percentage: controller.debtRepaymentPercentage,
                      ),
                      CashFlowCardAmountSummary(
                        title: 'Expenses',
                        color: expenseColor,
                        amount: controller.annualExpense,
                        percentage: controller.expensePercentage,
                      ),
                      CashFlowCardAmountSummary(
                        title: 'Savings & Investments',
                        color: savingsColor,
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
