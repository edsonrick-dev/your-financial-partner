import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';

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
                style: AppTextStyle.headlineL.copyWith(
                  color: colorScheme.inversePrimary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
