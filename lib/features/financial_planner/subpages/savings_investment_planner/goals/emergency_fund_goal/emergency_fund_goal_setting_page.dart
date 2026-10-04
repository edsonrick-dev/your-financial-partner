import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/emergency_fund_allocation_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/fund_milestone/fund_milestone_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/emergency_fund_need.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';

class EmergencyFundGoalSettingPage extends GetView<FinancialProfileController> {
  const EmergencyFundGoalSettingPage({super.key, required this.type});
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
          EmergencyFundNeed(),
        ],
      ),
    );
  }
}
