import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_planner/views/savings_planner_content_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_planner/views/savings_planner_empty_view.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';

class SavingsPlannerController extends GetxController {
  RxBool isUnderConstruction = true.obs;
}

class SavingsPlannerScreen extends GetView<SavingsPlannerController> {
  const SavingsPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          spacing: 20,
          children: [
            Obx(() {
              if (controller.isUnderConstruction.value) {
                return SavingsPlannerEmptyView();
              }
              return SavingsPlannerContentView();
            }),
            LearningSection(
              subtitle: 'Build a good understanding of your net worth',
              state: LearningSectionState.available,
              contents: [
                LearnThumbnail(title: 'What is Life Insurance'),
                LearnThumbnail(title: 'Insurance Might Not Be For You'),
                // LearnThumbnail(title: 'What Are Liabilities?'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
