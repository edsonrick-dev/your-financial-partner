import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/budget_allocation_position.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_insight_type.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_position.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_status.dart';
import 'package:getx_drift_app/features/financial_insights/financial_profile_cashflow_controller_extension.dart';
import 'package:getx_drift_app/features/financial_insights/insight_engine.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CashflowInsightSheet extends GetView<FinancialProfileController> {
  const CashflowInsightSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSheet(
      title: 'Cashflow Insights',
      adaptiveHeight: true,
      height: AppSheetHeight.full,
      minHeightFactor: AppSheetHeight.threeQuarter,
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppSection(
              child: Obx(() {
                final insight = const InsightEngine().resolveCashflow(
                  controller.cashflowState,
                );

                if (insight == null) {
                  return const SizedBox.shrink();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      insight.title,
                      style: AppTextStyle.displayM,
                      textAlign: TextAlign.center,
                    ),

                    const SizedBox(height: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          insight.interpretation(controller),
                          style: AppTextStyle.bodyM.copyWith(
                            color: colorScheme.appText,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 16),

                        if (insight.type ==
                            CashflowInsightType.budgetExceedsIncome)
                          _IfBudgetExceedsIncome(
                            colorScheme: colorScheme,
                            controller: controller,
                          ),
                        if (controller.cashflowState.allocation ==
                            BudgetAllocationPosition.lessThanIdeal)
                          _LessThanIdeal(
                            colorScheme: colorScheme,
                            controller: controller,
                          ),
                        const SizedBox(height: 16),
                        Text(
                          'Your next step',
                          style: AppTextStyle.titleL,
                          textAlign: TextAlign.left,
                        ),

                        const SizedBox(height: 8),

                        Text(
                          insight.recommendedAction(controller),
                          style: AppTextStyle.bodyM,
                        ),
                      ],
                    ),
                  ],
                );
              }),
            ),
            SizedBox(height: context.bottomPaddingSub),
          ],
        ),
      ),
    );
  }
}

class _LessThanIdeal extends StatelessWidget {
  const _LessThanIdeal({required this.colorScheme, required this.controller});

