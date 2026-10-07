import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';

class RetirementFundReservationController extends GetxController {
  final accounts = <AccountsTableData>[].obs;

  final reservedAmounts = <int, double>{}.obs;
  final allocableAmounts = <int, double>{}.obs;

  int? retirementGoalId;

  @override
  void onInit() {
    super.onInit();

    _initialize();
  }

  Future<void> _initialize() async {
    await _loadRetirementGoal();
    _watchAccounts();
  }

  Future<void> _loadRetirementGoal() async {
    final goal = await database.goalsDao.getGoalByType(GoalType.retirement);

    retirementGoalId = goal?.id;
  }

  Future<void> _loadReservations(List<AccountsTableData> items) async {
    final goalId = retirementGoalId;

    for (final account in items) {
      final reservations = await database.goalReservationsDao
          .getReservationsForAccount(account.id);

      double reservedForRetirement = 0;
      double reservedForOtherGoals = 0;

      for (final reservation in reservations) {
        if (goalId != null && reservation.goalId == goalId) {
          reservedForRetirement += reservation.amount;
        } else {
          reservedForOtherGoals += reservation.amount;
        }
      }

      reservedAmounts[account.id] = reservedForRetirement;

      allocableAmounts[account.id] =
          (account.currentValue - reservedForOtherGoals).clamp(
            0.0,
            double.infinity,
          );
    }

    reservedAmounts.refresh();
    allocableAmounts.refresh();
  }

  void _watchAccounts() {
    database.accountsDao.watchCashAndBankAccounts().listen((items) async {
      await _loadReservations(items);

      final allocableAccounts = items
          .where((account) => (allocableAmounts[account.id] ?? 0) > 0)
          .toList();

      accounts.assignAll(allocableAccounts);
    });
  }

  void updateReservation(int accountId, double amount) {
    final allocableAmount = allocableAmounts[accountId] ?? 0;

    if (amount < 0) return;

    if (amount > allocableAmount) {
      Get.snackbar(
        'You can reserve up to ${allocableAmount.toCurrency()}.',
        '${amount.toCurrency()} is higher than the available amount.',
      );

      return;
    }

    reservedAmounts[accountId] = amount;
    reservedAmounts.refresh();
  }

  double get totalReserved {
    return reservedAmounts.values.fold(0.0, (sum, amount) => sum + amount);
  }
}
