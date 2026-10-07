import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/controller/savings_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/views/empty_view/savings_planner_empty_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/views/filled_view/savings_planner_content_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/views/empty_view/risk_tolerance_assessment_prompt_view.dart';

class SavingsPlannerScreen extends GetView<SavingsPlannerController> {
  const SavingsPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const SizedBox.shrink();
      }

      // 1. Risk profile must be completed first.
      if (!controller.isRiskToleranceAssessmentFinished.value) {
        return const RiskToleranceAssessmentPromptView();
      }

      // 2. Risk profile is complete, but financial picture is incomplete.
      if (!controller.hasNetWorth || !controller.isCashflowComplete) {
        return const SavingsPlannerEmptyView();
      }

      // 3. Everything required is complete.
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