  final ColorScheme colorScheme;
  final FinancialProfileController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final targetRatio =
                (controller.idealAnnualBudget / controller.annualIncome).clamp(
                  0.0,
                  1.0,
                );
            final budgetRatio =
                (controller.annualBudget / controller.annualIncome).clamp(
                  0.0,
                  1.0,
                );
            return Column(
              children: [
                SizedBox(
                  height: 16,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned(
                        width: 50,
                        left:
                            constraints.maxWidth * budgetRatio >=
                                constraints.maxWidth
                            ? constraints.maxWidth * budgetRatio - 50
                            : constraints.maxWidth * budgetRatio - 25,
                        child: Text(
                          '${(budgetRatio * 100).toStringAsFixed(1)}%',
                          style: AppTextStyle.amountXS.copyWith(
                            color: colorScheme.appAccent,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      height: 12,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorScheme.appText.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),

                    FractionallySizedBox(
                      widthFactor:
                          (targetRatio > budgetRatio
                                  ? controller.idealAnnualBudget /
                                        controller.annualIncome
                                  : controller.annualBudget /
                                        controller.annualIncome)
                              .clamp(0.0, 1.0),
                      child: Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: targetRatio > budgetRatio
                              ? colorScheme.appInflow
                              : colorScheme.appAccent.withValues(alpha: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor:
                          (targetRatio < budgetRatio
                                  ? controller.idealAnnualBudget /
                                        controller.annualIncome
                                  : controller.annualBudget /
                                        controller.annualIncome)
                              .clamp(0.0, 1.0),
                      child: Container(
                        height: 12,
                        decoration: BoxDecoration(
                          color: targetRatio < budgetRatio
                              ? colorScheme.appInflow
                              : colorScheme.appAccent.withValues(alpha: 1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ],
                ),
                Stack(
                  children: [
                    SizedBox(
                      height: 16,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Positioned(
                            left: constraints.maxWidth * targetRatio - 25,
                            width: 50,
                            child: Text(
                              '70%',
                              style: AppTextStyle.amountXS.copyWith(
                                color: colorScheme.appInflow,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Row(
                      children: [
                        SizedBox(width: 2),
                        Text(
                          0.toCurrency(symbol: ''),
                          style: AppTextStyle.amountXS,
                        ),

                        const Spacer(),

                        Text(
                          controller.annualIncome.toCurrency(symbol: ''),
                          style: AppTextStyle.amountXS,
                        ),
                        SizedBox(width: 2),
                      ],
                    ),
                  ],
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 16),
        IntrinsicHeight(
          child: Row(
            spacing: 8,
            children: [
              Expanded(
                child: AmountCard(
                  icon: PhosphorIconsRegular.coinVertical,
                  title: 'Your Income',
                  annual: controller.annualIncome,
                  monthly: controller.monthlyIncome,
                  // color: colorScheme.appBorderMuted,
                ),
              ),
              Expanded(
                child: AmountCard(
                  icon: PhosphorIconsRegular.wallet,
                  title: 'Your Budget',
                  annual: controller.annualBudget,
                  monthly: controller.monthlyBudget,
                  color: colorScheme.appAccent,
                ),
              ),
              Expanded(
                child: AmountCard(
                  icon: PhosphorIconsRegular.target,
                  title: '70% Target',
                  annual: controller.idealAnnualBudget,
                  monthly: controller.idealMonthlyBudget,
                  color: colorScheme.appInflow,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IfBudgetExceedsIncome extends StatelessWidget {
  const _IfBudgetExceedsIncome({
    required this.colorScheme,
    required this.controller,
  });

  final ColorScheme colorScheme;
  final FinancialProfileController controller;

  @override
  Widget build(BuildContext context) {
    double textWidth(BuildContext context, String text) {
      final textPainter = TextPainter(
        text: TextSpan(text: text, style: AppTextStyle.amountXS),
        maxLines: 1,
        textDirection: Directionality.of(context),
      )..layout();

      return textPainter.width;
    }

    return Column(
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final income = controller.annualIncome;
            final budget = controller.annualBudget;

            final maxValue = max(income, budget);

            final incomeRatio = maxValue == 0 ? 0.0 : income / maxValue;
            final budgetRatio = maxValue == 0 ? 0.0 : budget / maxValue;

            const labelWidth = 60.0;
            const labelGap = 4.0;
            const amountGap = 8.0;

            final incomeAmountWidth = textWidth(
              context,
              income.toCompactCurrency(),
            );

            final budgetAmountWidth = textWidth(
              context,
              budget.toCompactCurrency(),
            );

            final availableWidth =
                constraints.maxWidth -
                labelWidth -
                labelGap -
                amountGap -
                max(incomeAmountWidth, budgetAmountWidth);

            return Column(
              children: [
                _CashflowBarRow(
                  label: 'Income',
                  ratio: incomeRatio,
                  amount: income.toCompactCurrency(),
                  color: colorScheme.appInflow,
                  barWidth: availableWidth * incomeRatio,
                ),

                const SizedBox(height: 4),

                _CashflowBarRow(
                  label: 'Expense',
                  ratio: budgetRatio,
                  amount: budget.toCompactCurrency(),
                  color: colorScheme.appOutflow,
                  barWidth: availableWidth * budgetRatio,
                ),
              ],
            );
          },
        ),
        const SizedBox(height: 16),

        IntrinsicHeight(
          child: Row(
            spacing: 8,
            children: [
              Expanded(
                child: AmountCard(
                  icon: PhosphorIconsRegular.wallet,
                  title: 'Your Budget',
                  annual: controller.annualBudget,
                  monthly: controller.monthlyBudget,
                  color: colorScheme.appOutflow,
                ),
              ),

              Icon(PhosphorIconsRegular.greaterThan),

              Expanded(
                child: AmountCard(
                  icon: PhosphorIconsRegular.coinVertical,
                  title: 'Your Income',
                  annual: controller.annualIncome,
                  monthly: controller.monthlyIncome,
                  color: colorScheme.appInflow,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class AmountCard extends StatelessWidget {
  const AmountCard({
    super.key,
    required this.icon,
    required this.title,
    required this.annual,
    required this.monthly,
    this.color,
  });

  final String title;
  final double annual;
  final double monthly;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: color?.withValues(alpha: 0.2) ?? colorScheme.appNeutralSoft,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20),

          const SizedBox(height: 8),

          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyle.titleS,
          ),

          const SizedBox(height: 4),

          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              annual.toCompactCurrency(kThreshold: 10000),
              style: AppTextStyle.amountL,
            ),
          ),

          const SizedBox(height: 4),

          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              '${monthly.toCurrency()}/month',
              style: AppTextStyle.bodyS.copyWith(
                color: colorScheme.appText.withValues(alpha: 0.8),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CashflowBudgetTargetVisual extends StatelessWidget {
  final FinancialProfileController controller;

  const CashflowBudgetTargetVisual({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final income = controller.annualIncome;
    final budget = controller.annualBudget;
    final target = controller.idealAnnualBudget;

    if (income <= 0) {
      return const SizedBox.shrink();
    }

    final budgetProgress = (budget / income).clamp(0.0, 1.0);
    final targetProgress = (target / income).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: _Value(label: '70% Target', value: target.toCurrency()),
            ),
            Expanded(
              child: _Value(label: 'Your Budget', value: budget.toCurrency()),
            ),
            Expanded(
              child: _Value(label: 'Income', value: income.toCurrency()),
            ),
          ],
        ),

        const SizedBox(height: 16),

        LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 14,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(7),
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                  ),
                ),

                FractionallySizedBox(
                  widthFactor: targetProgress,
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),

                FractionallySizedBox(
                  widthFactor: budgetProgress,
                  child: Container(
                    height: 14,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7),
                    ),
                  ),
                ),

                Positioned(
                  left: constraints.maxWidth * targetProgress - 6,
                  top: -4,
                  child: _Marker(label: 'Target'),
                ),

                Positioned(
                  left: constraints.maxWidth * budgetProgress - 6,
                  top: 24,
                  child: _Marker(label: 'Budget'),
                ),
              ],
            );
          },
        ),

        const SizedBox(height: 56),

        Row(
          children: [
            Expanded(
              child: _Metric(
                label: 'Annual Income',
                value: income.toCurrency(),
              ),
            ),
            Expanded(
              child: _Metric(label: 'Your Budget', value: budget.toCurrency()),
            ),
            Expanded(
              child: _Metric(label: '70% Target', value: target.toCurrency()),
            ),
          ],
        ),
      ],
    );
  }
}

class _Value extends StatelessWidget {
  final String label;
  final String value;

  const _Value({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.bodyS),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyle.amountS),
      ],
    );
  }
}

class _Marker extends StatelessWidget {
  final String label;

  const _Marker({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(label, style: AppTextStyle.bodyS);
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;

  const _Metric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.bodyS),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyle.amountS),
      ],
    );
  }
}

class _CashflowBarRow extends StatelessWidget {
  const _CashflowBarRow({
    required this.label,
    required this.ratio,
    required this.amount,
    required this.color,
    required this.barWidth,
  });

  final String label;
  final double ratio;
  final String amount;
  final Color color;
  final double barWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 60, child: Text(label, style: AppTextStyle.labelM)),

        const SizedBox(width: 4),

        SizedBox(
          width: barWidth,
          child: Container(
            height: 12,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(999),
            ),
          ),
        ),

        const SizedBox(width: 8),

        Text(amount, style: AppTextStyle.amountXS),
      ],
    );
  }
}
