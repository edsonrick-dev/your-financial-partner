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
import 'package:getx_drift_app/features/transactions/controllers/extensions/delete_functions.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:drift/drift.dart' as drift;
import 'package:getx_drift_app/features/transactions/transaction_types/spend_transaction/spend_transaction_sheet.dart';
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

      final amount = bill.expectedAmount;

      if (amount == null) {
        return total;
      }

      return total + frequency.toAnnual(amount);
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
  }

  Future<void> createMinimumBudget() async {
    final category = transactionController.selectedCategory.value;
    final frequency = selectedPeriod.value;
    final dueDate = nextPaymentDate.value;
    final amount = billAmount.value;

    if (category == null) {
      return;
    }

    if (frequency == null) {
      return;
    }

    if (dueDate == null) {
      return;
    }

    if (amount <= 0) {
      return;
    }

    try {
      // ============================================================
      // MONTHLY
      // ============================================================

      if (frequency == BillsFrequency.monthly) {
        await _createMonthlyExpenseBudget(
          categoryId: category.id,
          amount: amount,
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

        await saveBill();
        return;
      }
    } catch (e, stackTrace) {}
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

        if (requiredMonthlyBudget <= currentBudget) {
          await saveBill();
          return;
        }

        await database.cashflowPlanDao.updatePlanAmount(
          planId: existingPlan.plan.id,
          amount: requiredMonthlyBudget,
        );

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

        await database.cashflowPlanDao.convertPlanToYearlyCustom(
          planId: existingPlan.plan.id,
          monthlyAllocations: updatedDistribution,
        );

        await saveBill();
        return;
      }
    } catch (e, stackTrace) {}
  }

  Future<void> saveBill() async {
    final name = billNameController.text.trim();
    final amount = billAmount.value;
    final frequency = selectedPeriod.value;
    final category = transactionController.selectedCategory.value;
    final dueDate = nextPaymentDate.value;

    if (name.isEmpty) {
      return;
    }

    if (amount <= 0) {
      return;
    }

    if (frequency == null) {
      return;
    }

    if (category == null) {
      return;
    }

    if (dueDate == null) {
      return;
    }

    try {
      await database.billsDao.insertBillWithFirstOccurrence(
        bill: BillsTableCompanion.insert(
          name: name,
          categoryId: drift.Value(category.id),
          accountId: const drift.Value(null),
          expectedAmount: drift.Value(amount),
          frequency: frequency.name,
          dayOfMonth: drift.Value(dueDate.day),
          // monthMask: const drift.Value(null),
          // reminderEnabled: drift.Value(reminderEnabled.value),
          // reminderDaysBefore: drift.Value(reminderDaysBefore.value),
        ),
        dueDate: dueDate,
        expectedAmount: amount,
      );

      Get.back();
    } catch (e, stackTrace) {
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
