import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/controller/savings_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/emergency_fund_details/emergency_fund_details_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/views/sheet/goal_setting_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/views/filled_view/widgets/goal_target_card.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_emergency_fund_extension.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class GoalsSlide extends GetView<SavingsPlannerController> {
  const GoalsSlide({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final hasGoals = true;
    return Column(
      spacing: 12,
      children: [
        if (hasGoals) ...[
          Obx(() {
            final totalTarget = controller.goals.fold<double>(
              0.0,
              (sum, goal) => sum + goal.targetAmount,
            );

            return AppSection(
              child: AppSectionBody(
                padding: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Goals Summary', style: AppTextStyle.titleL),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          totalTarget.toCurrency(),
                          style: AppTextStyle.amountXL,
                        ),
                        Text(
                          'Total target amount',
                          style: AppTextStyle.titleS.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),

          AppSection(
            sectionTitle: 'Goals',
            trailingType: SectionTrailingType.custom,
            trailingWidget: Row(
              children: [
                AdaptivePressable(
                  onTap: () {
                    Get.bottomSheet(
                      GoalSettingSheet(),
                      isScrollControlled: true,
                    );
                  },
                  child: SizedBox(
                    width: 44,
                    height: 44,
                    child: Icon(PhosphorIconsRegular.plus, size: 20),
                  ),
                ),
              ],
            ),
            child: Column(
              spacing: 12,
              children: [
                Obx(() {
                  final goal = controller.emergencyFundGoal.value;

                  if (goal == null) {
                    return const SizedBox.shrink();
                  }

                  return StreamBuilder<List<GoalReservationsTableData>>(
                    stream: database.goalReservationsDao
                        .watchReservationsForGoal(goal.id),
                    builder: (context, snapshot) {
                      final reservations = snapshot.data ?? [];

                      final current = reservations.fold<double>(
                        0.0,
                        (sum, reservation) => sum + reservation.amount,
                      );

                      return GoalTargetCard(
                        goal: GoalDetails(
                          type: GoalType.emergencyFund,
                          target: goal.targetAmount,
                          current: current,
                          dueDate: goal.dueDate,
                          onTap: () {
                            Get.to(EmergencyFundGoalDetailsPage(goal: goal));
                          },
                        ),
                      );
                    },
                  );
                }),

                // GoalTargetCard(
                //   goalType: GoalType.retirement,
                //   targetAmount: 3312105.84,
                // ),

                // GoalTargetCard(
                //   goalIcon: PhosphorIconsRegular.houseLine,
                //   goalName: 'My House',
                //   targetAmount: 3312105.84,
                // ),
                // GoalTargetCard(
                //   goalType: GoalType.education,
                //   // goalIcon: PhosphorIconsRegular.houseLine,
                //   goalName: "Eci's Education Plan",
                //   targetAmount: 3312105.84,
                // ),
              ],
            ),
          ),
        ] else ...[
          _BuildFirstGoal(),
        ],
      ],
    );
  }
}

class _BuildFirstGoal extends StatelessWidget {
  const _BuildFirstGoal();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            PhosphorIconsRegular.target,
            size: 60,
            color: colorScheme.appAccent,
          ),

          const SizedBox(height: 8),

          Text(
            'You have no goals set yet',
            style: AppTextStyle.headlineM,
            textAlign: TextAlign.center,
          ),

          Text(
            'Give your money a purpose',
            style: AppTextStyle.headlineS,
            textAlign: TextAlign.center,
          ),

          Text(
            'Create goals to give your savings and investments a clear direction.',
            style: AppTextStyle.bodyM.copyWith(color: colorScheme.appTextMuted),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          AppButton(
            type: ButtonType.outline,
            text: 'Set Financial Goals',
            onTap: () {
              Get.bottomSheet(GoalSettingSheet(), isScrollControlled: true);
              // Open GoalSetupSheet
            },
          ),
        ],
      ),
    );
  }
}
