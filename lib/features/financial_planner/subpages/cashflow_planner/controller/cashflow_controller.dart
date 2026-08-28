import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/database/daos/cashflow_plan_dao/cashflow_plan_dao.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/app_day.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/home/views/section_views/budget_progress_section.dart';
import 'package:getx_drift_app/features/home/widgets/budget_tile.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:drift/drift.dart' as d;
import 'dart:math' as math;

class CashflowController extends GetxController {
  final currentMonthBudgetItems = <CurrentMonthBudgetItem>[].obs;
  final Rx<DisplayMode> budgetDisplayMode = DisplayMode.grid.obs;
  final RxBool isBudgetExpanded = false.obs;

  void setBudgetDisplayMode(DisplayMode mode) {
    budgetDisplayMode.value = mode;
    isBudgetExpanded.value = false;
  }

  void toggleBudgetExpanded() {
    isBudgetExpanded.toggle();
  }

  // @override
  // void onInit() {
  //   super.onInit();

  //
  // }
  @override
  void onInit() {
    super.onInit();

    _cashflowPlansSubscription = cashflowPlanDao
        .watchAllPlansWithDetails()
        .listen((plans) async {
          var income = 0.0;
          var expense = 0.0;
          var debtRepayment = 0.0;

          for (final savedPlan in plans) {
            final annual = calculateSavedPlanAnnualAmount(
              plan: savedPlan.plan,
              allocations: savedPlan.allocations,
            );

            switch (savedPlan.plan.planType) {
              case 'income':
                income += annual;
                break;

              case 'expense':
                expense += annual;
                break;

              case 'debtRepayment':
                debtRepayment += annual;
                break;
            }
          }
          plannedAnnualIncome.value = income;
          annualExpense.value = expense;
          annualDebtRepayment.value = debtRepayment;
          annualBudget.value = expense + debtRepayment;
          await _refreshMonthlyCashflow();
        });
    _watchCurrentMonthBudgetItems();
  }

  late final StreamSubscription _budgetSubscription;

  void _watchCurrentMonthBudgetItems() {
    _budgetSubscription = cashflowPlanDao.watchAllPlansWithDetails().listen((
      plans,
    ) async {
      currentMonthBudgetItems.assignAll(
        await _buildCurrentMonthBudgetItems(plans),
      );
    });
  }

  Future<List<CurrentMonthBudgetItem>> _buildCurrentMonthBudgetItems(
    List<CashflowPlanWithCategory> plans,
  ) async {
    final now = DateTime.now();
    final monthIndex = now.month - 1;
    final year = now.year;

    final spentByCategory = await database.transactionsDao
        .watchCurrentMonthExpensesByCategory(month: now)
        .first;

    final result = <CurrentMonthBudgetItem>[];

    for (final savedPlan in plans) {
      final plan = savedPlan.plan;

      if (plan.planType != 'expense') {
        continue;
      }

      final allocations = await cashflowPlanDao.getAllocationsForPlan(plan.id);

      final period = BudgetPeriod.values.firstWhere(
        (period) => period.name == plan.period,
      );

      final isCustom =
          plan.distributionType == CashFlowDistribution.custom.name;

      final amount = calculateSavedPlanBaseAmount(
        plan: plan,
        allocations: allocations,
      );

      final customSummary = isCustom
          ? buildSavedPlanCustomSummary(
              period: period,
              allocations: allocations,
            )
          : null;

      final monthly = calculateSavedPlanMonthlyDistribution(
        plan: plan,
        allocations: allocations,
        year: year,
      );

      final budget = monthly[monthIndex];

      if (budget <= 0) {
        continue;
      }

      result.add(
        CurrentMonthBudgetItem(
          plan: SavedCashflowPlanData(
            planId: plan.id,
            categoryId: plan.categoryId!,
            category: savedPlan.category.name,
            amount: amount,
            budgetPeriod: period,
            iconKey: savedPlan.category.icon,
            isCustom: isCustom,
            customSummary: customSummary,
            planType: plan.planType,
          ),
          categoryId: plan.categoryId!,
          budget: budget,
          spent: spentByCategory[plan.categoryId] ?? 0,
        ),
      );
    }

    return result;
  }

  // Stream<List<CurrentMonthBudgetItem>> watchCurrentMonthBudgetItems() {
  //   final now = DateTime.now();
  //   final monthIndex = now.month - 1;
  //   final year = now.year;
  //   return database.transactionsDao
  //       .watchCurrentMonthExpensesByCategory(month: now)
  //       .map((spentByCategory) {
  //         debugPrint('BUDGET STREAM UPDATED: $spentByCategory');

  //         return spentByCategory;
  //       })
  //       .asyncMap((spentByCategory) async {
  //         // Get the latest saved plans with their category details.
  //         final savedPlans = await cashflowPlanDao
  //             .watchAllPlansWithDetails()
  //             .first;

  //         final result = <CurrentMonthBudgetItem>[];

  //         for (final savedPlan in savedPlans) {
  //           final plan = savedPlan.plan;

  //           // Only expense budgets belong here.
  //           if (plan.planType != 'expense') {
  //             continue;
  //           }

  //           final allocations = await cashflowPlanDao.getAllocationsForPlan(
  //             plan.id,
  //           );

  //           final period = BudgetPeriod.values.firstWhere(
  //             (period) => period.name == plan.period,
  //           );

  //           final isCustom =
  //               plan.distributionType == CashFlowDistribution.custom.name;

  //           final amount = calculateSavedPlanBaseAmount(
  //             plan: plan,
  //             allocations: allocations,
  //           );

  //           final customSummary = isCustom
  //               ? buildSavedPlanCustomSummary(
  //                   period: period,
  //                   allocations: allocations,
  //                 )
  //               : null;

  //           final savedPlanData = SavedCashflowPlanData(
  //             planId: plan.id,
  //             categoryId: plan.categoryId!,
  //             category: savedPlan.category.name,
  //             amount: amount,
  //             budgetPeriod: period,
  //             iconKey: savedPlan.category.icon,
  //             isCustom: isCustom,
  //             customSummary: customSummary,
  //             planType: plan.planType,
  //           );

  //           final monthly = calculateSavedPlanMonthlyDistribution(
  //             plan: plan,
  //             allocations: allocations,
  //             year: year,
  //           );

  //           final budget = monthly[monthIndex];

  //           if (budget <= 0) {
  //             continue;
  //           }

  //           final spent = spentByCategory[plan.categoryId] ?? 0;

  //           result.add(
  //             CurrentMonthBudgetItem(
  //               plan: savedPlanData,
  //               categoryId: plan.categoryId!,
  //               budget: budget,
  //               spent: spent,
  //             ),
  //           );
  //         }

