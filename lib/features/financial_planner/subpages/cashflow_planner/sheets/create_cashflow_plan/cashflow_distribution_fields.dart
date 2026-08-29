import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/domain/enums/app_day.dart';
import 'package:getx_drift_app/domain/enums/app_month.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_header.dart';

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
        BudgetPeriod.weekly => const _WeeklyFields(),
        BudgetPeriod.fortnightly => const _FortnightlyFields(),
        BudgetPeriod.monthly => const _TwiceAMonthFields(),
        BudgetPeriod.yearly => const _YearlyFields(),
      };
    });
  }
}

class _WeeklyFields extends GetView<CashflowController> {
  const _WeeklyFields();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Text(
        //   'Weekly Distribution',
        //   style: Theme.of(context).textTheme.titleMedium,
        // ),
        Text('Set a different amount for each day ', style: AppTextStyle.bodyM),
        SizedBox(height: 12),
        Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...AppDay.values.map(
              (day) => Obx(
                () => AppAmountField(
                  label: day.fullName,
                  amount: controller.distributionAmounts[day.index].value,
                  onChanged: (value) {
                    controller.distributionAmounts[day.index].value = value;
                  },
                ),
              ),
            ),
          ],
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Set a different amount for each 2-week cycle',
          style: AppTextStyle.bodyM,
        ),
        SizedBox(height: 12),
        Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => AppAmountField(
                label: '1st Cycle',
                amount: controller.distributionAmounts[0].value,
                onChanged: (value) {
                  controller.distributionAmounts[0].value = value;
                },
              ),
            ),

            Obx(
              () => AppAmountField(
                label: '2nd Cycle',
                amount: controller.distributionAmounts[1].value,
                onChanged: (value) {
                  controller.distributionAmounts[1].value = value;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _YearlyFields extends GetView<CashflowController> {
  const _YearlyFields();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Set a different amount for each month',
          style: AppTextStyle.bodyM,
        ),
        SizedBox(height: 12),
        Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Yearly Distribution',
              style: Theme.of(context).textTheme.titleMedium,
            ),

            ...AppMonth.values.map(
              (month) => Obx(
                () => AppAmountField(
                  label: month.fullName,
                  amount: controller.distributionAmounts[month.index].value,
                  onChanged: (value) {
                    controller.distributionAmounts[month.index].value = value;
                  },
                ),
              ),
            ),
          ],
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Set a different amount for each half of the month',
          style: AppTextStyle.bodyM,
        ),
        SizedBox(height: 12),
        Column(
          spacing: 12,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Text(
            //   'Distribution',
            //   style: Theme.of(context).textTheme.titleMedium,
            // ),
            Obx(
              () => AppAmountField(
                label: 'First Half',
                amount: controller.distributionAmounts[0].value,
                onChanged: (value) {
                  controller.distributionAmounts[0].value = value;
                },
              ),
            ),

            Obx(
              () => AppAmountField(
                label: 'Second Half',
                amount: controller.distributionAmounts[1].value,
                onChanged: (value) {
                  controller.distributionAmounts[1].value = value;
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
