import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/enums/frequency_type_enum.dart';
import 'package:getx_drift_app/data/enums/transaction_type.dart';
import 'package:getx_drift_app/data/models/cashflow_plan_model.dart';
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
    final plans = [
      CashFlowPlan(
        id: 1,
        name: 'Salary',
        planType: CashflowPlanType.income,
        frequency: FrequencyType.monthly,
        amount: 30000,
      ),

      CashFlowPlan(
        id: 2,
        name: 'Food',
        planType: CashflowPlanType.expense,
        expenseMode: ExpenseMode.budget,
        frequency: FrequencyType.weekly,
        amount: 2000,
      ),

      CashFlowPlan(
        id: 3,
        name: 'Emergency Fund',
        planType: CashflowPlanType.savingsInvestment,
        frequency: FrequencyType.monthly,
        amount: 5000,
      ),

      CashFlowPlan(
        id: 4,
        name: 'Internet',
        planType: CashflowPlanType.expense,
        expenseMode: ExpenseMode.bill,
        frequency: FrequencyType.monthly,
        amount: 1699,
      ),

      CashFlowPlan(
        id: 5,
        name: '13th Month',
        planType: CashflowPlanType.income,
        frequency: FrequencyType.annual,
        amount: 30000,
        monthMask: 1 << 11, // December
      ),
    ];

    // loadProjection();

    ever(projections, (items) {
      for (final projection in items) {
        debugPrint(
          '${projection.month.month}'
          'Income=${projection.income}'
          'Expense=${projection.expenses}'
          'Savings=${projection.savings}',
        );
      }
    });

    projections.value = CashFlowProjectionService().buildYearProjection(
      year: 2026,
      plans: plans,
    );
  }

  final financialPlannerPages = <FinancialPlannerPage>[
    FinancialPlannerPage(title: 'Cashflow', page: CashflowPlannerScreen()),
  ];

  final selectedCashfLowPlanType = Rxn<CashflowPlanType>();
  final selectedCategory = Rxn<CashflowCategoriesTableData>();
  Future<void> selectCashflowPlanType() async {
    final result = await AppSheets.selectCashflowPlanType();

    if (result == null) return;

    if (selectedCashfLowPlanType.value != result) {
      selectedCategory.value = null;
    }

    selectedCashfLowPlanType.value = result;
  }

  Future<void> selectCategory(TransactionType transactionType) async {
    final result = await AppSheets.selection.selectCategory(
      transactionType,
      selectedCategory: selectedCategory.value,
    );
    if (result == null) return;

    selectedCategory.value = result;
  }

  final selectedExpenseType = ExpenseMode.budget.obs;

  final selectedFrequency = Rxn<FrequencyType>();

  Future<void> selectFrequency() async {
    final result = await AppSheets.selectFrequency();

    if (result == null) return;

    selectedFrequency.value = result;
    selectedSplitMode.value = SplitMode.equal;
    selectedMonthPattern.value = null;
  }

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

  Future<void> selectMonthPattern() async {
    final frequency = selectedFrequency.value;

    if (frequency == null) return;

    final result = await AppSheets.selection.selectMonthPattern(frequency);
    if (result == null) return;

    selectedMonthPattern.value = result;
  }
}

class DailyDistributionFields extends GetView<FinancialPlannerController> {
  const DailyDistributionFields({super.key});

  static const weekdays = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: List.generate(
        weekdays.length,
        (index) => AppTextField(
          focusNode: controller.dailyAmountFocusNode[index],
          label: weekdays[index],
          hintText: 0.toCurrency(),
          controller: controller.dailyAmountControllers[index],
          // keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}

class MonthlyDistributionFields extends GetView<FinancialPlannerController> {
  const MonthlyDistributionFields({super.key});

  static const months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: List.generate(
        months.length,
        (index) => AppTextField(
          focusNode: controller.monthlyAmountFocusNode[index],
          label: months[index],
          hintText: 0.toCurrency(),
          controller: controller.monthlyAmountControllers[index],
          // keyboardType: TextInputType.number,
        ),
      ),
    );
  }
}