  //         return result;
  //       });
  // }
  Stream<List<CurrentMonthBudgetItem>> watchCurrentMonthBudgetItems() {
    final now = DateTime.now();
    final monthIndex = now.month - 1;
    final year = now.year;

    return cashflowPlanDao.watchAllPlansWithDetails().asyncExpand((savedPlans) {
      return database.transactionsDao
          .watchCurrentMonthExpensesByCategory(month: now)
          .asyncMap((spentByCategory) async {
            debugPrint(
              'BUDGET STREAM UPDATED: '
              'plans=${savedPlans.length}, '
              'spent=$spentByCategory',
            );

            final result = <CurrentMonthBudgetItem>[];

            for (final savedPlan in savedPlans) {
              final plan = savedPlan.plan;

              // Only expense budgets belong here.
              if (plan.planType != 'expense') {
                continue;
              }

              final allocations = await cashflowPlanDao.getAllocationsForPlan(
                plan.id,
              );

              final period = BudgetPeriod.values.firstWhere(
                (period) => period.name == plan.period,
              );

              final isCustom =
                  plan.distributionType == CashFlowDistribution.custom.name;

              final amount = calculateSavedPlanBaseAmount(
                plan: plan,
                allocations: allocations,
              );

              final customSummary = isCustom
                  ? buildSavedPlanCustomSummary(
                      period: period,
                      allocations: allocations,
                    )
                  : null;

              final savedPlanData = SavedCashflowPlanData(
                planId: plan.id,
                categoryId: plan.categoryId!,
                category: savedPlan.category.name,
                amount: amount,
                budgetPeriod: period,
                iconKey: savedPlan.category.icon,
                isCustom: isCustom,
                customSummary: customSummary,
                planType: plan.planType,
              );

              final monthly = calculateSavedPlanMonthlyDistribution(
                plan: plan,
                allocations: allocations,
                year: year,
              );

              final budget = monthly[monthIndex];

              if (budget <= 0) {
                continue;
              }

              final spent = spentByCategory[plan.categoryId] ?? 0;

              result.add(
                CurrentMonthBudgetItem(
                  plan: savedPlanData,
                  categoryId: plan.categoryId!,
                  budget: budget,
                  spent: spent,
                ),
              );
            }

            return result;
          });
    });
  }

  Future<List<CurrentMonthBudgetItem>> getCurrentMonthBudgetItems() async {
    final plans = await cashflowPlanDao.watchAllPlansWithDetails().first;

    final currentMonthIndex = DateTime.now().month - 1;
    final year = DateTime.now().year;

    final result = <CurrentMonthBudgetItem>[];

    for (final savedPlan in plans) {
      final plan = savedPlan.plan;

      if (plan.planType != 'expense') {
        continue;
      }

      final monthly = calculateSavedPlanMonthlyDistribution(
        plan: plan,
        allocations: savedPlan.allocations,
        year: year,
      );

      final budget = monthly[currentMonthIndex];

      if (budget <= 0) {
        continue;
      }

      final spent = await database.transactionsDao.getMonthlyExpenseForCategory(
        categoryId: plan.categoryId!,
        month: DateTime.now(),
      );

      final period = BudgetPeriod.values.firstWhere(
        (period) => period.name == plan.period,
      );

      final isCustom =
          plan.distributionType == CashFlowDistribution.custom.name;

      result.add(
        CurrentMonthBudgetItem(
          plan: SavedCashflowPlanData(
            planId: plan.id,
            categoryId: plan.categoryId!,
            category: savedPlan.category.name,
            amount: budget,
            budgetPeriod: period,
            iconKey: savedPlan.category.icon,
            isCustom: isCustom,
            customSummary: isCustom
                ? buildSavedPlanCustomSummary(
                    period: period,
                    allocations: savedPlan.allocations,
                  )
                : null,
            planType: plan.planType,
          ),
          categoryId: plan.categoryId!, // <-- ADD THIS
          budget: budget,
          spent: spent,
        ),
      );
    }

    return result;
  }

  Future<double> getCurrentMonthExpenseForCategory(int categoryId) {
    return database.transactionsDao.getMonthlyExpenseForCategory(
      categoryId: categoryId,
      month: DateTime.now(),
    );
  }

  double getCurrentMonthBudgetAmount(SavedCashflowPlanData plan) {
    return plan.budgetPeriod.toMonthly(plan.amount);
  }

  Stream<double> watchCurrentMonthBudget() {
    return watchSavedBudgetPlans().map(
      (plans) => plans.fold<double>(
        0,
        (total, plan) => total + getCurrentMonthBudgetAmount(plan),
      ),
    );
  }

  double get annualCashflowDifference {
    return plannedAnnualIncome.value - annualBudget.value;
  }

  bool get hasAnnualSurplus {
    return annualCashflowDifference >= 0;
  }

  final RxList<double> monthlyIncome = List<double>.filled(12, 0).obs;
  final RxList<double> monthlyExpense = List<double>.filled(12, 0).obs;
  final RxList<double> monthlyDebtRepayment = List<double>.filled(12, 0).obs;

  List<double> get monthlyBudget => List.generate(
    12,
    (index) => monthlyExpense[index] + monthlyDebtRepayment[index],
  );

  List<double> get monthlyNetCashflow =>
      List.generate(12, (index) => monthlyIncome[index] - monthlyBudget[index]);
  Future<void> _refreshMonthlyCashflow() async {
    final year = DateTime.now().year;
    final plans = await cashflowPlanDao.getAllPlans();

    final income = List<double>.filled(12, 0);
    final expense = List<double>.filled(12, 0);
    final debt = List<double>.filled(12, 0);

    for (final plan in plans) {
      final allocations = await cashflowPlanDao.getAllocationsForPlan(plan.id);

      final monthly = calculateSavedPlanMonthlyDistribution(
        plan: plan,
        allocations: allocations,
        year: year,
      );

      switch (plan.planType) {
        case 'income':
          for (var i = 0; i < 12; i++) {
            income[i] += monthly[i];
          }
          break;

        case 'expense':
          for (var i = 0; i < 12; i++) {
            expense[i] += monthly[i];
          }
          break;

        case 'debtRepayment':
          for (var i = 0; i < 12; i++) {
            debt[i] += monthly[i];
          }
          break;
      }
    }

    monthlyIncome.assignAll(income);
    monthlyExpense.assignAll(expense);
    monthlyDebtRepayment.assignAll(debt);
  }

  double get annualIncomeRatio {
    final income = plannedAnnualIncome.value;
    final budget = annualBudget.value;
    final scale = math.max(income, budget);

    return scale == 0 ? 0 : income / scale;
  }

  double get annualBudgetRatio {
    final income = plannedAnnualIncome.value;
    final budget = annualBudget.value;
    final scale = math.max(income, budget);

    return scale == 0 ? 0 : budget / scale;
  }

  double get annualExpenseRatio {
    final income = plannedAnnualIncome.value;
    final budget = annualBudget.value;
    final scale = math.max(income, budget);

    return scale == 0 ? 0 : annualExpense.value / scale;
  }

  double get annualDebtRepaymentRatio {
    final income = plannedAnnualIncome.value;
    final budget = annualBudget.value;
    final scale = math.max(income, budget);

    return scale == 0 ? 0 : annualDebtRepayment.value / scale;
  }

  double get annualBudgetDifference {
    return plannedAnnualIncome.value - annualBudget.value;
  }

  double get annualBudgetDifferenceRatio {
    final income = plannedAnnualIncome.value;
    final budget = annualBudget.value;
    final scale = math.max(income, budget);

    return scale == 0 ? 0 : annualBudgetDifference.abs() / scale;
  }

