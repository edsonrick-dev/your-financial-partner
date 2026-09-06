import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/controller/bill_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/widgets/bill_row.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/enums/bill_budget_status_enum.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class BillBudgetNotice extends GetView<BillController> {
  const BillBudgetNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final category = controller.transactionController.selectedCategory.value;

      if (category == null) {
        return const SizedBox.shrink();
      }

      switch (controller.budgetStatus) {
        case BillBudgetStatus.unbudgeted:
          return _buildUnbudgeted(context, category.name);

        case BillBudgetStatus.fits:
          return _buildFits(context, category.name);

        case BillBudgetStatus.exceeds:
          return _buildExceeds(context, category.name);
      }
    });
  }

  Widget _buildUnbudgeted(BuildContext context, String categoryName) {
    final amount = controller.billAmount.value;
    final frequency = controller.selectedPeriod.value!.period;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.orange.withValues(alpha: 0.2),
        border: Border.all(color: Colors.orange),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(PhosphorIconsRegular.lightbulb),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      'No budget for $categoryName yet.',
                      style: AppTextStyle.headlineS,
                    ),
                    Text(
                      'Your new bill of '
                      '${amount.toCurrency()}/$frequency '
                      'will be used as the minimum budget for this category.',
                      style: AppTextStyle.bodyM,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          AppButton(
            text:
                'Create budget for '
                '${amount.toCurrency()}/$frequency',
            onTap: () {},
          ),
          SizedBox(height: 8),
          AppButton(
            type: ButtonType.outline,
            text: 'Set custom budget',
            onTap: () {},
          ),

          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(PhosphorIconsRegular.floppyDisk, size: 16),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  'This bill will be saved if you choose to adjust the budget.',
                  textAlign: TextAlign.center,
                  style: AppTextStyle.labelS,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFits(BuildContext context, String categoryName) {
    final colorScheme = context.colors;
    final amount = controller.billAmount.value;
    final budget = controller.selectedPeriodBudget;
    final frequency = controller.selectedPeriod.value!.period;
    final remaining = budget - amount;
    final color = colorScheme.appInflow;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(PhosphorIconsRegular.checkCircle),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      'This bill fits your $categoryName budget.',
                      style: AppTextStyle.headlineS,
                    ),
                    Text(
                      'Your new bill of '
                      '${amount.toCurrency()}/$frequency '
                      'is within your current budget for this category.',
                      style: AppTextStyle.bodyM,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          BillsRow(
            amount: budget,
            frequency: frequency,
            title: 'Current budget',
          ),

          BillsRow(
            amount: amount,
            frequency: frequency,
            title: 'New bill',
            isMain: false,
          ),

          BillsRow(amount: remaining, frequency: frequency, title: 'Remaining'),
          const SizedBox(height: 20),
          AppButton(text: 'Save Bill', onTap: () {}),
        ],
      ),
    );
  }

  Widget _buildExceeds(BuildContext context, String categoryName) {
    final budget = controller.selectedPeriodBudget;
    final amount = controller.billAmount.value;
    final frequency = controller.selectedPeriod.value!.period;
    final over = amount - budget;
    final colorScheme = context.colors;
    final color = colorScheme.appOutflow;
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(PhosphorIconsRegular.warningCircle),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  spacing: 8,
                  children: [
                    Text(
                      'This bill exceeds your $categoryName budget.',
                      style: AppTextStyle.headlineS,
                    ),
                    Text(
                      'Your new bill of '
                      '${amount.toCurrency()}/$frequency '
                      'is more than your current budget for this category.',
                      style: AppTextStyle.bodyM,
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          BillsRow(
            amount: budget,
            frequency: frequency,
            title: 'Current budget',
          ),

          BillsRow(amount: amount, frequency: frequency, title: 'New bill'),

          BillsRow(amount: over, frequency: frequency, title: 'Over budget'),

          const SizedBox(height: 20),

          AppButton(
            // isInversed: true,
            text:
                'Increase budget by '
                '${over.toCurrency()}/$frequency',
            onTap: () {},
          ),
          const SizedBox(height: 16),
          AppButton(
            type: ButtonType.outline,
            text: 'Set custom budget',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
