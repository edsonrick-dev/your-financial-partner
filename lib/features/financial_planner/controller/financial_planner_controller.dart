import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/frequency_type_enum.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/domain/scheduling/month_pattern.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/cashflow_planner_screen.dart';
import 'package:getx_drift_app/features/financial_planner/models/financial_planner_page_model.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_planner_screen.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/networth_planner_screen.dart';
import 'package:getx_drift_app/features/sheets/selection_sheets/select_day_of_month.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:intl/intl.dart';
import 'package:getx_drift_app/data/enums/split_mode_enum.dart';

class FinancialPlannerController extends GetxController {
  final selectedTabIndex = 0.obs;

  final financialPlannerPages = <FinancialPlannerPage>[
    FinancialPlannerPage(title: 'Net Worth', page: NetworthPlannerScreen()),
    FinancialPlannerPage(title: 'Cashflow', page: CashflowPlannerScreen()),
    FinancialPlannerPage(title: 'Insurance', page: InsurancePlannerScreen()),
    FinancialPlannerPage(title: 'Savings & Investments', page: Column()),
  ];

  void selectTab(int index) {
    selectedTabIndex.value = index;
  }

  // final previewProjections = <PlanProjection>[].obs;
  // final projections = <MonthlyProjection>[].obs;
  final amountController = TextEditingController();
  final amountFocusNode = FocusNode();
  double get annualIncome => 1000000;

  double get annualDebtRepayment => 90000;
  double get annualExpense => 390000;
  double get annualSavings => 120000;

  double get expensePercentage =>
      clampDouble(annualExpense / dummyAnnualAllocation, 0, 1);
  double get debtRepaymentPercentage =>
      clampDouble(annualDebtRepayment / dummyAnnualAllocation, 0, 1);
  double get savingsPercentage =>
      clampDouble(annualSavings / dummyAnnualAllocation, 0, 1);
  double get dummyAnnualAllocation =>
      annualDebtRepayment + annualExpense + annualSavings;
  double get annualAllocated => annualDebtRepayment + annualExpense;

  double get annualSurplus => annualIncome - annualAllocated;
  // Future<void> loadProjection() async {
  //   final plans = await database.getCashFlowPlans();

  //   projections.value = CashFlowProjectionService().buildYearProjection(
  //     year: DateTime.now().year,
  //     plans: plans,
  //   );
  // }

  // final selectedCashflowPlanType = Rxn<CashflowPlanType>();
  final selectedCategory = Rxn<CashflowCategoriesTableData>();

  // final selectedExpenseType = ExpenseMode.budget.obs;

  final selectedFrequency = Rxn<FrequencyType>();

  final RxBool isBill = false.obs;
  Rx<DateTime> selectedDate = DateTime.now().obs;
  String? get formattedDate {
    final value = selectedDate.value;

    return DateFormat('MMMM d, yyyy').format(value);
  }

  void setDate(DateTime value) {
    selectedDate.value = value;
  }

  final selectedSplitMode = SplitMode.equal.obs;

  ///Distribution Fields
  final dailyAmountControllers = List.generate(
    7,
    (_) => TextEditingController(),
  ).obs;
  final dailyAmountFocusNode = List.generate(7, (_) => FocusNode()).obs;

  final monthlyAmountControllers = List.generate(
    12,
    (_) => TextEditingController(),
  ).obs;
  final monthlyAmountFocusNode = List.generate(12, (_) => FocusNode()).obs;
  final selectedMonthPattern = Rxn<MonthPattern>();

  final customAmountControllers = <TextEditingController>[].obs;
  final customAmountFocusNode = <FocusNode>[].obs;
}

extension SelectFunctions on FinancialPlannerController {
  // Future<void> selectCashflowPlanType() async {
  //   final result = await AppSheets.selectCashflowPlanType();

  //   if (result == null) return;

  //   // // if (selectedCashflowPlanType.value != result) {
  //   //   selectedCashflowPlanType.value = result;
  //   //   selectedCategory.value = null;
  //   //   selectedFrequency.value = null;
  //   // }
  // }

  Future<void> selectCategory(TransactionType transactionType) async {
    final result = await AppSheets.selection.selectCategory(
      transactionType,
      selectedCategory: selectedCategory.value,
    );
    if (result == null) return;

    selectedCategory.value = result;
  }

  // Future<void> selectFrequency() async {
  //   final result = await AppSheets.selectFrequency();

  //   if (result == null) return;

  //   if (selectedFrequency.value != result) {
  //     selectedFrequency.value = result;
  //     selectedSplitMode.value = SplitMode.equal;
  //     selectedMonthPattern.value = null;

  //     previewProjections.clear();
  //     amountController.clear();
  //     clearDistributionFields();
  //     refreshPreview();
  //   }
  // }
}