  Stream<List<SavedCashflowPlanData>> watchSavedBudgetPlans() {
    return cashflowPlanDao.watchAllPlansWithDetails().map((plans) {
      debugPrint('========== SAVED BUDGET PLANS ==========');

      for (final savedPlan in plans) {
        debugPrint(
          'PLAN ${savedPlan.plan.id} | '
          'category=${savedPlan.category.name} | '
          'planType=${savedPlan.plan.planType} | '
          'amount=${savedPlan.plan.amount}',
        );
      }

      debugPrint('========================================');
      return plans
          .where((savedPlan) => savedPlan.plan.planType != 'income')
          .map((savedPlan) {
            final period = BudgetPeriod.values.firstWhere(
              (period) => period.name == savedPlan.plan.period,
            );

            final isCustom =
                savedPlan.plan.distributionType ==
                CashFlowDistribution.custom.name;

            final amount = calculateSavedPlanBaseAmount(
              plan: savedPlan.plan,
              allocations: savedPlan.allocations,
            );

            final customSummary = isCustom
                ? buildSavedPlanCustomSummary(
                    period: period,
                    allocations: savedPlan.allocations,
                  )
                : null;

            return SavedCashflowPlanData(
              planId: savedPlan.plan.id,
              category: savedPlan.category.name,
              amount: amount,
              budgetPeriod: period,
              iconKey: savedPlan.category.icon,
              isCustom: isCustom,
              categoryId: savedPlan.category.id,
              customSummary: customSummary,
              planType: savedPlan.plan.planType,
            );
          })
          .toList();
    });
  }

  final RxDouble plannedAnnualIncome = 0.0.obs;
  final RxDouble annualBudget = 0.0.obs;
  final RxDouble annualExpense = 0.0.obs;
  final RxDouble annualDebtRepayment = 0.0.obs;
  late final StreamSubscription<List<CashflowPlanWithCategory>>
  _cashflowPlansSubscription;
  String planTypeFromTransactionType(TransactionType transactionType) {
    switch (transactionType) {
      case TransactionType.earn:
        return 'income';

      case TransactionType.spend:
        return 'expense';

      default:
        return 'debtRepayment';
    }
  }

  double calculateSavedPlanAnnualAmount({
    required CashFlowPlan plan,
    required List<CashFlowPlanAllocation> allocations,
  }) {
    final period = BudgetPeriod.values.firstWhere(
      (period) => period.name == plan.period,
    );

    final amount = calculateSavedPlanBaseAmount(
      plan: plan,
      allocations: allocations,
    );

    return period.toAnnual(amount);
  }

  Future<double> calculateRecurringAnnualBudget() async {
    final plans = await cashflowPlanDao.getAllPlans();

    final budgetPlans = plans.where(
      (plan) => plan.planType == 'expense' || plan.planType == 'debtRepayment',
    );

    final year = DateTime.now().year;

    var total = 0.0;

    for (final plan in budgetPlans) {
      final allocations = await cashflowPlanDao.getAllocationsForPlan(plan.id);

      final monthly = calculateSavedPlanRecurringMonthlyDistribution(
        plan: plan,
        allocations: allocations,
        year: year,
      );

      total += monthly.fold<double>(0, (sum, amount) => sum + amount);
    }

    return total;
  }

  // double _calculatePlannedAnnualIncome(List<CashflowPlanWithCategory> plans) {
  //   final year = DateTime.now().year;

  //   var total = 0.0;

  //   for (final savedPlan in plans) {
  //     final monthly = calculateSavedPlanRecurringMonthlyDistribution(
  //       plan: savedPlan.plan,
  //       allocations: savedPlan.allocations,
  //       year: year,
  //     );

  //     total += monthly.fold<double>(0, (sum, value) => sum + value);
  //   }

  //   return total;
  // }

  double calculateSavedPlanBaseAmount({
    required CashFlowPlan plan,
    required List<CashFlowPlanAllocation> allocations,
  }) {
    if (plan.amount != 0) {
      return plan.amount;
    }

    final period = BudgetPeriod.values.firstWhere(
      (period) => period.name == plan.period,
    );

    if (period.customPatternLength == 0) {
      return 0;
    }

    final patternTotal = allocations.fold<double>(
      0,
      (total, allocation) => total + allocation.amount,
    );

    return patternTotal / period.customPatternLength;
  }

  // String? buildSavedPlanCustomSummary({
  //   required BudgetPeriod period,
  //   required List<CashFlowPlanAllocation> allocations,
  // }) {
  //   if (allocations.isEmpty) {
  //     return null;
  //   }

  //   String format(double amount) {
  //     return amount.toCurrency();
  //   }

  //   switch (period) {
  //     case BudgetPeriod.weekly:
  //       final visible = allocations
  //           .where((allocation) => allocation.amount > 0)
  //           .take(3)
  //           .map((allocation) {
  //             final day = AppDay.values[allocation.allocationIndex];

  //             return '${day.shortName} ${format(allocation.amount)}';
  //           })
  //           .toList();

  //       final nonZeroCount = allocations
  //           .where((allocation) => allocation.amount > 0)
  //           .length;

  //       final remaining = nonZeroCount - visible.length;

  //       if (visible.isEmpty) {
  //         return 'No allocated days';
  //       }

  //       return remaining > 0
  //           ? '${visible.join(' • ')} • +$remaining more'
  //           : visible.join(' • ');

  //     case BudgetPeriod.fortnightly:
  //       if (allocations.length < 2) {
  //         return null;
  //       }

  //       return '1st ${format(allocations[0].amount)} • '
  //           '2nd ${format(allocations[1].amount)}';

  //     case BudgetPeriod.monthly:
  //       if (allocations.length < 2) {
  //         return null;
  //       }

  //       return '1st ${format(allocations[0].amount)} • '
  //           '2nd ${format(allocations[1].amount)}';

  //     case BudgetPeriod.yearly:
  //       final visible = allocations
  //           .where((allocation) => allocation.amount > 0)
  //           .take(3)
  //           .map((allocation) {
  //             final month = AppMonth.values[allocation.allocationIndex];

  //             return '${month.shortName} ${format(allocation.amount)}';
  //           })
  //           .toList();

  //       final nonZeroCount = allocations
  //           .where((allocation) => allocation.amount > 0)
  //           .length;

  //       final remaining = nonZeroCount - visible.length;

  //       if (visible.isEmpty) {
  //         return 'No allocated months';
  //       }

  //       return remaining > 0
  //           ? '${visible.join(' • ')} • +$remaining more'
  //           : visible.join(' • ');
  //   }
  // }
  String? buildSavedPlanCustomSummary({
    required BudgetPeriod period,
    required List<CashFlowPlanAllocation> allocations,
  }) {
    if (allocations.isEmpty) {
      return null;
    }

    switch (period) {
      case BudgetPeriod.weekly:
        return allocations
            .where((allocation) => allocation.amount > 0)
            .map((allocation) {
              final day = AppDay.values[allocation.allocationIndex];
              return '${day.shortName} ${allocation.amount.toCurrency()}';
            })
            .join(' • ');

      case BudgetPeriod.fortnightly:
        if (allocations.length < 2) return null;

        return '1st ${allocations[0].amount.toCurrency()} • '
            '2nd ${allocations[1].amount.toCurrency()}';

      case BudgetPeriod.monthly:
        if (allocations.length < 2) return null;

        return '1st ${allocations[0].amount.toCurrency()} • '
            '2nd ${allocations[1].amount.toCurrency()}';

      case BudgetPeriod.yearly:
        final nonZero = allocations
            .where((allocation) => allocation.amount > 0)
            .length;

        return '$nonZero monthly allocations';
    }
  }

