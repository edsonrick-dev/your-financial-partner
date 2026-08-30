import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
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
          title: Text('Financial Planner', style: AppTextStyle.headlineL),
          centerTitle: false,
          surfaceTintColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FinancialPlannerPicker(),
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

class FinancialPlannerPicker extends GetView<FinancialPlannerController> {
  const FinancialPlannerPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: controller.pageScrollController,
      padding: const EdgeInsets.symmetric(vertical: 4),
      scrollDirection: Axis.horizontal,
      child: Row(
        spacing: 8,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(width: 16),
          ...controller.financialPlannerPages.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;
            return FinancialPlannerPageShifter(
              key: controller.financialPlannerKeys[index],
              title: item.title,
              index: index,
            );
          }),

          SizedBox(width: 16),
        ],
      ),
    );
  }
}
