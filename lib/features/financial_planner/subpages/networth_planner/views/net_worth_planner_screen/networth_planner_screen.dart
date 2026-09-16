import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/views/net_worth_planner_screen/net_worth_planner_empty_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/views/net_worth_planner_screen/net_worth_planner_screen_content.dart';
import 'package:getx_drift_app/features/financial_state/financial_state.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content_library.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_context.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_engine.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_thumbnail.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';

class NetworthPlannerScreen extends GetView<NetWorthController> {
  const NetworthPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final financialProfileController = Get.find<FinancialProfileController>();
    const learnEngine = LearnEngine();

    return Obx(() {
      if (controller.isEmpty) {
        return const NetWorthEmptyView();
      }

      return SingleChildScrollView(
        padding: EdgeInsets.only(
          top: context.topPadding,
          bottom: context.bottomPadding,
        ),
        child: Column(
          spacing: 20,
          children: [
            NetWorthPlannerContent(),
            Obx(() {
              final recommendations = learnEngine.getRecommendedContent(
                state: financialProfileController.financialState,
                context: LearnContext.netWorth,
                contents: learnContentLibrary,
              );

              if (recommendations.isEmpty) {
                return const SizedBox.shrink();
              }

              return LearningSection(
                subtitle: 'Build a good understanding of your net worth.',
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
      );
    });

    // if (controller.isEmpty) {
    //   return SingleChildScrollView(
    //         child: Padding(
    //           padding: EdgeInsets.only(
    //             top: context.topPadding,
    //             bottom: context.bottomPadding,
    //           ),
    //           child: Column(
    //             spacing: 20,
    //             children: [
    //               Obx(() {
    //                 if (controller.isEmpty) {
    //                   return const NetWorthEmptyView();
    //                 }

    //                 return NetWorthPlannerContent();
    //               }),

    //             ],
    //           ),
    //         ),
    //       );
    // } else {
    //   return Expanded(child: Column());
    // }
  }
}