  Stream<List<SavedCashflowPlanData>> watchSavedCashflowPlans({
    required TransactionType transactionType,
  }) {
    final targetPlanType = planTypeFromTransactionType(transactionType);

    return cashflowPlanDao.watchAllPlansWithDetails().map((plans) {
      final filteredPlans = plans.where(
        (savedPlan) => savedPlan.plan.planType == targetPlanType,
      );

      return filteredPlans.map((savedPlan) {
        final period = BudgetPeriod.values.firstWhere(
          (period) => period.name == savedPlan.plan.period,
        );

        final isCustom =
            savedPlan.plan.distributionType == CashFlowDistribution.custom.name;

        final amount = calculateSavedPlanBaseAmount(
          plan: savedPlan.plan,
          allocations: savedPlan.allocations,
        );

        final customSummary = isCustom
            ? buildSavedPlanCustomSummary(
                period: period,
                allocations: savedPlan.allocations,
              )
            : null;

        return SavedCashflowPlanData(
          planId: savedPlan.plan.id,
          category: savedPlan.category.name,
          amount: amount,
          budgetPeriod: period,
          iconKey: savedPlan.category.icon,
          isCustom: isCustom,
          customSummary: customSummary,
          categoryId: savedPlan.category.id,
          planType: savedPlan.plan.planType,
        );
      }).toList();
    });
  }
  //   CashflowController
  // │
  // ├── Saved Plan Persistence
  // │   ├── saveIncomePlan()
  // │   └── debugSavedPlanDistributions()
  // │
  // ├── Saved Plan Calculations
  // │   ├── calculateSavedPlanMonthlyDistribution()
  // │   ├── calculateSavedPlanRecurringMonthlyDistribution()
  // │   ├── calculateCurrentMonthlyDistribution()
  // │   └── calculateRecurringMonthlyDistribution()
  // │
  // ├── Current Plan Builder
  // │   ├── selectedPeriod
  // │   ├── amount
  // │   ├── occurrenceDate
  // │   ├── selectedDistribution
  // │   └── distributionAmounts
  // │
  // ├── Current Plan Calculations
  // │   ├── distributionTotal
  // │   ├── plannedPeriodAmount
  // │   ├── annualizedAmount
  // │   └── monthlyPlannedDistribution
  // │
  // └── Temporary Financial Stability Values
  //     ├── annualExpense
  //     ├── annualDebtRepayment
  //     ├── annualSavings
  //     └── related percentages

  // =======================================================================
  //
  // Saved Plan Persistence
  //
  // =======================================================================
  Future<void> deleteSavedPlan(int planId) async {
    await cashflowPlanDao.deletePlan(planId);
  }

  Future<void> saveCashflowPlan({
    required TransactionType transactionType,
  }) async {
    final category = transactionController.selectedCategory.value;
    final period = selectedPeriod.value;

    if (category == null || period == null) {
      return;
    }

    final isCustom = selectedDistribution.value == CashFlowDistribution.custom;

    if (!isCustom && amount.value <= 0) {
      return;
    }

    if (isCustom && distributionTotal <= 0) {
      return;
    }

    final now = DateTime.now();

    final planType = planTypeFromTransactionType(transactionType);

    final planId = await cashflowPlanDao.insertPlan(
      CashFlowPlansCompanion.insert(
        categoryId: d.Value<int?>(category.id),
        loanId: const d.Value<int?>(null),
        planType: planType,
        amount: isCustom ? 0 : amount.value,
        period: period.name,
        distributionType: selectedDistribution.value.name,
        startDate: occurrenceDate.value,
        endDate: const d.Value<DateTime?>(null),
        createdAt: now,
        updatedAt: now,
      ),
    );

    if (isCustom) {
      final allocations = List.generate(
        distributionAmounts.length,
        (index) => CashFlowPlanAllocationsCompanion.insert(
          planId: planId,
          allocationIndex: index,
          amount: distributionAmounts[index].value,
        ),
      );

      await cashflowPlanDao.insertAllocations(allocations);
      final savedAllocations = await cashflowPlanDao.getAllocationsForPlan(
        planId,
      );

      for (final allocation in savedAllocations) {
        debugPrint('ALLOC ${allocation.allocationIndex}: ${allocation.amount}');
      }
    }
    debugPrint('SAVED PLAN ID: $planId');

    final savedPlans = await cashflowPlanDao.getAllPlans();

    for (final plan in savedPlans) {
      debugPrint(
        'PLAN ${plan.id}: '
        '${plan.period} / '
        '${plan.distributionType} / '
        '${plan.amount}',
      );
    }
    await debugSavedPlanDistributions();
    Get.back();
  }

  Future<void> debugSavedPlanDistributions() async {
    final plans = await cashflowPlanDao.getAllPlans();
    final year = DateTime.now().year;

    debugPrint('');
    debugPrint('========== SAVED PLAN DISTRIBUTIONS ==========');
    debugPrint('YEAR: $year');
    debugPrint('');

    for (final plan in plans) {
      final allocations = await cashflowPlanDao.getAllocationsForPlan(plan.id);

      final monthly = calculateSavedPlanMonthlyDistribution(
        plan: plan,
        allocations: allocations,
        year: year,
      );

      debugPrint('PLAN ${plan.id}');
      debugPrint('  Period: ${plan.period}');
      debugPrint('  Distribution: ${plan.distributionType}');
      debugPrint('  Amount: ${plan.amount}');
      debugPrint('  Start date: ${plan.startDate}');
      debugPrint('  Allocations:');

      for (final allocation in allocations) {
        debugPrint('    ${allocation.allocationIndex}: ${allocation.amount}');
      }

      debugPrint('  MONTHLY:');

      for (var i = 0; i < monthly.length; i++) {
        debugPrint('    ${AppMonth.values[i].fullName}: ${monthly[i]}');
      }

      debugPrint(
        '  ANNUAL TOTAL: '
        '${monthly.fold<double>(0, (sum, value) => sum + value)}',
      );

      debugPrint('');
    }

    debugPrint('==============================================');
  }

  // =======================================================================
  //
  // Saved Plan Calculations
  //
  // =======================================================================

