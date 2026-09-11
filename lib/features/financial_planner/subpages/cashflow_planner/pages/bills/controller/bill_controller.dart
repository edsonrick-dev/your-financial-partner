import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/database/daos/cashflow_plan_dao/cashflow_plan_dao.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/bills_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/enums/bill_budget_status_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_payment_history.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_category.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_next_occurrence.dart';
import 'package:getx_drift_app/features/transaction/controllers/extensions/delete_functions.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';
import 'package:drift/drift.dart' as drift;
import 'package:intl/intl.dart';

class BillController extends GetxController {
  final RxDouble billAmount = 0.0.obs;

  final billNameFocusNode = FocusNode();
  final billNameController = TextEditingController();

  final Rxn<BillsFrequency> selectedPeriod = Rxn<BillsFrequency>(
    BillsFrequency.monthly,
  );

  final isBillValid = false.obs;

  final Rxn<DateTime> nextPaymentDate = Rxn<DateTime>();
  String? get formattedNextPaymentDate {
    final date = nextPaymentDate.value;

    if (date == null) return null;

    return DateFormat('MMMM d, yyyy').format(date);
  }

  ///==========================================================================================
  ///==========================================================================================

  // String get formattedNextPaymentDateHint {
  //   return DateFormat('MMMM d, yyyy').format(DateTime.now());
  // }

  @override
  void onInit() {
    super.onInit();

    ever(transactionController.selectedCategory, (_) => loadExistingBills());

    loadExistingBills();
  }

  double get existingBillsAnnualAmount {
    return existingBills.fold<double>(0, (total, bill) {
      final frequency = BillsFrequency.values.firstWhere(
        (value) => value.name == bill.frequency,
      );

      return total + frequency.toAnnual(bill.expectedAmount);
    });
  }

  final existingBills = <BillsTableData>[].obs;
  double get existingBillsPeriodAmount {
    return switch (selectedPeriod.value) {
      BillsFrequency.monthly => existingBillsAnnualAmount / 12,
      BillsFrequency.quarterly => existingBillsAnnualAmount / 4,
      BillsFrequency.semiAnnual => existingBillsAnnualAmount / 2,
      BillsFrequency.annual => existingBillsAnnualAmount,
      _ => 0,
    };
  }

  Future<void> loadExistingBills() async {
    final category = transactionController.selectedCategory.value;

    if (category == null) {
      existingBills.clear();
      return;
    }

    final bills = await database.billsDao.getActiveBillsForCategory(
      category.id,
    );

    existingBills.assignAll(bills);
  }

