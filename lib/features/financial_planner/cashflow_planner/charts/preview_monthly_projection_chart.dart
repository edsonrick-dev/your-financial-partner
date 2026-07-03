import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

class PreviewMonthlyProjectionChart
    extends GetView<FinancialPlannerController> {
  const PreviewMonthlyProjectionChart({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Obx(() {
      // final planType = controller.selectedCashflowPlanType.value;
      return SizedBox(
        height: 140,
        child: BarChart(
          BarChartData(
            barGroups: controller.previewProjections.asMap().entries.map((
              entry,
            ) {
              return BarChartGroupData(
                x: entry.key,
                barRods: [BarChartRodData(toY: entry.value.amount)],
              );
            }).toList(),
            extraLinesData: ExtraLinesData(
              horizontalLines: [
                HorizontalLine(
                  y: controller.previewMonthlyAverage,
                  strokeWidth: 1,
                  dashArray: [6, 4],
                ),
              ],
            ),
            gridData: FlGridData(show: false),
            borderData: FlBorderData(show: false),
            titlesData: FlTitlesData(
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 52,
                  getTitlesWidget: (value, meta) {
                    return SizedBox(
                      width: 40,
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          value.toInt().toCompactCurrency(
                            kThreshold: 1000,
                            symbol: '',
                          ),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            fontFeatures: [FontFeature.tabularFigures()],
                            color: colorScheme.appTextMuted,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        AppMonth.values[value.toInt()].fullName.trim()[0],
                        style: const TextStyle(fontSize: 10),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