  List<double> calculateSavedPlanMonthlyDistribution({
    required CashFlowPlan plan,
    required List<CashFlowPlanAllocation> allocations,
    required int year,
  }) {
    final monthlyDistribution = List<double>.filled(12, 0);
    debugPrint('');
    debugPrint('========== PLAN DISTRIBUTION DEBUG ==========');
    debugPrint('Period: ${plan.period}');
    debugPrint('Distribution: ${plan.distributionType}');
    debugPrint('Amount: ${plan.amount}');
    debugPrint('Start date: ${plan.startDate}');
    debugPrint('Year: $year');
    debugPrint('=============================================');
    switch (plan.period) {
      // -------------------------------------------------------------------------
      // Weekly
      // -------------------------------------------------------------------------
      //
      // allocationIndex:
      // 0 = Monday
      // 1 = Tuesday
      // 2 = Wednesday
      // 3 = Thursday
      // 4 = Friday
      // 5 = Saturday
      // 6 = Sunday
      //
      case 'weekly':
        debugPrint('>>> ENTERED WEEKLY CASE <<<');
        if (plan.distributionType ==
            CashFlowDistribution.defaultDistribution.name) {
          debugPrint('>>> ENTERED WEEKLY DEFAULT <<<');

          final recurringWeekday = plan.startDate.weekday;

          debugPrint('');
          debugPrint('========== WEEKLY PLAN DEBUG ==========');
          debugPrint('Plan amount: ${plan.amount}');
          debugPrint('Start date: ${plan.startDate}');
          debugPrint('Recurring weekday: $recurringWeekday');
          debugPrint('Target year: $year');
          debugPrint('');

          for (var month = 1; month <= 12; month++) {
            final daysInMonth = DateTime(year, month + 1, 0).day;

            var occurrenceCount = 0;
            final occurrenceDates = <String>[];

            for (var day = 1; day <= daysInMonth; day++) {
              final date = DateTime(year, month, day);

              if (!_isPlanActive(plan, date)) {
                continue;
              }

              if (date.weekday == recurringWeekday) {
                occurrenceCount++;

                occurrenceDates.add(
                  '${date.year}-${date.month.toString().padLeft(2, '0')}-'
                  '${date.day.toString().padLeft(2, '0')}',
                );

                monthlyDistribution[month - 1] += plan.amount;
              }
            }

            final monthlyTotal = monthlyDistribution[month - 1];

            debugPrint(
              '${AppMonth.values[month - 1].fullName}: '
              '$occurrenceCount occurrences × '
              '${plan.amount} = '
              '$monthlyTotal',
            );

            debugPrint('  Dates: $occurrenceDates');
          }

          debugPrint('');
          debugPrint('TOTAL: ${monthlyDistribution.reduce((a, b) => a + b)}');
          debugPrint('======================================');
          debugPrint('');
        } else {
          debugPrint('>>> ENTERED WEEKLY CUSTOM <<<');
          // Custom weekly distribution
          for (var month = 1; month <= 12; month++) {
            final daysInMonth = DateTime(year, month + 1, 0).day;

            for (var day = 1; day <= daysInMonth; day++) {
              final date = DateTime(year, month, day);

              if (!_isPlanActive(plan, date)) {
                continue;
              }

              final allocationIndex = date.weekday - 1;

              if (allocationIndex >= allocations.length) {
                continue;
              }

              monthlyDistribution[month - 1] +=
                  allocations[allocationIndex].amount;
            }
          }
        }
        break;
      // -------------------------------------------------------------------------
      // Fortnightly
      // -------------------------------------------------------------------------
      //
      // startDate = Cycle 1
      //
      // Cycle 1
      // +14 days → Cycle 2
      // +14 days → Cycle 1
      // +14 days → Cycle 2
      //
      case 'fortnightly':
        debugPrint('>>> ENTERED FORTNIGHTLY CASE <<<');

        final isCustom =
            plan.distributionType == CashFlowDistribution.custom.name;

        var cycleDate = plan.startDate;
        var cycleIndex = 0;

        while (cycleDate.year <= year) {
          if (plan.endDate != null && cycleDate.isAfter(plan.endDate!)) {
            break;
          }

          if (cycleDate.year == year) {
            if (isCustom) {
              if (allocations.length < 2) {
                break;
              }

              monthlyDistribution[cycleDate.month - 1] +=
                  allocations[cycleIndex].amount;
            } else {
              monthlyDistribution[cycleDate.month - 1] += plan.amount;
            }
          }

          cycleDate = cycleDate.add(const Duration(days: 14));

          if (isCustom) {
            cycleIndex = (cycleIndex + 1) % 2;
          }
        }

        break;

      // -------------------------------------------------------------------------
      // Monthly
      // -------------------------------------------------------------------------
      //
      // The plan occurs once per calendar month.
      //
      // If the start day does not exist in a particular month,
      // the occurrence is placed on the month's last day.
      //
      case 'monthly':
        debugPrint('>>> ENTERED MONTHLY CASE <<<');

        final isCustom =
            plan.distributionType == CashFlowDistribution.custom.name;

        for (var month = 1; month <= 12; month++) {
          final daysInMonth = DateTime(year, month + 1, 0).day;

          final occurrenceDay = plan.startDate.day > daysInMonth
              ? daysInMonth
              : plan.startDate.day;

          final date = DateTime(year, month, occurrenceDay);

          if (!_isPlanActive(plan, date)) {
            continue;
          }

          if (isCustom) {
            if (allocations.length < 2) {
              continue;
            }

            monthlyDistribution[month - 1] +=
                allocations[0].amount + allocations[1].amount;
          } else {
            monthlyDistribution[month - 1] += plan.amount;
          }
        }

        break;

      // -------------------------------------------------------------------------
      // Yearly
      // -------------------------------------------------------------------------
      //
      // allocationIndex:
      // 0 = January
      // ...
      // 11 = December
      //
      case 'yearly':
        debugPrint('>>> ENTERED YEARLY CASE <<<');

        final isCustom =
            plan.distributionType == CashFlowDistribution.custom.name;

        if (!isCustom) {
          final monthlyAmount = plan.amount / 12;

          for (var month = 1; month <= 12; month++) {
            monthlyDistribution[month - 1] += monthlyAmount;
          }
        } else {
          for (final allocation in allocations) {
            final monthIndex = allocation.allocationIndex;

            if (monthIndex < 0 || monthIndex >= 12) {
              continue;
            }

            monthlyDistribution[monthIndex] += allocation.amount;
          }
        }

        break;
    }

    return monthlyDistribution;
  }

  List<double> calculateSavedPlanRecurringMonthlyDistribution({
    required CashFlowPlan plan,
    required List<CashFlowPlanAllocation> allocations,
    required int year,
  }) {
    final monthlyDistribution = List<double>.filled(12, 0);

    final isCustom = plan.distributionType == CashFlowDistribution.custom.name;

    switch (plan.period) {
      // -------------------------------------------------------------------------
      // Weekly
      // -------------------------------------------------------------------------
      case 'weekly':
        final recurringWeekday = plan.startDate.weekday;

        for (var month = 1; month <= 12; month++) {
          final daysInMonth = DateTime(year, month + 1, 0).day;

          for (var day = 1; day <= daysInMonth; day++) {
            final date = DateTime(year, month, day);

            if (date.weekday != recurringWeekday) {
              continue;
            }

            if (isCustom) {
              final allocationIndex = date.weekday - 1;

              if (allocationIndex >= allocations.length) {
                continue;
              }

              monthlyDistribution[month - 1] +=
                  allocations[allocationIndex].amount;
            } else {
              monthlyDistribution[month - 1] += plan.amount;
            }
          }
        }
        break;

      // -------------------------------------------------------------------------
      // Fortnightly
      // -------------------------------------------------------------------------
      case 'fortnightly':
        if (isCustom && allocations.length < 2) {
          break;
        }

        final yearStart = DateTime(year, 1, 1);
        final yearEnd = DateTime(year, 12, 31);

        var cycleDate = plan.startDate;

        while (cycleDate.isAfter(yearEnd)) {
          cycleDate = cycleDate.subtract(const Duration(days: 14));
        }

        while (cycleDate.isBefore(yearStart)) {
          cycleDate = cycleDate.add(const Duration(days: 14));
        }

        var cycleIndex = 0;

        while (!cycleDate.isAfter(yearEnd)) {
          if (isCustom) {
            monthlyDistribution[cycleDate.month - 1] +=
                allocations[cycleIndex].amount;

            cycleIndex = (cycleIndex + 1) % 2;
          } else {
            monthlyDistribution[cycleDate.month - 1] += plan.amount;
          }

          cycleDate = cycleDate.add(const Duration(days: 14));
        }
        break;

      // -------------------------------------------------------------------------
      // Monthly
      // -------------------------------------------------------------------------
      case 'monthly':
        if (isCustom) {
          if (allocations.length < 2) {
            break;
          }

          final monthlyAmount = allocations[0].amount + allocations[1].amount;

          for (var month = 0; month < 12; month++) {
            monthlyDistribution[month] = monthlyAmount;
          }
        } else {
          for (var month = 0; month < 12; month++) {
            monthlyDistribution[month] = plan.amount;
          }
        }
        break;

      // -------------------------------------------------------------------------
      // Yearly
      // -------------------------------------------------------------------------
      case 'yearly':
        if (isCustom) {
          for (final allocation in allocations) {
            final monthIndex = allocation.allocationIndex;

            if (monthIndex < 0 || monthIndex >= 12) {
              continue;
            }

            monthlyDistribution[monthIndex] += allocation.amount;
          }
        } else {
          final monthlyAmount = plan.amount / 12;

          for (var month = 0; month < 12; month++) {
            monthlyDistribution[month] = monthlyAmount;
          }
        }
        break;
    }

    return monthlyDistribution;
  }

