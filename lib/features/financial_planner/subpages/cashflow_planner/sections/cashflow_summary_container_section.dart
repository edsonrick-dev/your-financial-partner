import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:fl_chart/fl_chart.dart';

class CashflowSummaryContainerSection extends GetView<CashflowController> {
  const CashflowSummaryContainerSection({super.key});
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSection(
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: AppGradient.gradientA(colorScheme),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Annual Cashflow',
              style: AppTextStyle.titleL.copyWith(
                color: colorScheme.appInversedtextMuted,
              ),
            ),

            const SizedBox(height: 20),

            const AnnualCashflowChart(),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _LegendItem(color: colorScheme.appInflow, label: 'Income'),
                const SizedBox(width: 16),
                _LegendItem(color: colorScheme.appOutflow, label: 'Budget'),
                const SizedBox(width: 16),
                _LegendItem(
                  color: colorScheme.appInfo,
                  label: 'Net Cashflow',
                  isLine: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

double _gridInterval(double maxY, double minY) {
  final range = maxY - minY;

  if (range <= 10000) {
    return 5000;
  }

  if (range <= 50000) {
    return 10000;
  }

  if (range <= 100000) {
    return 25000;
  }

  return 50000;
}

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
    ),

    borderData: FlBorderData(show: false),

    titlesData: FlTitlesData(
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),

      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 45,
          getTitlesWidget: (value, meta) {
            return Text(
              _compact(value),
              style: AppTextStyle.labelXS.copyWith(
                color: colorScheme.inversePrimary,
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
                  color: colorScheme.inversePrimary,
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
            color: colorScheme.appInflow,
            borderRadius: BorderRadius.circular(3),
          ),
          BarChartRodData(
            toY: budget[index],
            width: 7,
            color: colorScheme.appOutflow,
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

String _compact(double value) {
  final sign = value < 0 ? '-' : '';
  final amount = value.abs();

  if (amount >= 1000000) {
    return '$sign₱${(amount / 1000000).toStringAsFixed(1)}M';
  }

  if (amount >= 1000) {
    return '$sign₱${(amount / 1000).toStringAsFixed(0)}K';
  }

  return '$sign₱${amount.toStringAsFixed(0)}';
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;
  final bool isLine;

  const _LegendItem({
    required this.color,
    required this.label,
    this.isLine = false,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Row(
      children: [
        Container(
          width: isLine ? 14 : 8,
          height: isLine ? 2 : 8,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(color: colorScheme.inversePrimary)),
      ],
    );
  }
}