  List<double> _getExistingPlanMonthlyDistribution(
    CashflowPlanWithCategory existingPlan,
  ) {
    return cashflowController.calculateSavedPlanRecurringMonthlyDistribution(
      plan: existingPlan.plan,
      allocations: existingPlan.allocations,
      year: DateTime.now().year,
    );
  }

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
      loanAccount: item.loanAccount,
    );

    Get.back();

    await AppSheets.transaction.spendBill(bill);
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
    final frequency = selectedPeriod.value;
    final dueDate = nextPaymentDate.value;
    final amount = billAmount.value;

    if (category == null) {
      debugPrint('CREATE MINIMUM BUDGET FAILED: category is null');
      return;
    }

    if (frequency == null) {
      debugPrint('CREATE MINIMUM BUDGET FAILED: frequency is null');
      return;
    }

    if (dueDate == null) {
      debugPrint('CREATE MINIMUM BUDGET FAILED: due date is null');
      return;
    }

    if (amount <= 0) {
      debugPrint('CREATE MINIMUM BUDGET FAILED: amount <= 0');
      return;
    }

    debugPrint('========== CREATE MINIMUM BUDGET ==========');
    debugPrint('category: ${category.name}');
    debugPrint('categoryId: ${category.id}');
    debugPrint('frequency: ${frequency.name}');
    debugPrint('amount: $amount');
    debugPrint('annualBill: $annualBill');
    debugPrint('first due date: $dueDate');

    try {
      // ============================================================
      // MONTHLY
      // ============================================================

      if (frequency == BillsFrequency.monthly) {
        await _createMonthlyExpenseBudget(
          categoryId: category.id,
          amount: amount,
        );

        debugPrint(
          'MONTHLY BUDGET CREATED: '
          '$amount/month',
        );

        await saveBill();
        return;
      }

      // ============================================================
      // YEARLY CUSTOM
      // ============================================================

      if (frequency == BillsFrequency.quarterly ||
          frequency == BillsFrequency.semiAnnual ||
          frequency == BillsFrequency.annual) {
        final impactedMonths = const BillScheduleCalculator().getImpactedMonths(
          startDate: dueDate,
          frequency: frequency,
          anchorDay: dueDate.day,
        );

        final monthlyAllocations = List<double>.filled(12, 0);

        for (final month in impactedMonths) {
          monthlyAllocations[month - 1] = amount;
        }

        debugPrint('Impacted months: ${impactedMonths.join(' | ')}');

        debugPrint('Monthly allocations: $monthlyAllocations');

        final now = DateTime.now();

        final planId = await database.cashflowPlanDao.insertPlan(
          CashFlowPlansCompanion.insert(
            categoryId: drift.Value<int?>(category.id),
            loanId: const drift.Value<int?>(null),
            planType: 'expense',
            amount: 0.0,
            period: BudgetPeriod.yearly.name,
            distributionType: CashFlowDistribution.custom.name,
            startDate: now,
            endDate: const drift.Value<DateTime?>(null),
            createdAt: now,
            updatedAt: now,
          ),
        );

        await database.cashflowPlanDao.insertAllocations(
          List.generate(
            12,
            (index) => CashFlowPlanAllocationsCompanion.insert(
              planId: planId,
              allocationIndex: index,
              amount: monthlyAllocations[index],
            ),
          ),
        );

        debugPrint(
          'YEARLY CUSTOM BUDGET CREATED: '
          'planId=$planId '
          'annualBill=$annualBill',
        );

        await saveBill();
        return;
      }

      debugPrint(
        'CREATE MINIMUM BUDGET FAILED: '
        'unsupported frequency ${frequency.name}',
      );
    } catch (e, stackTrace) {
      debugPrint('CREATE MINIMUM BUDGET FAILED: $e');
      debugPrint('$stackTrace');
    }
  }

  Future<void> increaseBudgetToFitBill() async {
    final category = transactionController.selectedCategory.value;
    final billFrequency = selectedPeriod.value;
    final dueDate = nextPaymentDate.value;

    if (category == null || billFrequency == null || dueDate == null) {
      return;
    }

    try {
      // ============================================================
      // GET EXISTING PLANS
      // ============================================================

      final existingPlans = await database.cashflowPlanDao
          .getExpensePlansForCategory(category.id);

      debugPrint('========== EXISTING PLANS ==========');
      debugPrint('Selected category: ${category.name}');
      debugPrint('Selected category ID: ${category.id}');
      debugPrint('Found plans: ${existingPlans.length}');

      for (final plan in existingPlans) {
        debugPrint(
          'PLAN ID: ${plan.plan.id} | '
          'categoryId: ${plan.plan.categoryId} | '
          'category: ${plan.category.name} | '
          'type: ${plan.plan.planType} | '
          'amount: ${plan.plan.amount} | '
          'period: ${plan.plan.period} | '
          'distribution: ${plan.plan.distributionType}',
        );
      }

      debugPrint('====================================');

      // ============================================================
      // NO EXISTING BUDGET
      // ============================================================

      if (existingPlans.isEmpty) {
        await createMinimumBudget();
        return;
      }

      final existingPlan = existingPlans.first;

      // ============================================================
      // MONTHLY
      // ============================================================

      if (billFrequency == BillsFrequency.monthly &&
          existingPlan.plan.period == BudgetPeriod.monthly.name &&
          existingPlan.plan.distributionType ==
              CashFlowDistribution.defaultDistribution.name) {
        final existingBillsMonthlyAmount = existingBillsAnnualAmount / 12;

        final requiredMonthlyBudget =
            existingBillsMonthlyAmount + billAmount.value;

        final currentBudget = existingPlan.plan.amount;

        debugPrint('========== MONTHLY BUDGET UPDATE ==========');
        debugPrint('Existing bills monthly: $existingBillsMonthlyAmount');
        debugPrint('New bill monthly: ${billAmount.value}');
        debugPrint('Required monthly budget: $requiredMonthlyBudget');
        debugPrint('Current budget: $currentBudget');

        if (requiredMonthlyBudget <= currentBudget) {
          await saveBill();
          return;
        }

        await database.cashflowPlanDao.updatePlanAmount(
          planId: existingPlan.plan.id,
          amount: requiredMonthlyBudget,
        );

        debugPrint('MONTHLY BUDGET UPDATED: $requiredMonthlyBudget/month');

        await saveBill();
        return;
      }

      // ============================================================
      // QUARTERLY / SEMI-ANNUAL / ANNUAL
      // ============================================================

      if (billFrequency == BillsFrequency.quarterly ||
          billFrequency == BillsFrequency.semiAnnual ||
          billFrequency == BillsFrequency.annual) {
        final existingDistribution = _getExistingPlanMonthlyDistribution(
          existingPlan,
        );

        final impactedMonths = const BillScheduleCalculator().getImpactedMonths(
          startDate: dueDate,
          frequency: billFrequency,
          anchorDay: dueDate.day,
        );

        final updatedDistribution = List<double>.from(existingDistribution);

        for (final month in impactedMonths) {
          updatedDistribution[month - 1] += billAmount.value;
        }

        debugPrint(
          '========== ${billFrequency.name.toUpperCase()} '
          'BUDGET UPDATE ==========',
        );

        debugPrint('Existing distribution: $existingDistribution');

        debugPrint('Bill amount: ${billAmount.value}');

        debugPrint('Impacted months: ${impactedMonths.join(' | ')}');

        debugPrint('Updated distribution: $updatedDistribution');

        await database.cashflowPlanDao.convertPlanToYearlyCustom(
          planId: existingPlan.plan.id,
          monthlyAllocations: updatedDistribution,
        );

        final allocations = await database.cashflowPlanDao
            .getAllocationsForPlan(existingPlan.plan.id);

        for (final allocation in allocations) {
          debugPrint(
            'ALLOCATION ${allocation.allocationIndex}: '
            '${allocation.amount}',
          );
        }

        await saveBill();
        return;
      }

      debugPrint(
        'INCREASE BUDGET FAILED: '
        'unsupported frequency ${billFrequency.name}',
      );
    } catch (e, stackTrace) {
      debugPrint('INCREASE BUDGET FAILED: $e');
      debugPrint('$stackTrace');
    }
  }

  Future<void> saveBill() async {
    debugPrint('========== SAVE BILL ==========');

    final name = billNameController.text.trim();
    final amount = billAmount.value;
    final frequency = selectedPeriod.value;
    final category = transactionController.selectedCategory.value;
    final dueDate = nextPaymentDate.value;

    debugPrint('name: $name');
    debugPrint('amount: $amount');
    debugPrint('frequency: ${frequency?.name}');
    debugPrint('categoryId: ${category?.id}');
    debugPrint('categoryName: ${category?.name}');
    debugPrint('dueDate: $dueDate');
    // debugPrint('reminderEnabled: ${reminderEnabled.value}');
    // debugPrint('reminderDaysBefore: ${reminderDaysBefore.value}');

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
      debugPrint('SAVE FAILED: nextPaymentDate is null');
      return;
    }

    debugPrint('Validation passed.');

    try {
      await database.billsDao.insertBillWithFirstOccurrence(
        bill: BillsTableCompanion.insert(
          name: name,
          categoryId: drift.Value(category.id),
          loanAccountId: const drift.Value(null),
          expectedAmount: amount,
          frequency: frequency.name,
          dayOfMonth: drift.Value(dueDate.day),
          monthMask: const drift.Value(null),
          // reminderEnabled: drift.Value(reminderEnabled.value),
          // reminderDaysBefore: drift.Value(reminderDaysBefore.value),
        ),
        dueDate: dueDate,
        expectedAmount: amount,
      );

      debugPrint('BILL SAVED SUCCESSFULLY');

      Get.back();

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
    transactionController.selectedCategory.value = null;
    billAmount.value = 0.0;
    nextPaymentDate.value = null;
    selectedPeriod.value = BillsFrequency.monthly;
    isBillValid.value = false;
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
  double get totalAnnualBills {
    return existingBillsAnnualAmount + annualBill;
  }

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

    final budget = selectedPeriodBudget;
    final existing = existingBillsPeriodAmount;
    final newBill = billAmount.value;
    final total = existing + newBill;

    debugPrint('========== BILL BUDGET STATUS ==========');
    debugPrint('Frequency: ${selectedPeriod.value?.label}');
    debugPrint('Budget: $budget');
    debugPrint('Existing bills: $existing');
    debugPrint('New bill: $newBill');
    debugPrint('Total bills: $total');
    debugPrint('Fits: ${budget >= total}');
    debugPrint('========================================');

    return budget >= total ? BillBudgetStatus.fits : BillBudgetStatus.exceeds;
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

  // void updateNextDueDate() {
  //   final day = selectedMonthDay.value;
  //   final frequency = selectedPeriod.value;

  //   if (day == null || frequency == null) {
  //     nextDueDate.value = null;
  //     return;
  //   }

  //   final now = DateTime.now();
  //   final today = DateTime(now.year, now.month, now.day);

  //   DateTime createSafeDate(int year, int month, int day) {
  //     final lastDayOfMonth = DateTime(year, month + 1, 0).day;

  //     return DateTime(year, month, day.clamp(1, lastDayOfMonth));
  //   }

  //   // The current month is the anchor month.
  //   var dueDate = createSafeDate(now.year, now.month, day);

  //   // If this month's occurrence has already passed,
  //   // move to the next occurrence according to the frequency.
  //   if (dueDate.isBefore(today)) {
  //     dueDate = _scheduleCalculator.getNextOccurrence(
  //       currentDate: dueDate,
  //       frequency: frequency,
  //       anchorDay: day,
  //     );
  //   }

  //   nextDueDate.value = dueDate;
  // }

  // final RxDouble billAmount = 0.0.obs;
  // final billNameFocusNode = FocusNode();
  // final billNameController = TextEditingController();
  // final selectedFrequency = Rxn();
  // final Rxn<BillsFrequency> selectedPeriod = Rxn<BillsFrequency>(
  //   BillsFrequency.monthly,
  // );

  // Weekly
  // final selectedWeekday = Rxn<AppDay>();

  // Bi-weekly
  // final firstBiWeeklyDay = Rxn<int>();
  // final secondBiWeeklyDay = Rxn<int>();

  // // Fortnightly
  // final fortnightlyNextBill = Rxn<DateTime>();

  // // Monthly
  // final selectedMonthDay = Rxn<int>();

  // // Quarterly / Semi-annual / Annual
  // final selectedMonthPattern = Rxn<MonthPattern>();
  // void selectPeriod(BillsFrequency period) {
  //   selectedPeriod.value = period;
  //   _resetOccurrenceSelections();
  //   validateBill();
  // }

  // void _resetOccurrenceSelections() {
  //   selectedWeekday.value = null;

  //   firstBiWeeklyDay.value = null;
  //   secondBiWeeklyDay.value = null;

  //   fortnightlyNextBill.value = null;

  //   selectedMonthDay.value = null;

  //   selectedMonthPattern.value = null;
  //   updateNextDueDate();
  // }

  // final isBillValid = false.obs;

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