  Future<List<double>> calculateCurrentMonthlyDistribution({
    required TransactionType transactionType,
  }) async {
    final allPlans = await cashflowPlanDao.getAllPlans();

    final targetPlanType = planTypeFromTransactionType(transactionType);

    final plans = allPlans.where((plan) => plan.planType == targetPlanType);

    final result = List<double>.filled(12, 0);
    final year = DateTime.now().year;

    for (final plan in plans) {
      final allocations = await cashflowPlanDao.getAllocationsForPlan(plan.id);

      final monthly = calculateSavedPlanMonthlyDistribution(
        plan: plan,
        allocations: allocations,
        year: year,
      );

      for (var i = 0; i < 12; i++) {
        result[i] += monthly[i];
      }
    }

    return result;
  }

  Future<List<double>> calculateRecurringMonthlyDistribution({
    required TransactionType transactionType,
  }) async {
    final allPlans = await cashflowPlanDao.getAllPlans();

    final targetPlanType = planTypeFromTransactionType(transactionType);

    final plans = allPlans.where((plan) => plan.planType == targetPlanType);

    final result = List<double>.filled(12, 0);
    final year = DateTime.now().year;

    for (final plan in plans) {
      final allocations = await cashflowPlanDao.getAllocationsForPlan(plan.id);

      final monthly = calculateSavedPlanRecurringMonthlyDistribution(
        plan: plan,
        allocations: allocations,
        year: year,
      );

      for (var i = 0; i < 12; i++) {
        result[i] += monthly[i];
      }
    }

    return result;
  }

  // =======================================================================
  //
  // Current Plan Builder
  //
  // =======================================================================

  // =======================================================================
  //
  // Current Plan Calculations
  //
  // =======================================================================
  Future<double> calculateRecurringAnnualTotal({
    required TransactionType transactionType,
  }) async {
    final distribution = await calculateRecurringMonthlyDistribution(
      transactionType: transactionType,
    );

    return distribution.reduce((a, b) => a + b);
  }

  final CashflowPlanDao cashflowPlanDao = database.cashflowPlanDao;
  final transactionController = Get.find<TransactionController>();

  bool _isPlanActive(CashFlowPlan plan, DateTime date) {
    final startDate = DateTime(
      plan.startDate.year,
      plan.startDate.month,
      plan.startDate.day,
    );

    final currentDate = DateTime(date.year, date.month, date.day);

    if (currentDate.isBefore(startDate)) {
      return false;
    }

    if (plan.endDate != null) {
      final endDate = DateTime(
        plan.endDate!.year,
        plan.endDate!.month,
        plan.endDate!.day,
      );

      if (currentDate.isAfter(endDate)) {
        return false;
      }
    }

    return true;
  }
  // ===========================================================================
  // Lifecycle
  // ===========================================================================

  @override
  void onClose() {
    _cashflowPlansSubscription.cancel();

    disposeDistributionFields();
    _budgetSubscription.cancel();
    super.onClose();
  }
  // ===========================================================================
  // Details
  // ===========================================================================

  final seletectedDetailsTabIndex = 0.obs;

  // Temporary values used by the existing cash-flow summary UI.
  final annualPlannedIncome = 750000.obs;

  // ===========================================================================
  // Budget Period
  // ===========================================================================

  /// Currently selected budget period.
  ///
  /// A plan can repeat:
  /// - Weekly: every 7 days
  /// - Fortnightly: every 14 days
  /// - Monthly: every calendar month
  /// - Yearly: once per calendar year
  final Rxn<BudgetPeriod> selectedPeriod = Rxn<BudgetPeriod>();

  /// Changes the plan's budget period.
  ///
  /// Changing the period resets the distribution mode to Evenly and
  /// disposes any existing custom allocation fields because those fields
  /// are specific to the previous period.
  void selectPeriod(BudgetPeriod period) {
    selectedPeriod.value = period;

    selectedDistribution.value = CashFlowDistribution.defaultDistribution;

    disposeDistributionFields();
  }

  // ===========================================================================
  // Base Amount
  // ===========================================================================

  /// Amount for one occurrence of the selected budget period.
  ///
  /// Examples:
  ///
  /// Weekly:
  ///   ₱10,000 = ₱10,000 every week
  ///
  /// Fortnightly:
  ///   ₱20,000 = ₱20,000 every 14 days
  ///
  /// Monthly:
  ///   ₱40,000 = ₱40,000 every calendar month
  ///
  /// Yearly:
  ///   ₱480,000 = ₱480,000 for the calendar year
  final RxDouble amount = 0.0.obs;
  final RxList<RxDouble> distributionAmounts = <RxDouble>[].obs;
  final Rx<DateTime> occurrenceDate = DateTime.now().obs;
  // final TextEditingController amountController = TextEditingController();

  // final FocusNode amountFocusNode = FocusNode();

  /// Updates [amount] from the amount text field.
  // void amountChanged() {
  // amount.value =
  //     double.tryParse(amountController.text.replaceAll(',', '').trim()) ?? 0;
  // }

  // ===========================================================================
  // Distribution
  // ===========================================================================

  /// Determines whether the plan uses an even amount or a custom
  /// distribution within its period.
  final Rx<CashFlowDistribution> selectedDistribution =
      CashFlowDistribution.defaultDistribution.obs;

  /// Revision counter used to make GetX reactive widgets rebuild when
  /// values inside [distributionControllers] change.
  ///
  /// TextEditingController itself is not reactive, so changing its text
  /// does not automatically trigger an Obx rebuild.
  // final RxInt distributionRevision = 0.obs;

  /// Notifies reactive widgets that a custom distribution value changed.
  // void distributionChanged(String value) {
  //   distributionRevision.value++;
  // }

  // ===========================================================================
  // Distribution Totals
  // ===========================================================================

