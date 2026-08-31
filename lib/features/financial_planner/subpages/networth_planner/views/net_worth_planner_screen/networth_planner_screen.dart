import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/controller/networth_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/views/net_worth_planner_screen/net_worth_planner_empty_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/views/net_worth_planner_screen/net_worth_planner_screen_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learn_content.dart';
import 'package:getx_drift_app/features/learn_with_ascend/learning_section_shell.dart';

class NetworthPlannerScreen extends GetView<NetWorthController> {
  const NetworthPlannerScreen({super.key});

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
                return const NetWorthEmptyView();
              }

              return NetWorthPlannerContent();
            }),

            LearningSection(
              subtitle: 'Build a good understanding of your net worth',
              state: LearningSectionState.available,
              contents: [
                LearnThumbnail(title: 'What is Net Worth?'),
                LearnThumbnail(title: 'What Are Assets?'),
                LearnThumbnail(title: 'What Are Liabilities?'),
              ],
            ),

            // Column(
            //   children: [
            //     AppSection(
            //       sectionTitle: 'About Net Worth',
            //       child: AppSectionBody(
            //         child: Padding(
            //           padding: const EdgeInsets.all(12),
            //           child: Column(
            //             children: [
            //               Text(
            //                 '''Net worth is what you own minus what you owe.\nIt gives you a snapshot of your overall financial position. As you build assets and pay down debt, your net worth grows—giving you a clearer picture of whether you're moving toward greater financial stability.''',
            //                 style: AppTextStyle.bodyM,
            //               ),
            //             ],
            //           ),
            //         ),
            //       ),
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
    );
  }
}
