import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/frequency_type_enum.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/models/cashflow_plan_model.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/domain/enums/cashflow_plan_enum.dart';
import 'package:getx_drift_app/domain/scheduling/month_pattern.dart';
import 'package:getx_drift_app/features/financial_planner/cashflow_planner/cashflow_planner_screen.dart';
import 'package:getx_drift_app/features/financial_planner/cashflow_planner/services/cashflow_projection_service.dart';
import 'package:getx_drift_app/features/financial_planner/models/financial_planner_page_model.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:intl/intl.dart';
import 'package:getx_drift_app/data/enums/split_mode_enum.dart';

class FinancialPlannerController extends GetxController {
  final selectedTabIndex = 0.obs;
  void selectTab(int index) {
    selectedTabIndex.value = index;
  }

  final projections = <MonthlyProjection>[].obs;
  final amountController = TextEditingController();
  final amountFocusNode = FocusNode();
  double get annualIncome => projections.fold(0.0, (sum, p) => sum + p.income);

  double get annualAllocated =>
      projections.fold(0.0, (sum, p) => sum + p.allocated);

  double get annualSurplus => annualIncome - annualAllocated;
  Future<void> loadProjection() async {
    final plans = await database.getCashFlowPlans();

    projections.value = CashFlowProjectionService().buildYearProjection(
      year: DateTime.now().year,
      plans: plans,
    );
  }

  @override
  void onInit() {
    super.onInit();
    amountController.addListener(refreshPreview);

    for (final controller in dailyAmountControllers) {
      controller.addListener(refreshPreview);
    }
    for (final controller in monthlyAmountControllers) {
      controller.addListener(refreshPreview);
    }

    ever(selectedFrequency, (_) => refreshPreview());
    ever(selectedSplitMode, (_) => refreshPreview());
    ever(selectedMonthPattern, (_) => refreshPreview());
  }

  final financialPlannerPages = <FinancialPlannerPage>[
    FinancialPlannerPage(title: 'Cashflow', page: CashflowPlannerScreen()),
  ];

  final selectedCashflowPlanType = Rxn<CashflowPlanType>();
  final selectedCategory = Rxn<CashflowCategoriesTableData>();

  final selectedExpenseType = ExpenseMode.budget.obs;

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

  Future<void> selectMonthPattern() async {
    final frequency = selectedFrequency.value;

    if (frequency == null) return;

    final result = await AppSheets.selection.selectMonthPattern(frequency);
    if (result == null) return;

    selectedMonthPattern.value = result;

    customAmountControllers.assignAll(
      List.generate(result.months.length, (_) => TextEditingController()),
    );
    for (final controller in customAmountControllers) {
      controller.addListener(refreshPreview);
    }
    customAmountFocusNode.assignAll(
      List.generate(result.months.length, (_) => FocusNode()),
    );
  }
}

extension SelectFunctions on FinancialPlannerController {
  Future<void> selectCashflowPlanType() async {
    final result = await AppSheets.selectCashflowPlanType();

    if (result == null) return;

    if (selectedCashflowPlanType.value != result) {
      selectedCashflowPlanType.value = result;
      selectedCategory.value = null;
      selectedFrequency.value = null;
    }
  }

  Future<void> selectCategory(TransactionType transactionType) async {
    final result = await AppSheets.selection.selectCategory(
      transactionType,
      selectedCategory: selectedCategory.value,
    );
    if (result == null) return;

    selectedCategory.value = result;
  }

  Future<void> selectFrequency() async {
    final result = await AppSheets.selectFrequency();

    if (result == null) return;

    selectedFrequency.value = result;
    selectedSplitMode.value = SplitMode.equal;
    selectedMonthPattern.value = null;
    customAmountControllers.clear();
    customAmountFocusNode.clear();
  }
}

extension MonthlyProjectionFunctions on FinancialPlannerController {
  void refreshPreview() {
    final frequency = selectedFrequency.value;

    if (frequency == null) {
      projections.clear();
      return;
    }
    if (selectedCashflowPlanType.value == null ||
        selectedFrequency.value == null) {
      projections.clear();
      return;
    }

    final plan = buildDraftPlan();

    projections.value = CashFlowProjectionService().buildYearProjection(
      year: DateTime.now().year,
      plans: [plan],
    );
    for (final month in projections) {
      debugPrint('${month.month.fullName} : ${month.allocated}');
    }
    for (var month = 1; month <= 12; month++) {
      debugPrint(
        'Month $month Mondays: '
        '${countWeekdayInMonth(2026, month, DateTime.monday)}',
      );
    }
  }

  double get previewAnnualAmount =>
      projections.fold(0, (sum, e) => sum + e.allocated);
  List<double> get previewMonthlyAmounts =>
      projections.map((e) => e.allocated).toList();
  CashFlowPlan buildDraftPlan() {
    final isCustom = selectedSplitMode.value == SplitMode.custom;

    return CashFlowPlan(
      id: -1,
      name: 'Preview',
      planType: selectedCashflowPlanType.value!,
      frequency: selectedFrequency.value!,

      amount: isCustom ? null : (double.tryParse(amountController.text) ?? 0),

      customAmounts: isCustom ? buildCustomAmounts() : null,

      monthMask: selectedMonthPattern.value?.monthMask,
    );
  }

  int countWeekdayInMonth(int year, int month, int weekday) {
    int count = 0;

    final daysInMonth = DateTime(year, month + 1, 0).day;

    for (int day = 1; day <= daysInMonth; day++) {
      if (DateTime(year, month, day).weekday == weekday) {
        count++;
      }
    }

    return count;
  }

  List<double>? buildCustomAmounts() {
    if (selectedSplitMode.value != SplitMode.custom) {
      return null;
    }

    switch (selectedFrequency.value) {
      case FrequencyType.daily:
        return dailyAmountControllers
            .map((e) => double.tryParse(e.text) ?? 0)
            .toList();

      case FrequencyType.monthly:
        return monthlyAmountControllers
            .map((e) => double.tryParse(e.text) ?? 0)
            .toList();

      case FrequencyType.quarterly:
      case FrequencyType.semiAnnual:
        return customAmountControllers
            .map((e) => double.tryParse(e.text) ?? 0)
            .toList();

      default:
        return null;
    }
  }

  double get previewMonthlyAverage => previewAnnualAmount / 12;
}

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