  /// Total of all custom allocation values.
  ///
  /// The meaning of this total depends on the selected period:
  ///
  /// Weekly:
  ///   Total of the 7 daily allocations = one weekly amount.
  ///
  /// Fortnightly:
  ///   Total of the 2 fortnightly allocations = one 4-week pattern.
  ///
  /// Monthly:
  ///   Total of the 2 monthly occurrences = one monthly amount.
  ///
  /// Yearly:
  ///   Total of the 12 monthly allocations = one yearly amount.
  double get distributionTotal {
    return distributionAmounts.fold(
      0.0,
      (total, amount) => total + amount.value,
    );
  }

  /// Returns the amount represented by one occurrence of the selected
  /// budget period.
  ///
  /// In Evenly mode, this is simply [amount].
  ///
  /// In Custom mode, [distributionTotal] may represent more than one
  /// occurrence of the base period. This is especially important for
  /// fortnightly plans:
  ///
  ///   Cycle 1 = ₱600
  ///   Cycle 2 = ₱600
  ///   Distribution total = ₱1,200
  ///
  /// The actual fortnightly amount is therefore:
  ///
  ///   ₱1,200 / 2 = ₱600
  double get plannedPeriodAmount {
    if (selectedDistribution.value == CashFlowDistribution.custom) {
      final period = selectedPeriod.value;

      if (period == null || period.customPatternLength == 0) {
        return 0;
      }

      return distributionTotal / period.customPatternLength;
    }

    return amount.value;
  }

  // ===========================================================================
  // Annual Projection
  // ===========================================================================

  /// Calculates the expected annual amount for the current plan.
  ///
  /// Evenly:
  ///
  ///   period amount × occurrences per year
  ///
  /// Custom:
  ///
  ///   custom pattern total × custom patterns per year
  ///
  /// Examples:
  ///
  /// Weekly:
  ///   ₱1,000 × 52 = ₱52,000
  ///
  /// Fortnightly:
  ///   ₱600 × 26 = ₱15,600
  ///
  ///   Custom:
  ///   (₱600 + ₱600) × 13 = ₱15,600
  ///
  /// Monthly:
  ///   ₱40,000 × 12 = ₱480,000
  ///
  /// Yearly:
  ///   ₱480,000 × 1 = ₱480,000
  double get annualizedAmount {
    final period = selectedPeriod.value;

    if (period == null) {
      return 0;
    }

    if (selectedDistribution.value == CashFlowDistribution.custom) {
      // The custom allocation total represents the complete
      // repeating custom pattern.
      return distributionTotal * period.customPatternsPerYear;
    }

    if (amount.value <= 0) {
      return 0;
    }

    return amount.value * period.occurrencesPerYear;
  }

  // ===========================================================================
  // Distribution Mode Switching
  // ===========================================================================

  /// Changes between Evenly and Custom distribution.
  ///
  /// Switching modes preserves the underlying planned amount.
  ///
  /// Evenly → Custom:
  ///   The current period amount is converted into the appropriate
  ///   custom pattern and distributed evenly across the allocation fields.
  ///
  /// Custom → Evenly:
  ///   The custom pattern total is converted back into the amount
  ///   for one occurrence of the base period.
  void selectDistribution(CashFlowDistribution distribution) {
    if (distribution == selectedDistribution.value) {
      return;
    }

    if (distribution == CashFlowDistribution.custom) {
      _switchToCustom();
      return;
    }

    _switchToEvenly();
  }

  /// Switches from Evenly to Custom distribution.
  void _switchToCustom() {
    final period = selectedPeriod.value;

    if (period == null) {
      return;
    }
    final periodAmount = amount.value;
    initializeDistributionFields();

    selectedDistribution.value = CashFlowDistribution.custom;

    if (periodAmount <= 0) {
      return;
    }

    /// A custom distribution may represent more than one occurrence
    /// of the base period.
    ///
    /// For example:
    ///
    /// Fortnightly:
    ///   ₱600 per fortnight
    ///   × 2 fortnights
    ///   = ₱1,200 custom pattern
    final patternTotal = periodAmount * period.customPatternLength;

    distributeAmountEvenly(patternTotal);
  }

  /// Switches from Custom to Evenly distribution.
  void _switchToEvenly() {
    final period = selectedPeriod.value;

    if (period == null) {
      return;
    }

    final patternTotal = distributionTotal;

    /// Convert the custom pattern back into the amount
    /// for one occurrence of the base period.
    ///
    /// Example:
    ///
    /// Fortnightly:
    ///   Cycle 1 = ₱400
    ///   Cycle 2 = ₱800
    ///   Pattern total = ₱1,200
    ///
    ///   ₱1,200 / 2 = ₱600 per fortnight
    final periodAmount = period.customPatternLength == 0
        ? 0.0
        : patternTotal / period.customPatternLength;

    amount.value = periodAmount;

    // amountController.text = periodAmount > 0
    //     ? periodAmount.toStringAsFixed(2)
    //     : '';

    selectedDistribution.value = CashFlowDistribution.defaultDistribution;

    disposeDistributionFields();
  }

  // ===========================================================================
  // Distribution Allocation Fields
  // ===========================================================================

  /// Text controllers for custom allocation amounts.
  ///
  /// The number of controllers is determined by [BudgetPeriod.allocationCount].
  ///
  /// Weekly:
  ///   7 fields → Monday through Sunday
  ///
  /// Fortnightly:
  ///   2 fields → first and second fortnight
  ///
  /// Monthly:
  ///   2 fields → first and second occurrence
  ///
  /// Yearly:
  ///   12 fields → January through December
  // final List<TextEditingController> distributionControllers = [];

  /// Focus nodes corresponding to [distributionControllers].
  // final List<FocusNode> distributionFocusNodes = [];

  /// Creates the custom allocation fields for the selected period.
  void initializeDistributionFields() {
    final period = selectedPeriod.value;

    if (period == null || !period.supportsCustomization) {
      disposeDistributionFields();
      return;
    }

    disposeDistributionFields();

    distributionAmounts.assignAll(
      List.generate(period.allocationCount, (_) => 0.0.obs),
    );
  }

  void disposeDistributionFields() {
    distributionAmounts.clear();
  }

  // ===========================================================================
  // Even Distribution
  // ===========================================================================

  /// Distributes [total] evenly across all custom allocation fields.
  ///
  /// The calculation is performed in cents to guarantee that the
  /// allocation values add up exactly to [total], avoiding floating-point
  /// rounding discrepancies.
  ///
  /// Example:
  ///
  /// Total = ₱1,000
  /// Allocation count = 7
  ///
  /// The remainder centavos are distributed across the first
  /// allocation fields so that the final total remains exactly ₱1,000.
  void distributeAmountEvenly(double total) {
    if (total <= 0 || distributionAmounts.isEmpty) {
      return;
    }

    final totalCents = (total * 100).round();
    final count = distributionAmounts.length;

    final baseCents = totalCents ~/ count;
    final remainderCents = totalCents % count;

    for (var i = 0; i < count; i++) {
      final cents = baseCents + (i < remainderCents ? 1 : 0);

      distributionAmounts[i].value = cents / 100;
    }
  }

