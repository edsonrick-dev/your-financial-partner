import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/domain/enums/app_day.dart';
import 'package:getx_drift_app/domain/scheduling/month_pattern.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/enums/bill_budget_status_enum.dart';
import 'package:getx_drift_app/features/transaction/controllers/transaction_controller.dart';

class BillController extends GetxController {
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

    final now = DateTime.now();

    final frequency = selectedPeriod.value;

    if (frequency == null) {
      nextDueDate.value = null;
      return;
    }

    // Monthly
    if (frequency == BillsFrequency.monthly) {
      var dueDate = DateTime(now.year, now.month, day);

      if (dueDate.isBefore(DateTime(now.year, now.month, now.day))) {
        dueDate = DateTime(now.year, now.month + 1, day);
      }

      nextDueDate.value = dueDate;
      return;
    }

    // Quarterly / Semi-annual / Annual
    final pattern = selectedMonthPattern.value;

    if (pattern == null || pattern.months.isEmpty) {
      nextDueDate.value = null;
      return;
    }

    DateTime? nextDate;

    for (final month in pattern.months) {
      final candidate = DateTime(now.year, month.number, day);

      if (!candidate.isBefore(DateTime(now.year, now.month, now.day))) {
        nextDate = candidate;
        break;
      }
    }

    // If all months in this year's pattern have passed,
    // use the first month in the pattern next year.
    nextDate ??= DateTime(now.year + 1, pattern.months.first.number, day);

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
    isBillValid.value =
        billNameController.text.trim().isNotEmpty &&
        billAmount.value > 0 &&
        selectedPeriod.value != null &&
        selectedMonthDay.value != null &&
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
