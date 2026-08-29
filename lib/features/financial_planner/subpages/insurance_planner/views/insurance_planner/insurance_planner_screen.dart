import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/insurance_planner/insurance_planner_content_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/insurance_planner/insurance_planner_empty_view.dart';

class InsurancePlannerScreen extends GetView<InsurancePlannerController> {
  const InsurancePlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isUnderConstruction.value) {
        return InsurancePlannerEmptyView();
      }
      return InsurancePlannerContentView();
    });
  }
}