  void resetIncomePlan() {
    transactionController.selectedCategory.value = null;
    // Reset period
    selectedPeriod.value = null;

    // Reset distribution mode
    selectedDistribution.value = CashFlowDistribution.defaultDistribution;

    // Reset amount
    amount.value = 0;
    // amountController.clear();

    // Reset custom allocation fields
    disposeDistributionFields();

    // Reset revision
    // distributionRevision.value++;
  }

  void resetBudgetPlan() {
    transactionController.selectedCategory.value = null;
    // Reset period
    selectedPeriod.value = null;

    // Reset distribution mode
    selectedDistribution.value = CashFlowDistribution.defaultDistribution;

    // Reset amount
    amount.value = 0;
    // amountController.clear();

    // Reset custom allocation fields
    disposeDistributionFields();

    // Reset revision
    // distributionRevision.value++;
  }
  // ===========================================================================
  // Financial Stability — Temporary Values
  // ===========================================================================

  /// Returns the planned cashflow distributed across the 12 calendar months.
  ///
  /// This is the monthly equivalent of the current plan and is used by
  /// the monthly impact chart.
  ///
  /// Evenly:
  /// - Weekly: the weekly amount is converted to a monthly equivalent.
  /// - Fortnightly: the fortnightly amount is converted to a monthly equivalent.
  /// - Monthly: the amount is applied directly to every month.
  /// - Yearly: the annual amount is distributed evenly across 12 months.
  ///
  /// Custom:
  /// - Weekly: the 7 daily allocations are summed to get the weekly pattern,
  ///   then converted to a monthly equivalent.
  /// - Fortnightly: the two allocations form a 4-week pattern, which is
  ///   converted to a monthly equivalent.
  /// - Monthly: the custom monthly amount is applied to each month.
  /// - Yearly: each monthly allocation is used directly.
  List<double> get monthlyPlannedDistribution {
    final period = selectedPeriod.value;

    if (period == null) {
      return List.filled(12, 0);
    }

    final isCustom = selectedDistribution.value == CashFlowDistribution.custom;

    if (!isCustom) {
      return _monthlyDistributionFromEvenly(period);
    }

    return _monthlyDistributionFromCustom(period);
  }

  List<double> _monthlyDistributionFromEvenly(BudgetPeriod period) {
    final year = DateTime.now().year;

    switch (period) {
      case BudgetPeriod.weekly:
        final distribution = List<double>.filled(12, 0);

        // The selected date determines the recurring weekday.
        // Example: Monday → every Monday throughout the year.
        final recurringWeekday = occurrenceDate.value.weekday;

        for (var month = 1; month <= 12; month++) {
          final daysInMonth = DateTime(year, month + 1, 0).day;

          for (var day = 1; day <= daysInMonth; day++) {
            final date = DateTime(year, month, day);

            if (date.weekday == recurringWeekday) {
              distribution[month - 1] += amount.value;
            }
          }
        }

        return distribution;

      case BudgetPeriod.fortnightly:
        final distribution = List<double>.filled(12, 0);

        final yearStart = DateTime(year, 1, 1);
        final yearEnd = DateTime(year, 12, 31);

        // Temporary recurrence anchor.
        // Later, this can become the user's selected occurrenceDate.
        var occurrence = DateTime.now();

        // Move backward through the same 14-day cycle
        // until we reach the first occurrence that can affect this year.
        while (occurrence
            .subtract(const Duration(days: 14))
            .isAfter(yearStart)) {
          occurrence = occurrence.subtract(const Duration(days: 14));
        }

        // Move forward through the entire current year.
        while (!occurrence.isAfter(yearEnd)) {
          if (!occurrence.isBefore(yearStart)) {
            distribution[occurrence.month - 1] += amount.value;
          }

          occurrence = occurrence.add(const Duration(days: 14));
        }

        return distribution;
      case BudgetPeriod.monthly:
        return List.filled(12, amount.value);

      case BudgetPeriod.yearly:
        return List.filled(12, amount.value / 12);
    }
  }

  List<double> _monthlyDistributionFromCustom(BudgetPeriod period) {
    switch (period) {
      case BudgetPeriod.weekly:
        final year = DateTime.now().year;
        final distribution = List<double>.filled(12, 0);

        for (var month = 1; month <= 12; month++) {
          final daysInMonth = DateTime(year, month + 1, 0).day;

          for (var day = 1; day <= daysInMonth; day++) {
            final date = DateTime(year, month, day);

            final allocationIndex = date.weekday - 1;

            if (allocationIndex >= distributionAmounts.length) {
              continue;
            }

            distribution[month - 1] +=
                distributionAmounts[allocationIndex].value;
          }
        }

        return distribution;

      case BudgetPeriod.fortnightly:
        final distribution = List<double>.filled(12, 0);

        final year = DateTime.now().year;
        final yearStart = DateTime(year, 1, 1);
        final yearEnd = DateTime(year, 12, 31);

        if (distributionAmounts.length < 2) {
          return distribution;
        }

        final amountA = distributionAmounts[0].value;
        final amountB = distributionAmounts[1].value;

        var occurrence = DateTime.now();

        var allocationIndex = 0;

        while (occurrence
            .subtract(const Duration(days: 14))
            .isAfter(yearStart)) {
          occurrence = occurrence.subtract(const Duration(days: 14));

          allocationIndex = allocationIndex == 0 ? 1 : 0;
        }

        while (!occurrence.isAfter(yearEnd)) {
          if (!occurrence.isBefore(yearStart)) {
            final occurrenceAmount = allocationIndex == 0 ? amountA : amountB;

            distribution[occurrence.month - 1] += occurrenceAmount;
          }

          occurrence = occurrence.add(const Duration(days: 14));

          allocationIndex = allocationIndex == 0 ? 1 : 0;
        }

        return distribution;

      case BudgetPeriod.monthly:
        if (distributionAmounts.length < 2) {
          return List<double>.filled(12, 0);
        }

        final firstHalf = distributionAmounts[0].value;
        final secondHalf = distributionAmounts[1].value;

        return List<double>.filled(12, firstHalf + secondHalf);

      case BudgetPeriod.yearly:
        return List<double>.generate(
          12,
          (index) => index < distributionAmounts.length
              ? distributionAmounts[index].value
              : 0.0,
        );
      // default:
      //   return List.empty();
      // return switch (period) {
      //   // 7 daily allocations = one weekly pattern.
      //   // Convert the annual weekly total into an average monthly amount.
      //   BudgetPeriod.weekly => List.filled(
      //     12,
      //     patternTotal * period.customPatternsPerYear / 12,
      //   ),

      //   // 2 allocations = one 4-week pattern.
      //   // 13 four-week patterns = one year.
      //   BudgetPeriod.fortnightly => List.filled(
      //     12,
      //     patternTotal * period.customPatternsPerYear / 12,
      //   ),

      //   // One custom monthly amount per month.
      //   BudgetPeriod.monthly => List.filled(12, patternTotal),

      //   // 12 allocations already represent Jan → Dec.
      //   BudgetPeriod.yearly => List.from(
      //     distributionControllers.map(
      //       (controller) =>
      //           double.tryParse(controller.text.replaceAll(',', '').trim()) ?? 0,
      //     ),
      //   ),
      // };
    }
  }

  Future<List<CashFlowPlan>> get existingCashflowPlans async {
    return database.select(database.cashFlowPlans).get();
  }
}
