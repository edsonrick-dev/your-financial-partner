import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/widgets/cashflow_planner_page_shifter.dart';

class FinancialPlannerScreen extends GetView<FinancialPlannerController> {
  const FinancialPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final tabIndex = controller.selectedTabIndex.value;
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Financial Planner',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w600,
              height: 28 / 22,
              letterSpacing: -0.2,
            ),
          ),
          centerTitle: false,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 8),

                    ...controller.financialPlannerPages.asMap().entries.map((
                      entry,
                    ) {
                      final index = entry.key;
                      final item = entry.value;
                      return Padding(
                        padding: EdgeInsets.only(right: 8),
                        child: CashflowPlannerPageShifter(
                          title: item.title,
                          index: index,
                        ),
                      );
                    }),

                    SizedBox(width: 8),
                  ],
                ),
              ),
              SizedBox(height: 4),
              Expanded(
                child: IndexedStack(
                  index: tabIndex,
                  children: controller.financialPlannerPages
                      .map((e) => e.page)
                      .toList(),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
