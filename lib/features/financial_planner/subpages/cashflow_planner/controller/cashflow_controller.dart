import 'dart:async';
import 'package:drift/drift.dart' as d;
import 'dart:math' as math;

import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/database/daos/cashflow_plan_dao/cashflow_plan_dao.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/app_day.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_plan_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_next_occurrence.dart';
import 'package:getx_drift_app/features/home/views/section_views/budget_progress_section.dart';
import 'package:getx_drift_app/features/home/widgets/budget_tile.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';

class CashflowController extends GetxController {
  // ===========================================================================
  // AddCashflowPlanMenu
  // ===========================================================================

  final isCashflowPlanMenuOpen = false.obs;

  void toggleCashflowPlanMenu() {
    isCashflowPlanMenuOpen.toggle();
  }

  void closeCashflowPlaneMenu() {
    isCashflowPlanMenuOpen.value = false;
  }

  // ===========================================================================
  // Dependencies
  // ===========================================================================

  final transactionController = Get.find<TransactionController>();

  late final StreamSubscription<Map<int, double>> _budgetSubscription;

  late final StreamSubscription<List<CashflowPlanWithCategory>>
  _cashflowPlansSubscription;

  // ===========================================================================
  // Actions
  // ===========================================================================

  Future<void> makeBillPayment(BillWithNextOccurrence bill) async {
    await AppSheets.transaction.spendBill(bill);
  }

  // ===========================================================================
  // Saved Plan State
  // ===========================================================================

  final savedPlans = <CashflowPlanWithCategory>[].obs;

  bool get isEmpty => savedPlans.isEmpty;

  Set<int> get existingBudgetPlanCategoryIds {
    return savedPlans
        .where((plan) => plan.plan.planType == 'expense')
        .map((plan) => plan.category.id)
        .toSet();
  }

  Set<int> get existingIncomePlanCategoryIds {
    return savedPlans
        .where((plan) => plan.plan.planType == 'income')
        .map((plan) => plan.category.id)
        .toSet();
  }

  bool get hasIncomePlan =>
      savedPlans.any((plan) => plan.plan.planType == 'income');

  bool get hasExpensePlan => savedPlans.any(
    (plan) => plan.plan.planType == CashflowPlanType.expense.name,
  );

  bool get hasDebtRepaymentPlan => savedPlans.any(
    (plan) => plan.plan.planType == CashflowPlanType.debtRepayment.name,
  );

  bool get hasBudgetPlan => hasExpensePlan || hasDebtRepaymentPlan;

  // ===========================================================================
  // Budget State
  // ===========================================================================

  final currentMonthBudgetItems = <CurrentMonthBudgetItem>[].obs;

  final Rx<DisplayMode> budgetDisplayMode = DisplayMode.list.obs;

  final RxBool isBudgetExpanded = false.obs;

  bool get hasCurrentMonthBudget => currentMonthBudgetItems.isNotEmpty;

  void setBudgetDisplayMode(DisplayMode mode) {
    budgetDisplayMode.value = mode;
    isBudgetExpanded.value = false;
  }

  void toggleBudgetExpanded() {
    isBudgetExpanded.toggle();
  }

  double getBudgetForCategory(int categoryId) {
    final result = currentMonthBudgetItems
        .where((item) => item.categoryId == categoryId)
        .fold<double>(0.0, (total, item) => total + item.budget);

    return result;
  }

  // ===========================================================================
  // Lifecycle
  // ===========================================================================

  @override
  void onInit() {
    super.onInit();

    _cashflowPlansSubscription = database.cashflowPlanDao
        .watchAllPlansWithDetails()
        .listen((plans) async {
          savedPlans.assignAll(plans);
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

          await _refreshCurrentMonthBudgetItems();
          await _refreshMonthlyCashflow();
        });

    _budgetSubscription = database.transactionsDao
        .watchCurrentMonthExpensesByCategory(month: DateTime.now())
        .listen((spent) async {
          await _refreshCurrentMonthBudgetItems();
        });
  }

