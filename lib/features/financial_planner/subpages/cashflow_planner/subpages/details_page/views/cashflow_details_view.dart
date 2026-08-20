import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/budget_list.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/create_income_plan_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/planned_income_list.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_page_action_section.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class CashflowDetailsView extends GetView<CashflowController> {
  const CashflowDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Scaffold(
      body: Column(
        children: [
          AppDetailsHeader(
            title: 'Cash Flow',
            child: Column(
              children: [
                Text(
                  'What to put here',
                  style: AppTextStyle.amountXL.copyWith(
                    color: colorScheme.appOutflow,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Obx(
                            () => Text(
                              controller.annualPlannedIncome.value.toCurrency(),
                              style: AppTextStyle.amountL.copyWith(
                                color: colorScheme.appInflow,
                              ),
                            ),
                          ),
                          Text(
                            'Annual Income',
                            style: AppTextStyle.titleM.copyWith(
                              color: colorScheme.inversePrimary.withAlpha(150),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Obx(
                            () => Text(
                              controller.annualBudget.value.toCurrency(),
                              style: AppTextStyle.amountL.copyWith(
                                color: colorScheme.appOutflow,
                              ),
                            ),
                          ),
                          Text(
                            'Annual Budget',
                            style: AppTextStyle.titleM.copyWith(
                              color: colorScheme.inversePrimary.withAlpha(150),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppDetailsPageActionSection(
            selectedIndex: controller.seletectedDetailsTabIndex,
            actions: const [
              'Income', 'Budget',
              // AppDetailsPageAction(title: 'Income', page: PlannedIncomeList()),
              // AppDetailsPageAction(title: 'Budget', page: BudgetList()),
            ],
            onAdd: () {
              controller.seletectedDetailsTabIndex.value == 0
                  ? Get.bottomSheet(
                      CreateIncomePlanSheet(),
                      isScrollControlled: true,
                    )
                  : Get.bottomSheet(SelectBudgetTypeSheet());
            },
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.seletectedDetailsTabIndex.value,
                children: const [PlannedIncomeList(), BudgetList()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BudgetPeriodSelectionSheet extends StatelessWidget {
  const BudgetPeriodSelectionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      title: 'Select Period',
      adaptiveHeight: false,
      child: Column(
        children: BudgetPeriod.values.map((period) {
          return ListTile(
            title: Text(period.label),
            subtitle: Text(period.description),
            onTap: () {
              Get.back(result: period);
            },
          );
        }).toList(),
      ),
    );
  }
}

class SelectBudgetTypeSheet extends StatelessWidget {
  const SelectBudgetTypeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(title: 'Select Budget Type', child: Column());
  }
}

class CashFlowDistributionFields extends GetView<CashflowController> {
  const CashFlowDistributionFields({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final period = controller.selectedPeriod.value;

      if (period == null || !period.supportsCustomization) {
        return const SizedBox.shrink();
      }

      return switch (period) {
        BudgetPeriod.weekly => _WeeklyFields(),
        BudgetPeriod.fortnightly => _FortnightlyFields(),
        BudgetPeriod.twiceAMonth => _TwiceAMonthFields(),
        BudgetPeriod.monthly => const SizedBox.shrink(),
        BudgetPeriod.yearly => _YearlyFields(),
      };
    });
  }
}

class _WeeklyFields extends GetView<CashflowController> {
  const _WeeklyFields();

  static const days = [
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Weekly Distribution',
          style: Theme.of(context).textTheme.titleMedium,
        ),

        ...List.generate(
          days.length,
          (index) => AppTextField(
            label: days[index],
            onChanged: controller.distributionChanged,
            prefixText: '₱',
            controller: controller.distributionControllers[index],
            focusNode: controller.distributionFocusNodes[index],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }
}

class _FortnightlyFields extends GetView<CashflowController> {
  const _FortnightlyFields();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Every 2 Weeks', style: Theme.of(context).textTheme.titleMedium),

        AppTextField(
          label: 'Cycle 1',
          onChanged: controller.distributionChanged,
          prefixText: '₱',
          controller: controller.distributionControllers[0],
          focusNode: controller.distributionFocusNodes[0],
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),

        AppTextField(
          label: 'Cycle 2',
          prefixText: '₱',
          onChanged: controller.distributionChanged,
          controller: controller.distributionControllers[1],
          focusNode: controller.distributionFocusNodes[0],
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),
      ],
    );
  }
}

class _YearlyFields extends GetView<CashflowController> {
  const _YearlyFields();

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Yearly Distribution',
          style: Theme.of(context).textTheme.titleMedium,
        ),

        ...List.generate(
          months.length,
          (index) => AppTextField(
            label: months[index],
            prefixText: '₱',
            onChanged: controller.distributionChanged,
            controller: controller.distributionControllers[index],
            focusNode: controller.distributionFocusNodes[index],
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ),
      ],
    );
  }
}

class _TwiceAMonthFields extends GetView<CashflowController> {
  const _TwiceAMonthFields();

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Distribution', style: Theme.of(context).textTheme.titleMedium),

        AppTextField(
          label: 'First Occurrence',
          prefixText: '₱',
          onChanged: controller.distributionChanged,
          controller: controller.distributionControllers[0],
          focusNode: controller.distributionFocusNodes[0],
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),

        AppTextField(
          label: 'Second Occurrence',
          prefixText: '₱',
          onChanged: controller.distributionChanged,
          controller: controller.distributionControllers[1],
          focusNode: controller.distributionFocusNodes[1],
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
        ),

        Obx(() {
          controller.distributionRevision.value;

          return _DistributionTotal(
            total: controller.distributionTotal,
            expected: controller.amount.value,
          );
        }),
      ],
    );
  }
}

class _DistributionTotal extends StatelessWidget {
  final double total;
  final double expected;

  const _DistributionTotal({required this.total, required this.expected});

  @override
  Widget build(BuildContext context) {
    final difference = total - expected;
    final isValid = difference.abs() < 0.01;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('Distribution Total'),
        Text(total.toCurrency(), style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }
}
