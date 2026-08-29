import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/views/net_worth_planner_screen/net_worth_planner_empty_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/views/net_worth_planner_screen/net_worth_planner_screen_content.dart';

class NetworthPlannerScreen extends GetView<NetWorthController> {
  const NetworthPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isEmpty) {
        return const NetWorthEmptyView();
      }

      return NetWorthPlannerContent();
    });
  }
}