  @override
  void onClose() {
    _cashflowPlansSubscription.cancel();

    disposeDistributionFields();
    _budgetSubscription.cancel();
    super.onClose();
  }

  // ===========================================================================
  // Saved Plan Streams
  // ===========================================================================

  Stream<List<SavedCashflowPlanData>> watchSavedBudgetPlans() {
    return database.cashflowPlanDao.watchAllPlansWithDetails().map((plans) {
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

  Stream<List<SavedCashflowPlanData>> watchSavedCashflowPlans({
    required TransactionType transactionType,
  }) {
    final targetPlanType = planTypeFromTransactionType(transactionType);

    return database.cashflowPlanDao.watchAllPlansWithDetails().map((plans) {
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

  // ===========================================================================
  // Current Month Budget
  // ===========================================================================

  Future<void> _refreshCurrentMonthBudgetItems() async {
    final now = DateTime.now();
    final monthIndex = now.month - 1;
    final year = now.year;

    final spentByCategory = await database.transactionsDao
        .watchCurrentMonthExpensesByCategory(month: now)
        .first;

    final result = <CurrentMonthBudgetItem>[];

    for (final savedPlan in savedPlans) {
      final plan = savedPlan.plan;

      if (plan.planType != 'expense') {
        continue;
      }

      final allocations = await database.cashflowPlanDao.getAllocationsForPlan(
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

      final monthly = calculateSavedPlanRecurringMonthlyDistribution(
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

    currentMonthBudgetItems.assignAll(result);
  }

  Stream<List<CurrentMonthBudgetItem>> watchCurrentMonthBudgetItems() {
    final now = DateTime.now();
    final monthIndex = now.month - 1;
    final year = now.year;

    return database.cashflowPlanDao.watchAllPlansWithDetails().asyncMap((
      savedPlans,
    ) async {
      final spentByCategory = await database.transactionsDao
          .watchCurrentMonthExpensesByCategory(month: now)
          .first;

      final result = <CurrentMonthBudgetItem>[];

      for (final savedPlan in savedPlans) {
        final plan = savedPlan.plan;

        if (plan.planType != 'expense') {
          continue;
        }

        final allocations = await database.cashflowPlanDao
            .getAllocationsForPlan(plan.id);

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

        final monthly = calculateSavedPlanRecurringMonthlyDistribution(
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
    });
  }

  Future<List<CurrentMonthBudgetItem>> getCurrentMonthBudgetItems() async {
    final plans = await database.cashflowPlanDao
        .watchAllPlansWithDetails()
        .first;

    final currentMonthIndex = DateTime.now().month - 1;
    final year = DateTime.now().year;

    final result = <CurrentMonthBudgetItem>[];

    for (final savedPlan in plans) {
      final plan = savedPlan.plan;

      if (plan.planType != 'expense') {
        continue;
      }

      final monthly = calculateSavedPlanRecurringMonthlyDistribution(
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

  // ===========================================================================
  // Cash Flow Projection
  // ===========================================================================

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
    final plans = await database.cashflowPlanDao.getAllPlans();

    final income = List<double>.filled(12, 0);
    final expense = List<double>.filled(12, 0);
    final debt = List<double>.filled(12, 0);

    for (final plan in plans) {
      final allocations = await database.cashflowPlanDao.getAllocationsForPlan(
        plan.id,
      );

      final monthly = calculateSavedPlanRecurringMonthlyDistribution(
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

  // ===========================================================================
  // Annual Financial Summary
  // ===========================================================================

  final RxDouble plannedAnnualIncome = 0.0.obs;
  final RxDouble annualBudget = 0.0.obs;
  final RxDouble annualExpense = 0.0.obs;
  final RxDouble annualDebtRepayment = 0.0.obs;

  bool get hasAnnualSurplus {
    return annualCashflowDifference >= 0;
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

  // ===========================================================================
  // Saved Plan Calculations
  // ===========================================================================

  /// Calculates the annual amount represented by a saved cash flow plan.
  /// This uses the plan's persisted period and distribution configuration.
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

  /// Calculates the recurring monthly distribution of a saved plan
  /// across all 12 months of [year].
  ///
  /// The result represents the actual recurring amount expected in each
  /// calendar month.
  List<double> calculateSavedPlanRecurringMonthlyDistribution({
    required CashFlowPlan plan,
    required List<CashFlowPlanAllocation> allocations,
    required int year,
  }) {
    final monthlyDistribution = List<double>.filled(12, 0);

    final isCustom = plan.distributionType == CashFlowDistribution.custom.name;

    switch (plan.period) {
      case 'weekly':
        // -------------------------------------------------------------------------
        // Weekly
        // -------------------------------------------------------------------------
        //
        // The occurrence weekday is determined by [CashFlowPlan.startDate].
        // -------------------------------------------------------------------------
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

      case 'fortnightly':
        // -------------------------------------------------------------------------
        // Weekly
        // -------------------------------------------------------------------------
        //
        // The occurrence weekday is determined by [CashFlowPlan.startDate].
        // -------------------------------------------------------------------------
        final isCustom =
            plan.distributionType == CashFlowDistribution.custom.name;

        var cycleDate = plan.startDate;
        var cycleIndex = 0;

        final yearStart = DateTime(year, 1, 1);
        final yearEnd = DateTime(year, 12, 31);

        // Move backward from the anchor date until
        // we reach the beginning of the target year.
        while (cycleDate.isAfter(yearStart)) {
          cycleDate = cycleDate.subtract(const Duration(days: 14));

          if (isCustom) {
            cycleIndex = (cycleIndex + 1) % 2;
          }
        }

        // Calculate every fortnightly occurrence in the target year.
        while (!cycleDate.isAfter(yearEnd)) {
          if (plan.endDate != null && cycleDate.isAfter(plan.endDate!)) {
            break;
          }

          if (!cycleDate.isBefore(yearStart)) {
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

      case 'monthly':
        // -------------------------------------------------------------------------
        // Monthly
        // -------------------------------------------------------------------------
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

      case 'yearly':
        // -------------------------------------------------------------------------
        // Yearly
        // -------------------------------------------------------------------------
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

  Future<double> calculateRecurringAnnualBudget() async {
    final plans = await database.cashflowPlanDao.getAllPlans();

    final budgetPlans = plans.where(
      (plan) => plan.planType == 'expense' || plan.planType == 'debtRepayment',
    );

    final year = DateTime.now().year;

    var total = 0.0;

    for (final plan in budgetPlans) {
      final allocations = await database.cashflowPlanDao.getAllocationsForPlan(
        plan.id,
      );

      final monthly = calculateSavedPlanRecurringMonthlyDistribution(
        plan: plan,
        allocations: allocations,
        year: year,
      );

      total += monthly.fold<double>(0, (sum, amount) => sum + amount);
    }

    return total;
  }

  // ===========================================================================
  // Saved Plan Persistence
  // ===========================================================================

  Future<void> deleteSavedPlan(int planId) async {
    await database.cashflowPlanDao.deletePlan(planId);
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

    final planId = await database.cashflowPlanDao.insertPlan(
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

      await database.cashflowPlanDao.insertAllocations(allocations);
    }

    Get.back();
  }

  // ===========================================================================
  // Current Plan Builder
  // ===========================================================================

  /// Budget period selected while creating the current plan.
  final Rxn<BudgetPeriod> selectedPeriod = Rxn<BudgetPeriod>(
    BudgetPeriod.monthly,
  );

  /// Base amount for one occurrence of the selected period.
  ///
  /// Examples:
  /// - Weekly: amount paid every week.
  /// - Fortnightly: amount paid every 14 days.
  /// - Monthly: amount paid every month.
  /// - Yearly: amount allocated for the year.
  final RxDouble amount = 0.0.obs;

  /// Date used as the recurrence anchor for the current plan.
  final Rx<DateTime> occurrenceDate = DateTime.now().obs;

  /// Distribution mode used by the current plan.
  final Rx<CashFlowDistribution> selectedDistribution =
      CashFlowDistribution.defaultDistribution.obs;

  /// Custom allocation amounts for the selected period.
  final RxList<RxDouble> distributionAmounts = <RxDouble>[].obs;

  // ===========================================================================
  // Current Plan Calculations
  // ===========================================================================

  /// Total amount across all custom allocation fields.
  double get distributionTotal {
    return distributionAmounts.fold(
      0.0,
      (total, amount) => total + amount.value,
    );
  }

  /// Amount represented by one occurrence of the selected period.
  ///
  /// For custom distributions, the allocation total is divided by the
  /// period's custom pattern length.
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

  /// Projects the current plan's amount across one year.
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

  /// Projects the current plan's amount across all 12 calendar months.
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
  // ===========================================================================
  // Distribution Management
  // ===========================================================================

  /// Changes the budget period and resets any period-specific
  /// custom distribution configuration.
  void selectPeriod(BudgetPeriod period) {
    selectedPeriod.value = period;

    selectedDistribution.value = CashFlowDistribution.defaultDistribution;

    disposeDistributionFields();
  }

  /// Changes between evenly distributed and custom distribution modes.
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

  /// Converts the current evenly distributed amount into
  /// a custom allocation pattern.
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

  /// Converts the current custom allocation pattern back into
  /// a single evenly distributed amount.
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

    selectedDistribution.value = CashFlowDistribution.defaultDistribution;

    disposeDistributionFields();
  }

  // ===========================================================================
  // Distribution Allocation
  // ===========================================================================
  /// Creates the allocation state required by the selected period.
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
    /// Removes all custom allocation state.

    distributionAmounts.clear();
  }

  void distributeAmountEvenly(double total) {
    /// Distributes [total] across the allocation fields using cent-based
    /// arithmetic to guarantee an exact total.

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
  // ===========================================================================
  // ===========================================================================
  // ===========================================================================
  // ===========================================================================
  // ===========================================================================

  double get annualCashflowDifference {
    return plannedAnnualIncome.value - annualBudget.value;
  }

  Future<List<double>> calculateRecurringMonthlyDistribution({
    required TransactionType transactionType,
  }) async {
    final allPlans = await database.cashflowPlanDao.getAllPlans();

    final targetPlanType = planTypeFromTransactionType(transactionType);

    final plans = allPlans.where((plan) => plan.planType == targetPlanType);

    final result = List<double>.filled(12, 0);
    final year = DateTime.now().year;

    for (final plan in plans) {
      final allocations = await database.cashflowPlanDao.getAllocationsForPlan(
        plan.id,
      );

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

  Future<double> calculateRecurringAnnualTotal({
    required TransactionType transactionType,
  }) async {
    final distribution = await calculateRecurringMonthlyDistribution(
      transactionType: transactionType,
    );

    return distribution.reduce((a, b) => a + b);
  }

  final seletectedDetailsTabIndex = 0.obs;

  void resetIncomePlan() {
    transactionController.selectedCategory.value = null;
    // Reset period
    selectedPeriod.value = BudgetPeriod.monthly;

    // Reset distribution mode
    selectedDistribution.value = CashFlowDistribution.defaultDistribution;

    // Reset amount
    amount.value = 0;

    // Reset custom allocation fields
    disposeDistributionFields();
  }

  void resetBudgetPlan() {
    transactionController.selectedCategory.value = null;
    // Reset period
    selectedPeriod.value = BudgetPeriod.monthly;

    // Reset distribution mode
    selectedDistribution.value = CashFlowDistribution.defaultDistribution;

    // Reset amount
    amount.value = 0;

    // Reset custom allocation fields
    disposeDistributionFields();
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
    }
  }
}
