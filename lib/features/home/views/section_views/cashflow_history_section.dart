import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/home/controllers/home_controller.dart';
import 'package:getx_drift_app/features/home/widgets/cashflow_summary_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:intl/intl.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';

class CashflowHistorySection extends GetView<HomeController> {
  const CashflowHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSection(
      sectionTitle: 'Cashflow History',
      trailingType: SectionTrailingType.custom,
      sectionChild: Obx(() {
        return Row(
          children: [
            if (!controller.isCurrentMonth)
              AdaptivePressable(
                child: GestureDetector(
                  onTap: controller.goToCurrentMonth,
                  child: Text(
                    'Today',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      // fontSize: 15,
                      // fontWeight: FontWeight.w500,
                      // height: 20 / 15,
                    ),
                  ),
                ),
              ),
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: controller.previousMonth,
            ),

            AdaptivePressable(
              child: GestureDetector(
                onTap: () async {
                  final month = await showMonthPicker(
                    context: context,
                    initialDate: controller.selectedMonth.value,
                    firstDate: DateTime(2020),
                    lastDate: DateTime(
                      DateTime.now().year,
                      DateTime.now().month,
                    ),
                  );

                  if (month != null) {
                    controller.setMonth(month);
                  }
                },
                child: Text(
                  DateFormat("MMM ''yy").format(controller.selectedMonth.value),
                  // style: TextStyle(
                  //   fontSize: 15,
                  //   fontWeight: FontWeight.w500,
                  //   height: 20 / 15,
                  // ),
                ),
              ),
            ),
            Obx(
              () => IconButton(
                icon: const Icon(Icons.chevron_right),
                onPressed: controller.canGoNext ? controller.nextMonth : null,
              ),
            ),
          ],
        );
      }),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.bgLight,
          borderRadius: BorderRadius.circular(24),
        ),
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // SizedBox(height: 12),
            IntrinsicHeight(
              child: Obx(() {
                return StreamBuilder<MonthlyCashFlowSummary>(
                  stream: controller.monthlySummaryStream,
                  builder: (context, summarySnapshot) {
                    return StreamBuilder<List<MonthlyCashFlowTrend>>(
                      stream: controller.monthlyTrendStream,
                      builder: (context, trendSnapshot) {
                        final summary =
                            summarySnapshot.data ??
                            const MonthlyCashFlowSummary(
                              totalIn: 0,
                              totalOut: 0,
                            );

                        final trends =
                            trendSnapshot.data ??
                            const <MonthlyCashFlowTrend>[];

                        return Row(
                          spacing: 12,
                          children: [
                            Expanded(
                              child: CashFlowSummaryCard(
                                title: 'Inflow',
                                amount: summary.totalIn,
                                color: colorScheme.appInflow,
                                trend: trends.map((e) => e.inflow).toList(),
                              ),
                            ),

                            // VerticalDivider(color: colorScheme.appBorder),
                            Expanded(
                              child: CashFlowSummaryCard(
                                title: 'Outflow',
                                amount: summary.totalOut,
                                color: colorScheme.appOutflow,
                                trend: trends.map((e) => e.outflow).toList(),
                              ),
                            ),

                            // VerticalDivider(color: colorScheme.appBorder),
                            Expanded(
                              child: CashFlowSummaryCard(
                                title: 'Net Cashflow',
                                amount: summary.netCashFlow,
                                color: colorScheme.appAccent,
                                trend: trends
                                    .map((e) => e.netCashFlow)
                                    .toList(),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              }),
            ),

            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
