import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';

import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/controller/retirement_planner_engine.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as d;

class RetirementFundPlanPage extends GetView<FinancialProfileController> {
  const RetirementFundPlanPage({
    super.key,
    required this.currentRetirementSavings,
  });

  final double currentRetirementSavings;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final retirementFundController = Get.put(RetirementFundController());

    return Scaffold(
      appBar: AppBar(
        title: Text('Retirement Fund', style: AppTextStyle.headlineL),
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
          child: AppSection(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                border: Border.all(color: colorScheme.appBorder),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Obx(() {
                final retirementFundNeed = controller.retirementFundNeed.value;

                final requiredMonthlyContribution =
                    controller.requiredMonthlyContribution.value;

                final birthday = controller.birthday.value;

                if (birthday == null) {
                  return const SizedBox.shrink();
                }

                final retirementDate =
                    RetirementPlannerEngine.calculateRetirementDate(
                      birthday: birthday,
                      retirementAge: controller.retirementAge.value,
                    );

                final remainingNeed =
                    (retirementFundNeed - currentRetirementSavings).clamp(
                      0.0,
                      double.infinity,
                    );
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Build your retirement fund',
                      style: AppTextStyle.titleL,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Build your retirement fund by combining what you already have set aside with regular investments.',
                      style: AppTextStyle.bodyM,
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Retirement fund needed',
                      style: AppTextStyle.titleS.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),

                    Text(
                      retirementFundNeed.toCurrency(),
                      style: AppTextStyle.amountXL,
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Current retirement savings',
                      style: AppTextStyle.titleS.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),

                    Text(
                      currentRetirementSavings.toCurrency(),
                      style: AppTextStyle.amountXL,
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Still needed',
                      style: AppTextStyle.titleS.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),

                    Text(
                      remainingNeed.toCurrency(),
                      style: AppTextStyle.amountXL,
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Required monthly investment',
                      style: AppTextStyle.titleS.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),

                    Text(
                      requiredMonthlyContribution.toCurrency(),
                      style: AppTextStyle.amountXL,
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Based on your retirement fund target and a portfolio that gradually shifts toward more conservative investments as your withdrawals approach.',
                      style: AppTextStyle.bodyL.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                    const SizedBox(height: 16),

                    Text(
                      'Retirement age',
                      style: AppTextStyle.titleS.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),

                    Text(
                      '${controller.retirementAge.value}',
                      style: AppTextStyle.amountXL,
                    ),

                    const SizedBox(height: 16),

                    Text(
                      'Retirement date',
                      style: AppTextStyle.titleS.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),

                    Text(
                      DateFormat('MMMM d, yyyy').format(retirementDate),
                      style: AppTextStyle.amountXL,
                    ),
                    const SizedBox(height: 24),

                    AppButton(
                      text: 'Save Retirement Goal',
                      onTap: () async {
                        await retirementFundController.saveRetirementGoal(
                          targetAmount: retirementFundNeed,
                          monthlyContribution: requiredMonthlyContribution,
                          dueDate: retirementDate,
                        );

                        Get.close(5);
                      },
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

class RetirementFundController extends GetxController {
  Future<void> saveRetirementGoal({
    required double targetAmount,
    required double monthlyContribution,
    required DateTime dueDate,
  }) async {
    final goal = await database.goalsDao.getOrCreateGoal(GoalType.retirement);

    await database.goalsDao.updateGoal(
      goal.copyWith(
        targetAmount: targetAmount,
        monthlyContribution: monthlyContribution,
        dueDate: d.Value(dueDate),
      ),
    );
  }
}
