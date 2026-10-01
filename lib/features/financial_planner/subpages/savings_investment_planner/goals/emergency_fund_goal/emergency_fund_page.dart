import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/emergency_fund_need.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';

class EmergencyFundPage extends GetView<FinancialProfileController> {
  const EmergencyFundPage({super.key, required this.type});
  final GoalType type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Fund', style: AppTextStyle.headlineL),
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          // FundMilestonePage(),

          // EmergencyFundSetAmount(),
          EmergencyFundNeed(),
          // const SizedBox(height: 8),

          // // AppSection(
          // //   child: AppButton(text: 'Continue', onTap: () {}),
          // // ),
          // SizedBox(height: context.bottomPaddingSub),
        ],
      ),
    );
  }
}
