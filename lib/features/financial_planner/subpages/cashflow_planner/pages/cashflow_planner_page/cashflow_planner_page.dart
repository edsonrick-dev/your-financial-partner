import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/cashflow_planner_page/cashflow_planner_content_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/cashflow_planner_page/cashflow_planner_empty_view.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';

class CashflowPlannerPage extends GetView<CashflowController> {
  const CashflowPlannerPage({super.key});
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          spacing: 20,
          children: [
            Obx(() {
              if (controller.isEmpty) {
                return const CashflowPlannerEmptyView();
              }

              return CashflowPlannerContentView();
            }),
            LearningSection(
              subtitle: 'Build a good understanding of your net worth',
              state: LearningSectionState.available,
              contents: [
                LearnThumbnail(title: 'What is Cashflow?'),
                LearnThumbnail(title: 'What is an Income Plan?'),
                LearnThumbnail(title: 'What is a Budget?'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
