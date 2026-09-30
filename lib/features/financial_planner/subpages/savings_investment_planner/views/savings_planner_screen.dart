import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/controller/savings_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/views/savings_planner_content_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/views/savings_planner_empty_view.dart';

class SavingsPlannerScreen extends GetView<SavingsPlannerController> {
  const SavingsPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // if (controller.isUnderConstruction.value) {
      //   return const SavingsPlannerEmptyView();
      // }
      if (controller.isLoading.value) {
        return const SizedBox.shrink();
      }

      if (!controller.isRiskToleranceAssessmentFinished.value) {
        return const RiskToleranceAssessmentPromptView();
      }

      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(
            top: context.topPadding,
            bottom: context.bottomPadding,
          ),
          child: Column(
            spacing: 20,
            children: [const SavingsPlannerContentView()],
          ),
        ),
      );
    });
  }
}
