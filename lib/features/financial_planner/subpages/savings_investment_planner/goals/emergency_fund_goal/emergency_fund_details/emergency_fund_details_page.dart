import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/controller/savings_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/emergency_fund_details/tabs/emergency_fund_FAQs_tab.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EmergencyFundGoalDetailsPage extends GetView<SavingsPlannerController> {
  const EmergencyFundGoalDetailsPage({super.key, required this.goal});
  final GoalsTableData goal;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final seletectedDetailsTabIndex = 0.obs;

    return Scaffold(
      body: Column(
        children: [
          AppDetailsHeader(
            title: 'Emergency Fund',
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
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        gradient: AppGradient.gradientA(colorScheme),
                        border: Border.all(
                          color: colorScheme.appBorder,
                          width: 0.8,
                        ),

                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Pre-Set Goal',
                        style: AppTextStyle.titleS.copyWith(
                          color: colorScheme.appInversedtext,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

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
                      actions: const ['Funding History', 'FAQs'],
                    ),
                    Obx(() {
                      return switch (seletectedDetailsTabIndex.value) {
                        1 => EmergencyFundFAQs(
                          goal: goal,
                          currentAmount: currentAmount,
                        ),
                        0 => _FundingHistorySection(goalId: goal.id),
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

class _FundingHistorySection extends StatelessWidget {
  const _FundingHistorySection({required this.goalId});

  final int goalId;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Padding(
      padding: const EdgeInsets.all(32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            PhosphorIconsRegular.clockCounterClockwise,
            size: 48,
            color: colorScheme.appTextMuted,
          ),
          const SizedBox(height: 16),
          Text(
            'No Funding History Yet',
            style: AppTextStyle.titleL,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            'Your contributions toward this goal will appear here.',
            style: AppTextStyle.bodyM.copyWith(color: colorScheme.appTextMuted),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
