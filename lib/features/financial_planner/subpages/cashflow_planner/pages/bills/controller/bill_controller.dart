import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/data/app_database.dart';

import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/domain/enums/app_day.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';
import 'package:getx_drift_app/domain/scheduling/month_pattern.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/enums/bill_budget_status_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_payment_history.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_category.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_next_occurrence.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/delete_functions.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:drift/drift.dart' as drift;
import 'package:intl/intl.dart';

class BillController extends GetxController {
  Future<void> deletePaymentHistory(BillPaymentHistory payment) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete payment?'),
        content: const Text(
          'This will delete the payment and mark the bill as unpaid.',
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      return;
    }

    await Get.find<TransactionController>().deleteTransactionById(
      payment.transaction.id,
    );
  }

  Future<void> deleteBill(BillWithCategory item) async {
    final confirmed = await Get.dialog<bool>(
      AlertDialog(
        title: const Text('Delete bill?'),
        content: Text('Are you sure you want to delete "${item.bill.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Get.back(result: true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed != true) {
      return;
    }

    await database.billsDao.deleteBill(item.bill.id);
  }

  Future<void> makePayment(BillWithCategory item) async {
    final occurrences = await database.billsDao.getOccurrencesForBill(
      item.bill.id,
    );

    final nextOccurrence = occurrences
        .where((occurrence) => !occurrence.isPaid)
        .firstOrNull;

    if (nextOccurrence == null) {
      return;
    }

    final today = DateTime.now();

    final oneMonthFromToday = DateTime(today.year, today.month + 1, today.day);

    final isMoreThanOneMonthAway = nextOccurrence.dueDate.isAfter(
      oneMonthFromToday,
    );

    if (isMoreThanOneMonthAway) {
      final confirmed = await Get.dialog<bool>(
        AlertDialog(
          title: const Text('Pay this bill early?'),
          content: Text(
            'This bill is due on '
            '${DateFormat('MMM d, yyyy').format(nextOccurrence.dueDate)}. '
            'That is more than a month from today.\n\n'
            'Are you sure you want to record this payment now?',
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(result: false),
              child: const Text('Cancel'),
            ),
            FilledButton(
              onPressed: () => Get.back(result: true),
              child: const Text('Continue'),
            ),
          ],
        ),
      );

      if (confirmed != true) {
        return;
      }
    }

    final bill = BillWithNextOccurrence(
      bill: item.bill,
      occurrence: nextOccurrence,
      category: item.category,
    );

    Get.back();

    await AppSheets.transaction.spendBill(bill);
  }

  Future<void> increaseBudgetToFitBill() async {
    final category = transactionController.selectedCategory.value;
    final billFrequency = selectedPeriod.value;

    if (category == null || billFrequency == null) {
      return;
    }

    try {
      // Get all existing expense plans for this category.
      final existingPlans = await database.cashflowPlanDao
          .getExpensePlansForCategory(category.id);

      // No existing budget.
      if (existingPlans.isEmpty) {
        await createMinimumBudget();
        return;
      }

      // For now, use the existing budget plan.
      //
      // If your product allows multiple expense plans for the
      // same category, we should decide which one this bill belongs to.
      final existingPlan = existingPlans.first;

      final budgetPeriod = BudgetPeriod.values.firstWhere(
        (period) => period.name == existingPlan.plan.period,
      );

      // Convert the bill into an annual amount.
      final billAnnualAmount = billFrequency.toAnnual(billAmount.value);

      // Convert the annual bill into the EXISTING
      // budget's period.
      final requiredBudgetAmount = budgetPeriod.fromAnnual(billAnnualAmount);

      final currentBudget = existingPlan.plan.amount;

      debugPrint('========== INCREASE BUDGET ==========');
      debugPrint('category: ${category.name}');
      debugPrint('budget plan ID: ${existingPlan.plan.id}');
      debugPrint('budget period: ${budgetPeriod.label}');
      debugPrint('current budget: $currentBudget');
      debugPrint('bill frequency: ${billFrequency.label}');
      debugPrint('bill amount: ${billAmount.value}');
      debugPrint('bill annual amount: $billAnnualAmount');
      debugPrint('required budget: $requiredBudgetAmount');

      // Existing budget already covers the bill.
      if (requiredBudgetAmount <= currentBudget) {
        debugPrint('EXISTING BUDGET ALREADY COVERS BILL');
        await saveBill();
        return;
      }

      // UPDATE the existing plan.
      final updated = await database.cashflowPlanDao.updatePlanAmount(
        planId: existingPlan.plan.id,
        amount: requiredBudgetAmount,
      );

      if (!updated) {
        throw Exception('Failed to update budget plan ${existingPlan.plan.id}');
      }

      debugPrint(
        'BUDGET UPDATED: '
        '$currentBudget → $requiredBudgetAmount '
        '(${budgetPeriod.label})',
      );

      await saveBill();
    } catch (e, stackTrace) {
      debugPrint('INCREASE BUDGET FAILED: $e');
      debugPrint('$stackTrace');
    }
  }

  Future<void> _createMonthlyExpenseBudget({
    required int categoryId,
    required double amount,
  }) async {
    final now = DateTime.now();

    final planId = await database.cashflowPlanDao.insertPlan(
      CashFlowPlansCompanion.insert(
        categoryId: drift.Value<int?>(categoryId),
        loanId: const drift.Value<int?>(null),
        planType: 'expense',
        amount: amount,
        period: BudgetPeriod.monthly.name,
        distributionType: CashFlowDistribution.defaultDistribution.name,
        startDate: now,
        endDate: const drift.Value<DateTime?>(null),
        createdAt: now,
        updatedAt: now,
      ),
    );

    debugPrint(
      'BILL BUDGET CREATED: '
      'planId=$planId '
      'categoryId=$categoryId '
      'amount=$amount/month',
    );
  }

  Future<void> createMinimumBudget() async {
    final category = transactionController.selectedCategory.value;

    if (category == null) {
      debugPrint('CREATE MINIMUM BUDGET FAILED: category is null');
      return;
    }

    final monthlyAmount = annualBill / 12;

    if (monthlyAmount <= 0) {
      debugPrint('CREATE MINIMUM BUDGET FAILED: amount <= 0');
      return;
    }

    debugPrint('========== CREATE MINIMUM BUDGET ==========');
    debugPrint('category: ${category.name}');
    debugPrint('categoryId: ${category.id}');
    debugPrint('monthlyAmount: $monthlyAmount');

    try {
      await _createMonthlyExpenseBudget(
        categoryId: category.id,
        amount: monthlyAmount,
      );

      debugPrint('MINIMUM BUDGET CREATED');

      await saveBill();
    } catch (e, stackTrace) {
      debugPrint('CREATE MINIMUM BUDGET FAILED: $e');
      debugPrint('$stackTrace');
    }
  }

  Future<void> saveBill() async {
    debugPrint('========== SAVE BILL ==========');

    final name = billNameController.text.trim();
    final amount = billAmount.value;
    final frequency = selectedPeriod.value;
    final category = transactionController.selectedCategory.value;
    final dueDate = nextDueDate.value;
    final monthMask = selectedMonthPattern.value?.monthMask;

    debugPrint('name: $name');
    debugPrint('amount: $amount');
    debugPrint('frequency: ${frequency?.name}');
    debugPrint('categoryId: ${category?.id}');
    debugPrint('categoryName: ${category?.name}');
    debugPrint('dayOfMonth: ${selectedMonthDay.value}');
    debugPrint('monthMask: $monthMask');
    debugPrint('dueDate: $dueDate');
    debugPrint('reminderEnabled: ${reminderEnabled.value}');
    debugPrint('reminderDaysBefore: ${reminderDaysBefore.value}');

    if (name.isEmpty) {
      debugPrint('SAVE FAILED: name is empty');
      return;
    }

    if (amount <= 0) {
      debugPrint('SAVE FAILED: amount <= 0');
      return;
    }

    if (frequency == null) {
      debugPrint('SAVE FAILED: frequency is null');
      return;
    }

    if (category == null) {
      debugPrint('SAVE FAILED: category is null');
      return;
    }

    if (dueDate == null) {
      debugPrint('SAVE FAILED: nextDueDate is null');
      return;
    }

    debugPrint('Validation passed.');

    try {
      await database.billsDao.insertBillWithFirstOccurrence(
        bill: BillsTableCompanion.insert(
          name: name,
          categoryId: category.id,
          expectedAmount: amount,
          frequency: frequency.name,
          dayOfMonth: drift.Value(selectedMonthDay.value),
          monthMask: drift.Value(monthMask),
          reminderEnabled: drift.Value(reminderEnabled.value),
          reminderDaysBefore: drift.Value(reminderDaysBefore.value),
        ),
        dueDate: dueDate,
        expectedAmount: amount,
      );

      debugPrint('BILL SAVED SUCCESSFULLY');

      Get.back();

      debugPrint('FORM RESET');
      debugPrint('BOTTOM SHEET CLOSED');
      debugPrint('================================');
    } catch (e, stackTrace) {
      debugPrint('SAVE BILL FAILED: $e');
      debugPrint('$stackTrace');
      debugPrint('================================');

      rethrow;
    }
  }

  void resetForm() {
    billNameController.clear();

    billAmount.value = 0.0;

    selectedPeriod.value = BillsFrequency.monthly;

    selectedWeekday.value = null;

    firstBiWeeklyDay.value = null;
    secondBiWeeklyDay.value = null;

    fortnightlyNextBill.value = null;

    selectedMonthDay.value = null;
    selectedMonthPattern.value = null;

    reminderEnabled.value = false;
    reminderDaysBefore.value = null;

    nextDueDate.value = null;

    isBillValid.value = false;

    transactionController.selectedCategory.value = null;
  }

  double get selectedCategoryAnnualBudget {
    final categoryId = transactionController.selectedCategory.value?.id;

    if (categoryId == null) {
      return 0;
    }

    return cashflowController.savedPlans
        .where(
          (savedPlan) =>
              savedPlan.plan.planType == 'expense' &&
              savedPlan.category.id == categoryId,
        )
        .fold<double>(0.0, (total, savedPlan) {
          return total +
              cashflowController.calculateSavedPlanAnnualAmount(
                plan: savedPlan.plan,
                allocations: savedPlan.allocations,
              );
        });
  }

  double get selectedPeriodBudget {
    final annualBudget = selectedCategoryAnnualBudget;

    return switch (selectedPeriod.value) {
      BillsFrequency.monthly => annualBudget / 12,
      BillsFrequency.quarterly => annualBudget / 4,
      BillsFrequency.semiAnnual => annualBudget / 2,
      BillsFrequency.annual => annualBudget,
      _ => 0,
    };
  }

  double get selectedCategoryBudget {
    final category = transactionController.selectedCategory.value;

    if (category == null) {
      return 0;
    }

    return cashflowController.getBudgetForCategory(category.id);
  }

  // double get selectedCategoryAnnualBudget {
  //   final category = transactionController.selectedCategory.value;

  //   if (category == null) {
  //     return 0;
  //   }

  //   return cashflowController.getAnnualBudgetForCategory(category.id);
  // }

  double get annualBudget {
    return selectedCategoryBudget * 12;
  }

  double get annualBill {
    final amount = billAmount.value;
    final period = selectedPeriod.value;

    switch (period) {
      case BillsFrequency.monthly:
        return amount * 12;

      case BillsFrequency.quarterly:
        return amount * 4;

      case BillsFrequency.semiAnnual:
        return amount * 2;

      case BillsFrequency.annual:
        return amount;

      default:
        return 0;
    }
  }

  BillBudgetStatus get budgetStatus {
    if (!hasSelectedCategoryBudget) {
      return BillBudgetStatus.unbudgeted;
    }

    return annualBudget >= annualBill
        ? BillBudgetStatus.fits
        : BillBudgetStatus.exceeds;
  }

  final cashflowController = Get.find<CashflowController>();
  final transactionController = Get.find<TransactionController>();
  bool get hasSelectedCategoryBudget {
    final category = transactionController.selectedCategory.value;

    if (category == null) {
      return false;
    }

    return cashflowController.getBudgetForCategory(category.id) > 0;
  }

  final nextDueDate = Rxn<DateTime>();
  void updateNextDueDate() {
    final day = selectedMonthDay.value;

    if (day == null) {
      nextDueDate.value = null;
      return;
    }

    final frequency = selectedPeriod.value;

    if (frequency == null) {
      nextDueDate.value = null;
      return;
    }

    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    DateTime createSafeDate(int year, int month, int day) {
      final lastDayOfMonth = DateTime(year, month + 1, 0).day;

      return DateTime(year, month, day > lastDayOfMonth ? lastDayOfMonth : day);
    }

    if (frequency == BillsFrequency.monthly) {
      var dueDate = createSafeDate(now.year, now.month, day);

      if (dueDate.isBefore(today)) {
        dueDate = createSafeDate(now.year, now.month + 1, day);
      }

      nextDueDate.value = dueDate;
      return;
    }

    final pattern = selectedMonthPattern.value;

    if (pattern == null || pattern.months.isEmpty) {
      nextDueDate.value = null;
      return;
    }

    DateTime? nextDate;

    for (final month in pattern.months) {
      final candidate = createSafeDate(now.year, month.number, day);

      if (!candidate.isBefore(today)) {
        nextDate = candidate;
        break;
      }
    }

    nextDate ??= createSafeDate(now.year + 1, pattern.months.first.number, day);

    nextDueDate.value = nextDate;
  }

  final reminderEnabled = false.obs;
  final reminderDaysBefore = Rxn<int>();
  final RxDouble billAmount = 0.0.obs;
  final billNameFocusNode = FocusNode();
  final billNameController = TextEditingController();
  // final selectedFrequency = Rxn();
  final Rxn<BillsFrequency> selectedPeriod = Rxn<BillsFrequency>(
    BillsFrequency.monthly,
  );

  // Weekly
  final selectedWeekday = Rxn<AppDay>();

  // Bi-weekly
  final firstBiWeeklyDay = Rxn<int>();
  final secondBiWeeklyDay = Rxn<int>();

  // Fortnightly
  final fortnightlyNextBill = Rxn<DateTime>();

  // Monthly
  final selectedMonthDay = Rxn<int>();

  // Quarterly / Semi-annual / Annual
  final selectedMonthPattern = Rxn<MonthPattern>();
  void selectPeriod(BillsFrequency period) {
    selectedPeriod.value = period;
    _resetOccurrenceSelections();
    validateBill();
  }

  void _resetOccurrenceSelections() {
    selectedWeekday.value = null;

    firstBiWeeklyDay.value = null;
    secondBiWeeklyDay.value = null;

    fortnightlyNextBill.value = null;

    selectedMonthDay.value = null;

    selectedMonthPattern.value = null;
    updateNextDueDate();
  }

  final isBillValid = false.obs;
  void validateBill() {
    final category = transactionController.selectedCategory.value;

    isBillValid.value =
        billNameController.text.trim().isNotEmpty &&
        billAmount.value > 0 &&
        selectedPeriod.value != null &&
        selectedMonthDay.value != null &&
        category != null &&
        (selectedPeriod.value == BillsFrequency.monthly ||
            selectedMonthPattern.value != null);
  }
  // bool get isBillValid {
  //   if (billNameController.text.trim().isEmpty) {
  //     return false;
  //   }

  //   if (billAmount.value <= 0) {
  //     return false;
  //   }

  //   if (selectedPeriod.value == null) {
  //     return false;
  //   }

  //   if (selectedMonthDay.value == null) {
  //     return false;
  //   }

  //   // Monthly doesn't need a month pattern.
  //   if (selectedPeriod.value != BillsFrequency.monthly &&
  //       selectedMonthPattern.value == null) {
  //     return false;
  //   }

  //   return true;
  // }
}
