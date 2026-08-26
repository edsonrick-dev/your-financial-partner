import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/charts/annual_cashflow_chart.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

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
                _LegendItem(
                  color: colorScheme.appInflowInverse,
                  label: 'Income',
                ),
                const SizedBox(width: 16),
                _LegendItem(
                  color: colorScheme.appOutflowInversed,
                  label: 'Budget',
                ),
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
