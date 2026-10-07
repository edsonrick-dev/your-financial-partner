import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/controller/savings_planner_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/details_page/tab_views/retirement_fund_faq_view.dart';

class RetirementFundGoalDetailsPage extends GetView<SavingsPlannerController> {
  const RetirementFundGoalDetailsPage({super.key, required this.goal});
  final GoalsTableData goal;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final seletectedDetailsTabIndex = 0.obs;
    return Scaffold(
      body: Column(
        children: [
          AppDetailsHeader(
            title: 'Retirement Fund',
            child: StreamBuilder<List<GoalReservationsTableData>>(
              stream: database.goalReservationsDao.watchReservationsForGoal(
                goal.id,
              ),
              builder: (context, snapshot) {
                final reservations = snapshot.data ?? [];

                final currentAmount = reservations.fold<double>(
                  0.0,
                  (sum, reservation) => sum + reservation.amount,
                );

                final progress = goal.targetAmount > 0
                    ? (currentAmount / goal.targetAmount).clamp(0.0, 1.0)
                    : 0.0;

                final progressPercentage = progress * 100;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Current Amount',
                      style: AppTextStyle.titleM.copyWith(
                        color: colorScheme.appInversedtextMuted,
                      ),
                    ),
                    Text(
                      currentAmount.toCurrency(),
                      style: AppTextStyle.amountXL.copyWith(
                        color: colorScheme.appInversedtext,
                      ),
                    ),
                    Text(
                      'out of ${goal.targetAmount.toCurrency()}',
                      style: AppTextStyle.titleM.copyWith(
                        color: colorScheme.appInversedtextMuted,
                      ),
                    ),

                    const SizedBox(height: 20),

                    AppSection(
                      child: Row(
                        children: [
                          Expanded(
                            child: LinearProgressIndicator(
                              value: progress,
                              minHeight: 8,
                              borderRadius: BorderRadius.circular(10),
                              backgroundColor: colorScheme.appInversedtext
                                  .withAlpha(40),
                              color: colorScheme.appAccent,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Text(
                            '${progressPercentage.toStringAsFixed(1)}%',
                            style: AppTextStyle.amountM.copyWith(
                              color: colorScheme.appInversedtext,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
            onBack: () {
              Get.back();
            },
          ),
          Expanded(
            child: StreamBuilder<List<GoalReservationsTableData>>(
              stream: database.goalReservationsDao.watchReservationsForGoal(
                goal.id,
              ),
              builder: (context, snapshot) {
                final reservations = snapshot.data ?? [];

                final currentAmount = reservations.fold<double>(
                  0.0,
                  (sum, reservation) => sum + reservation.amount,
                );

                return Column(
                  children: [
                    AppDetailsPageActionSection(
                      selectedIndex: seletectedDetailsTabIndex,
                      actions: const ['Funding History', 'Milestones', 'FAQs'],
                    ),
                    Obx(() {
                      return switch (seletectedDetailsTabIndex.value) {
                        // 0 => _FundingHistorySection(goalId: goal.id),
                        2 => RetirementFundFAQView(
                          goal: goal,
                          currentAmount: currentAmount,
                        ),
                        _ => const SizedBox.shrink(),
                      };
                    }),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
