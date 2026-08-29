import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/cashflow_planner_page/cashflow_planner_content_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/cashflow_planner_page/cashflow_planner_empty_view.dart';

class CashflowPlannerPage extends GetView<CashflowController> {
  const CashflowPlannerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isEmpty) {
        return const CashflowPlannerEmptyView();
      }

      return CashflowPlannerContentView();
    });
  }
}
