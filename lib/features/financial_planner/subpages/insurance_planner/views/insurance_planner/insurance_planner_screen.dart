import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/insurance_planner/insurance_planner_content_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/insurance_planner/insurance_planner_empty_view.dart';
import 'package:getx_drift_app/features/financial_state/financial_state.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content_library.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_context.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_engine.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_thumbnail.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';

class InsurancePlannerScreen extends GetView<InsurancePlannerController> {
  const InsurancePlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final financialProfileController = Get.find<FinancialProfileController>();
    const learnEngine = LearnEngine();
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
          top: context.topPadding,
          bottom: context.bottomPadding,
        ),
        child: Column(
          spacing: 20,
          children: [
            Obx(() {
              if (controller.isUnderConstruction.value) {
                return InsurancePlannerEmptyView();
              }
              return InsurancePlannerContentView();
            }),
            Obx(() {
              final recommendations = learnEngine.getRecommendedContent(
                state: financialProfileController.financialState,
                context: LearnContext.insurance,
                contents: learnContentLibrary,
              );

              if (recommendations.isEmpty) {
                return const SizedBox.shrink();
              }

              return LearningSection(
                subtitle: 'Build a good understanding of your net worth',
                state: LearningSectionState.available,
                contents: recommendations
                    .map(
                      (content) => LearnThumbnail(
                        title: content.title,
                        description: content.description,
                        type: content.type,
                        onTap: () {
                          // Open lesson
                        },
                      ),
                    )
                    .toList(),
              );
            }),
          ],
        ),
      ),
    );
  }
}
