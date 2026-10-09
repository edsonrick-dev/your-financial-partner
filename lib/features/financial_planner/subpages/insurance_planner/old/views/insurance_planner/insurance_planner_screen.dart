import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/views/insurance_planner/insurance_planner_content_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/views/insurance_planner/insurance_planner_empty_view.dart';

class InsurancePlannerScreen extends GetView<InsurancePlannerController> {
  const InsurancePlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!controller.isInsuranceQuestionnairesFinished.value) {
        return InsurancePlannerEmptyView();
      }
      debugPrint('${controller.isInsuranceQuestionnairesFinished.value}');

      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: context.topPadding,
            bottom: context.bottomPadding,
          ),
          child: InsurancePlannerContentView(),
        ),
      );
    });
  }
}
