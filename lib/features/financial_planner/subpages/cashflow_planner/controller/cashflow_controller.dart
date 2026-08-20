import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';

class CashflowController extends GetxController {
  double get plannedPeriodAmount {
    distributionRevision.value;

    if (selectedDistribution.value == CashFlowDistribution.custom) {
      return distributionTotal;
    }

    return amount.value;
  }

  @override
  void onClose() {
    disposeDistributionFields();

    amountController.dispose();
    amountFocusNode.dispose();

    super.onClose();
  }

  double get distributionTotal {
    return distributionControllers.fold(0, (total, controller) {
      return total +
          (double.tryParse(controller.text.replaceAll(',', '').trim()) ?? 0);
    });
  }

  final RxInt distributionRevision = 0.obs;
  void distributionChanged(String value) {
    distributionRevision.value++;
  }

  final seletectedDetailsTabIndex = 0.obs;

  final annualPlannedIncome = 750000.obs;
  final annualBudget = 500000.obs;
  final Rxn<BudgetPeriod> selectedPeriod = Rxn<BudgetPeriod>();
  void selectPeriod(BudgetPeriod period) {
    selectedPeriod.value = period;
    selectedDistribution.value = CashFlowDistribution.defaultDistribution;

    disposeDistributionFields();
  }

  final RxDouble amount = 0.0.obs;

  void amountChanged() {
    amount.value =
        double.tryParse(amountController.text.replaceAll(',', '').trim()) ?? 0;
  }

  final TextEditingController amountController = TextEditingController();
  final FocusNode amountFocusNode = FocusNode();
  double get annualizedAmount {
    distributionRevision.value;

    final period = selectedPeriod.value;

    if (period == null) return 0;

    if (selectedDistribution.value == CashFlowDistribution.custom) {
      return switch (period) {
        BudgetPeriod.weekly => distributionTotal * 52,
        BudgetPeriod.fortnightly => distributionTotal * 13,
        BudgetPeriod.twiceAMonth => distributionTotal * 12,
        BudgetPeriod.monthly => 0,
        BudgetPeriod.yearly => distributionTotal,
      };
    }

    if (amount.value <= 0) return 0;

    return switch (period) {
      BudgetPeriod.weekly => amount.value * 52,
      BudgetPeriod.fortnightly => amount.value * 26,
      BudgetPeriod.twiceAMonth => amount.value * 24,
      BudgetPeriod.monthly => amount.value * 12,
      BudgetPeriod.yearly => amount.value,
    };
  }

  final Rx<CashFlowDistribution> selectedDistribution =
      CashFlowDistribution.defaultDistribution.obs;
  void selectDistribution2(CashFlowDistribution distribution) {
    if (distribution == CashFlowDistribution.custom) {
      final currentAmount = amount.value;

      initializeDistributionFields();

      selectedDistribution.value = distribution;

      distributeAmountEvenly(currentAmount);

      return;
    }

    selectedDistribution.value = distribution;
    disposeDistributionFields();
  }

  void selectDistribution(CashFlowDistribution distribution) {
    if (distribution == CashFlowDistribution.custom) {
      final currentAmount = amount.value;

      initializeDistributionFields();

      selectedDistribution.value = distribution;

      distributeAmountEvenly(currentAmount);

      return;
    }

    // Custom → Evenly
    amount.value = distributionTotal;

    amountController.text = amount.value.toStringAsFixed(2);

    selectedDistribution.value = distribution;

    disposeDistributionFields();
  }

  void selectDistribution1(CashFlowDistribution distribution) {
    selectedDistribution.value = distribution;

    if (distribution == CashFlowDistribution.custom) {
      initializeDistributionFields();
      distributeAmountEvenly1();
    } else {
      disposeDistributionFields();
    }
  }

  double get plannedAmount =>
      selectedDistribution.value == CashFlowDistribution.custom
      ? distributionTotal
      : amount.value;
  void distributeAmountEvenly(double total) {
    final period = selectedPeriod.value;

    if (period == null || total <= 0) return;

    final count = switch (period) {
      BudgetPeriod.weekly => 7,
      BudgetPeriod.fortnightly => 2,
      BudgetPeriod.twiceAMonth => 2,
      BudgetPeriod.monthly => 0,
      BudgetPeriod.yearly => 12,
    };

    if (count == 0) return;

    final totalCents = (total * 100).round();
    final baseCents = totalCents ~/ count;
    final remainderCents = totalCents % count;

    for (var i = 0; i < count; i++) {
      final cents = baseCents + (i < remainderCents ? 1 : 0);

      distributionControllers[i].text = (cents / 100).toStringAsFixed(2);
    }

    distributionRevision.value++;
  }

  void distributeAmountEvenly1() {
    final period = selectedPeriod.value;

    if (period == null || amount.value <= 0) return;

    final count = switch (period) {
      BudgetPeriod.weekly => 7,
      BudgetPeriod.fortnightly => 2,
      BudgetPeriod.twiceAMonth => 2,
      BudgetPeriod.monthly => 0,
      BudgetPeriod.yearly => 12,
    };

    if (count == 0) return;

    final totalCents = (amount.value * 100).round();
    final baseCents = totalCents ~/ count;
    final remainderCents = totalCents % count;

    for (var i = 0; i < count; i++) {
      final cents = baseCents + (i < remainderCents ? 1 : 0);
      final value = cents / 100;

      distributionControllers[i].text = value.toStringAsFixed(2);
    }

    distributionRevision.value++;
  }
  // final RxList<double> allocationAmounts = <double>[].obs;
  // void initializeAllocations() {
  //   switch (selectedPeriod.value) {
  //     case BudgetPeriod.weekly:
  //       allocationAmounts.assignAll(List.filled(7, 0));

  //     case BudgetPeriod.fortnightly:
  //       allocationAmounts.assignAll(List.filled(2, 0));

  //     case BudgetPeriod.twiceAMonth:
  //       allocationAmounts.assignAll(List.filled(2, 0));

  //     case BudgetPeriod.monthly:
  //       allocationAmounts.clear();

  //     case BudgetPeriod.yearly:
  //       allocationAmounts.assignAll(List.filled(12, 0));

  //     case null:
  //       allocationAmounts.clear();
  //   }
  // }

  final List<TextEditingController> distributionControllers = [];
  final List<FocusNode> distributionFocusNodes = [];

  void disposeDistributionFields() {
    for (final controller in distributionControllers) {
      controller.dispose();
    }

    for (final focusNode in distributionFocusNodes) {
      focusNode.dispose();
    }

    distributionControllers.clear();
    distributionFocusNodes.clear();
  }

  void initializeDistributionFields() {
    final period = selectedPeriod.value;

    if (period == null || !period.supportsCustomization) {
      disposeDistributionFields();
      return;
    }

    final count = switch (period) {
      BudgetPeriod.weekly => 7,
      BudgetPeriod.fortnightly => 2,
      BudgetPeriod.twiceAMonth => 2,
      BudgetPeriod.monthly => 0,
      BudgetPeriod.yearly => 12,
    };

    disposeDistributionFields();

    distributionControllers.addAll(
      List.generate(count, (_) => TextEditingController()),
    );

    distributionFocusNodes.addAll(List.generate(count, (_) => FocusNode()));
  }

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
  // double get annualAllocated =>
  //     projections.fold(0.0, (sum, p) => sum + p.allocated);

  // double get annualSurplus => annualIncome - annualAllocated;
}