extension BudgetDistributionFunctions on FinancialPlannerController {
  void clearDistributionFields() {
    for (final controller in dailyAmountControllers) {
      controller.clear();
    }
    for (final controller in monthlyAmountControllers) {
      controller.clear();
    }
    for (final controller in customAmountControllers) {
      controller.clear();
    }

    customAmountControllers.clear();
    customAmountFocusNode.clear();
  }
}

// extension MonthlyProjectionFunctions on FinancialPlannerController {
//   void refreshPreview() {
//     final frequency = selectedFrequency.value;

//     if (frequency == null) {
//       previewProjections.clear();
//       return;
//     }
//     if (selectedCashflowPlanType.value == null ||
//         selectedFrequency.value == null) {
//       previewProjections.clear();
//       return;
//     }
//     if (selectedFrequency.value!.requiresMonthPattern &&
//         selectedMonthPattern.value == null) {
//       previewProjections.clear();
//       return;
//     }
//     final plan = buildDraftPlan();

//     previewProjections.value = CashFlowProjectionService().buildPlanPreview(
//       year: DateTime.now().year,
//       plan: plan,
//     );
//     // for (final month in projections) {
//     //   debugPrint('${month.month.fullName} : ${month.allocated}');
//     // }
//     // for (var month = 1; month <= 12; month++) {
//     //   debugPrint(
//     //     'Month $month Mondays: '
//     //     '${countWeekdayInMonth(2026, month, DateTime.monday)}',
//     //   );
//     // }
//   }

//   double get previewAnnualAmount =>
//       previewProjections.fold(0, (sum, e) => sum + e.amount);
//   List<double> get previewMonthlyAmounts =>
//       previewProjections.map((e) => e.amount).toList();
//   CashFlowPlan buildDraftPlan() {
//     final isCustom = selectedSplitMode.value == SplitMode.custom;

//     return CashFlowPlan(
//       id: -1,
//       name: 'Preview',
//       planType: selectedCashflowPlanType.value!,
//       frequency: selectedFrequency.value!,

//       amount: isCustom ? null : (double.tryParse(amountController.text) ?? 0),

//       customAmounts: isCustom ? buildCustomAmounts() : null,

//       monthMask: selectedMonthPattern.value?.monthMask,
//     );
//   }

//   int countWeekdayInMonth(int year, int month, int weekday) {
//     int count = 0;

//     final daysInMonth = DateTime(year, month + 1, 0).day;

//     for (int day = 1; day <= daysInMonth; day++) {
//       if (DateTime(year, month, day).weekday == weekday) {
//         count++;
//       }
//     }

//     return count;
//   }

//   List<double>? buildCustomAmounts() {
//     if (selectedSplitMode.value != SplitMode.custom) {
//       return null;
//     }

//     switch (selectedFrequency.value) {
//       case FrequencyType.daily:
//         return dailyAmountControllers
//             .map((e) => double.tryParse(e.text) ?? 0)
//             .toList();

//       case FrequencyType.monthly:
//         return monthlyAmountControllers
//             .map((e) => double.tryParse(e.text) ?? 0)
//             .toList();

//       case FrequencyType.quarterly:
//       case FrequencyType.semiAnnual:
//         return customAmountControllers
//             .map((e) => double.tryParse(e.text) ?? 0)
//             .toList();

//       default:
//         return null;
//     }
//   }

//   double get previewMonthlyAverage => previewAnnualAmount / 12;
// }

class DailyDistributionFields extends GetView<FinancialPlannerController> {
  const DailyDistributionFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: List.generate(
        AppDays.values.length,
        (index) => AppTextField(
          label: AppDays.values[index].fullName,
          hintText: 0.toCurrency(),
          controller: controller.dailyAmountControllers[index],
          focusNode: controller.dailyAmountFocusNode[index],
          // keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}

class MonthlyDistributionFields extends GetView<FinancialPlannerController> {
  const MonthlyDistributionFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: List.generate(AppMonth.values.length, (index) {
        final month = AppMonth.values[index];
        return AppTextField(
          label: month.fullName,
          hintText: 0.toCurrency(),
          controller: controller.monthlyAmountControllers[index],
          focusNode: controller.monthlyAmountFocusNode[index],
          // keyboardType: TextInputType.number,
        );
      }),
    );
  }
}

class CustomDistributionFields extends GetView<FinancialPlannerController> {
  const CustomDistributionFields({super.key, required this.pattern});

  final MonthPattern pattern;
  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: List.generate(pattern.months.length, (index) {
        final month = pattern.months[index];
        return AppTextField(
          label: month.fullName,
          hintText: 0.toCurrency(),
          controller: controller.customAmountControllers[index],
          focusNode: controller.customAmountFocusNode[index],
          // keyboardType: TextInputType.number,
        );
      }),
    );
  }
}
