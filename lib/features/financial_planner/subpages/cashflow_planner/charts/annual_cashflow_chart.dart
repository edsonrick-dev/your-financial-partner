import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'dart:math' as math;

class AnnualCashflowChart extends GetView<CashflowController> {
  const AnnualCashflowChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final income = controller.monthlyIncome;
      final budget = controller.monthlyBudget;
      final net = controller.monthlyNetCashflow;

      final highestValue = [
        ...income,
        ...budget,
      ].fold<double>(0, (max, value) => value > max ? value : max);
      final lowestValue = net.fold<double>(
        0,
        (min, value) => value < min ? value : min,
      );

      // Give both sides some breathing room.
      final maxY = highestValue <= 0.0 ? 1000.0 : highestValue * 1.15;
      final minY = lowestValue >= 0.0 ? 0.0 : lowestValue * 1.15;

      return SizedBox(
        height: 120,
        child: Stack(
          children: [
            BarChart(_barChartData(context, income, budget, minY, maxY)),

            IgnorePointer(
              child: LineChart(_lineChartData(context, net, minY, maxY)),
            ),
          ],
        ),
      );
    });
  }
}

BarChartData _barChartData(
  BuildContext context,
  List<double> income,
  List<double> budget,
  double minY,
  double maxY,
) {
  final colorScheme = context.colors;

  return BarChartData(
    minY: minY,
    maxY: maxY,

    alignment: BarChartAlignment.spaceAround,

    gridData: FlGridData(
      show: true,
      drawVerticalLine: false,
      horizontalInterval: _gridInterval(maxY, minY),
      // horizontalInterval: maxY / 4,
    ),

    borderData: FlBorderData(show: false),

    titlesData: FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 60,
          getTitlesWidget: (value, meta) {
            return Text(
              value.toCompactCurrency(),
              style: AppTextStyle.labelXS.copyWith(
                color: colorScheme.appInversedtext,
              ),
            );
          },
        ),
      ),

      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 28,
          getTitlesWidget: (value, meta) {
            final index = value.toInt();

            if (index < 0 || index >= AppMonth.values.length) {
              return const SizedBox.shrink();
            }

            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Text(
                AppMonth.values[index].shortName,
                style: AppTextStyle.labelXS.copyWith(
                  color: colorScheme.appInversedtext,
                ),
              ),
            );
          },
        ),
      ),
    ),

    barGroups: List.generate(12, (index) {
      return BarChartGroupData(
        x: index,
        barsSpace: 3,
        barRods: [
          BarChartRodData(
            toY: income[index],
            width: 7,
            color: colorScheme.appInflowInverse,
            borderRadius: BorderRadius.circular(3),
          ),
          BarChartRodData(
            toY: budget[index],
            width: 7,
            color: colorScheme.appOutflowInversed,
            borderRadius: BorderRadius.circular(3),
          ),
        ],
      );
    }),
  );
}

LineChartData _lineChartData(
  BuildContext context,
  List<double> net,
  double minY,
  double maxY,
) {
  final colorScheme = context.colors;

  return LineChartData(
    minX: -0.5,
    maxX: 11.5,
    minY: minY,
    maxY: maxY,

    gridData: const FlGridData(show: false),

    borderData: FlBorderData(show: false),

    titlesData: FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

      // IMPORTANT:
      // Reserve exactly the same space as the BarChart.
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 45,
          getTitlesWidget: (_, _) {
            return const SizedBox.shrink();
          },
        ),
      ),

      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 28,
          getTitlesWidget: (_, _) {
            return const SizedBox.shrink();
          },
        ),
      ),
    ),

    lineTouchData: LineTouchData(enabled: false),

    lineBarsData: [
      LineChartBarData(
        spots: List.generate(
          12,
          (index) => FlSpot(index.toDouble(), net[index]),
        ),

        isCurved: false,

        barWidth: 2.5,

        color: colorScheme.appInfo,

        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, bar, index) {
            return FlDotCirclePainter(
              radius: 3,
              color: colorScheme.appInfo,
              strokeWidth: 0,
            );
          },
        ),

        belowBarData: BarAreaData(show: false),
      ),
    ],
  );
}

double _gridInterval(double maxY, double minY) {
  final range = maxY - minY;

  if (range <= 0) {
    return 1;
  }

  final rawInterval = range / 4;

  final magnitude = math.pow(10, math.log(rawInterval) / math.ln10).toDouble();

  final normalized = rawInterval / magnitude;

  final niceNormalized = normalized <= 1
      ? 1
      : normalized <= 2
      ? 2
      : normalized <= 5
      ? 5
      : 10;

  return niceNormalized * magnitude;
}
