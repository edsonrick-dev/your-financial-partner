import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/views/net_worth_planner_screen/net_worth_planner_empty_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/views/net_worth_planner_screen/net_worth_planner_screen_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';

class NetworthPlannerScreen extends GetView<NetWorthController> {
  const NetworthPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
            LearningSection(
              subtitle: 'Build a good understanding of your net worth',
              state: LearningSectionState.available,
              contents: [
                LearnThumbnail(title: 'What is Net Worth?'),
                LearnThumbnail(title: 'What Are Assets?'),
                LearnThumbnail(title: 'What Are Liabilities?'),
              ],
            ),
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
