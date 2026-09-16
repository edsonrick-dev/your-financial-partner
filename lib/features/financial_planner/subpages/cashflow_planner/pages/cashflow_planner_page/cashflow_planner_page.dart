import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/cashflow_planner_page/cashflow_planner_content_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/cashflow_planner_page/cashflow_planner_empty_view.dart';
import 'package:getx_drift_app/features/financial_state/financial_state.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content_library.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_context.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_engine.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_thumbnail.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';

class CashflowPlannerPage extends GetView<CashflowController> {
  const CashflowPlannerPage({super.key});
  @override
  Widget build(BuildContext context) {
    final financialProfileController = Get.find<FinancialProfileController>();

    const learnEngine = LearnEngine();
    return Obx(() {
      if (controller.isEmpty) {
        return const CashflowPlannerEmptyView();
      }

      final recommendations = learnEngine.getRecommendedContent(
        state: financialProfileController.financialState,
        context: LearnContext.cashFlow,
        contents: learnContentLibrary
            .where((content) => content.context == LearnContext.cashFlow)
            .toList(),
      );

      return SingleChildScrollView(
        padding: EdgeInsets.only(
          top: context.topPadding,
          bottom: context.bottomPadding,
        ),
        child: Column(
          children: [
            CashflowPlannerContentView(),

            if (recommendations.isNotEmpty) ...[
              SizedBox(height: 20),
              LearningSection(
                subtitle: 'Build a better understanding of your cash flow',
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
              ),
            ],
            // SizedBox(height: context.bottomPadding),
          ],
        ),
      );
    });
  }
}
