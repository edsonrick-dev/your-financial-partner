import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/emergency_fund_allocation_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';

class EmergencyFundController extends GetxController {
  final seletectedDetailsTabIndex = 0.obs;
  Future<void> commitEmergencyFund({
    required double targetAmount,
    required double monthlyContribution,
  }) async {
    debugPrint('');
    debugPrint('========== SAVE EMERGENCY FUND ==========');
    debugPrint('Target amount: $targetAmount');

    final goalReservationController = Get.find<GoalReservationController>();

    debugPrint('Allocations: ${goalReservationController.allocatedAmounts}');

    final goal = await database.goalsDao.getOrCreateGoal(
      GoalType.emergencyFund,
    );

    debugPrint('Goal ID: ${goal.id}');
    debugPrint('Goal type: ${goal.type}');
    debugPrint('Old target: ${goal.targetAmount}');

    await database.goalsDao.updateGoal(
      goal.copyWith(
        targetAmount: targetAmount,
        monthlyContribution: monthlyContribution,
      ),
    );

    debugPrint('Goal target updated: $targetAmount');

    for (final entry in goalReservationController.allocatedAmounts.entries) {
      debugPrint(
        'Saving reservation: '
        'accountId=${entry.key}, '
        'goalId=${goal.id}, '
        'amount=${entry.value}',
      );

      if (entry.value <= 0) continue;

      await database.goalReservationsDao.upsertReservation(
        accountId: entry.key,
        goalId: goal.id,
        amount: entry.value,
      );

      debugPrint('Reservation saved.');
    }

    final savedGoal = await database.goalsDao.getGoalById(goal.id);

    final savedReservations = await database.goalReservationsDao
        .getReservationsForGoal(goal.id);

    debugPrint('');
    debugPrint('========== SAVED RESULT ==========');
    debugPrint(
      'Goal: '
      'id=${savedGoal?.id}, '
      'type=${savedGoal?.type}, '
      'target=${savedGoal?.targetAmount}',
    );

    for (final reservation in savedReservations) {
      debugPrint(
        'Reservation: '
        'id=${reservation.id}, '
        'accountId=${reservation.accountId}, '
        'goalId=${reservation.goalId}, '
        'amount=${reservation.amount}',
      );
    }

    final total = await database.goalReservationsDao.getTotalReservedForGoal(
      goal.id,
    );

    debugPrint('Total reserved: $total');
    debugPrint('=================================');
  }
}
