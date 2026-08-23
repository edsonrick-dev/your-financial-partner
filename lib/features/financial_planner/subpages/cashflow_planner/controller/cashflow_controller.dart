import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/database/daos/cashflow_plan_dao/cashflow_plan_dao.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/dropdown_selectors.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:drift/drift.dart' as d;

class CashflowController extends GetxController {
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

  Future<void> saveIncomePlan() async {
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
    final planId = await cashflowPlanDao.insertPlan(
      CashFlowPlansCompanion.insert(
        categoryId: d.Value<int?>(category.id),
        loanId: const d.Value<int?>(null),
        planType: 'income',
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

  Future<List<double>> calculateCurrentMonthlyDistribution({
    required TransactionType transactionType,
  }) async {
    final plans = await cashflowPlanDao.getAllPlans();

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

    final plans = allPlans.where((plan) {
      if (transactionType == TransactionType.earn) {
        return plan.planType == 'income';
      }

      return plan.planType != 'income';
    }).toList();

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
    disposeDistributionFields();

    // amountController.dispose();
    // amountFocusNode.dispose();

    super.onClose();
  }

  // ===========================================================================
  // Details
  // ===========================================================================

  final seletectedDetailsTabIndex = 0.obs;

  // Temporary values used by the existing cash-flow summary UI.
  final annualPlannedIncome = 750000.obs;
  final annualBudget = 500000.obs;

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

  double get annualExpense => 390000;

  double get expensePercentage =>
      clampDouble(annualExpense / dummyAnnualAllocation, 0, 1);

  double get annualDebtRepayment => 90000;

  double get debtRepaymentPercentage =>
      clampDouble(annualDebtRepayment / dummyAnnualAllocation, 0, 1);

  double get lifestyleCost => annualDebtRepayment + annualExpense;

  double get annualSavings => annualPlannedIncome.value - lifestyleCost;

  double get savingsPercentage =>
      clampDouble(annualSavings / dummyAnnualAllocation, 0, 1);

  double get dummyAnnualAllocation =>
      annualDebtRepayment + annualExpense + annualSavings;

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
