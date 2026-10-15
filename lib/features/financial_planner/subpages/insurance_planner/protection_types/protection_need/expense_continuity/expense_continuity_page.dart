import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_gradient_card.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_year.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/controller/protection_questionnaire_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/expense_continuity/inputs/protection_continuity/protection_continuity_fund_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/expense_continuity/inputs/protection_horizon/protection_horizon_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_needs/expense_continuity/investment_return_disclaimer.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class ExpenseContinuityPage extends GetView<ProtectionQuestionnaireController> {
  const ExpenseContinuityPage({super.key, required this.type});
  final ProtectionType type;
  List<Widget> buildProjectionRows({
    required BuildContext context,
    required List<ExpenseContinuityYear> projection,
    required int planValidityYears,
    required DateTime planDate,
    required bool showAllYears,
  }) {
    Widget buildRow(ExpenseContinuityYear item) {
      final yearsFromNow = planValidityYears + item.year - 1;
      final calendarYear = planDate.year + yearsFromNow;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(calendarYear.toString(), style: AppTextStyle.titleM),
                  Text(
                    'After $yearsFromNow years · Year ${item.year}',
                    style: AppTextStyle.labelM.copyWith(
                      color: context.colors.appTextMuted,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(item.withdrawal.toCurrency(), style: AppTextStyle.amountM),
          ],
        ),
      );
    }

    if (showAllYears || projection.length <= 4) {
      return projection.map(buildRow).toList();
    }

    return [
      ...projection.take(2).map(buildRow),
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Center(child: Text('···')),
      ),
      ...projection.skip(projection.length - 2).map(buildRow),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return FutureBuilder(
      future: database.protectionDao.getActiveProtectionPlan(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Failed to load protection plan.'));
        }

        final protectionPlan = snapshot.data;

        if (protectionPlan == null) {
          return const Center(child: Text('No protection plan found.'));
        }
        controller.ensureExpenseContinuityResultLoaded(
          protectionPlanId: protectionPlan.id,
          inflationRate: 0.03,
          portfolioReturn: 0.06,
          protectionType: type,
        );

        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
          child: Column(
            children: [
              Obx(() {
                final result = controller.expenseContinuityResults[type];
                final isEditing = controller.isEditingExpenseContinuity(type);
                if (result == null || isEditing) {
                  return _ExpenseContinuityInputSection(
                    type: type,
                    protectionPlan: protectionPlan,
                    controller: controller,
                    hasExistingResult: result != null,
                  );
                }

                return Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: Column(
                    children: [
                      AppSection(
                        child: AppGradientCard(
                          padding: 16,
                          child: Column(
                            spacing: 8,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Expense Continuity Fund',
                                style: AppTextStyle.titleL.copyWith(
                                  color: colorScheme.appInversedtextMuted,
                                ),
                              ),

                              Text(
                                result.investedNeed.toCurrency(),
                                style: AppTextStyle.amountXL.copyWith(
                                  color: colorScheme.appInversedtext,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      AppSection(
                        sectionTitle: 'Fund Computation',
                        child: Column(
                          spacing: 20,
                          children: [
                            AppSectionBody(
                              padding: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          type.continuityFundTitle,
                                          style: AppTextStyle.titleL,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Obx(() {
                                        final monthlyAmount =
                                            controller
                                                .continuityMonthlyTotals[type] ??
                                            0.0;
                                        final annualAmount = monthlyAmount * 12;

                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              annualAmount.toCurrency(),
                                              style: AppTextStyle.amountL,
                                            ),
                                            Text(
                                              '${monthlyAmount.toCurrency()}/mo',
                                              style: AppTextStyle.amountS,
                                            ),
                                          ],
                                        );
                                      }),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    type.continuityFundDescription,
                                    style: AppTextStyle.labelM.copyWith(
                                      color: context.colors.appTextMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            AppSectionBody(
                              padding: 20,
                              child: Obx(() {
                                final result =
                                    controller.expenseContinuityResults[type];
                                final planDate = protectionPlan.startDate;
                                if (result == null) {
                                  return const SizedBox.shrink();
                                }

                                final isExpanded = controller
                                    .isProjectionExpanded(type);

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Projected Living Expenses',
                                      style: AppTextStyle.titleL,
                                    ),
                                    // const SizedBox(height: 8),
                                    Text(
                                      'Based on 3% inflation.',
                                      style: AppTextStyle.labelM.copyWith(
                                        color: context.colors.appTextMuted,
                                      ),
                                    ),
                                    const SizedBox(height: 16),

                                    ...buildProjectionRows(
                                      context: context,
                                      projection: result.projection,
                                      planValidityYears: 5,
                                      planDate: planDate,
                                      showAllYears: isExpanded,
                                    ),

                                    if (result.projection.length > 4)
                                      Align(
                                        alignment: Alignment.center,
                                        child: TextButton(
                                          onPressed: () => controller
                                              .toggleProjectionExpanded(type),
                                          child: Text(
                                            isExpanded
                                                ? 'Show less'
                                                : 'Show all years',
                                          ),
                                        ),
                                      ),

                                    const Divider(height: 24),

                                    Row(
                                      children: [
                                        const Expanded(
                                          child: Text(
                                            'Total Expense Need',
                                            style: AppTextStyle.titleL,
                                          ),
                                        ),
                                        Text(
                                          result.uninvestedNeed.toCurrency(),
                                          style: AppTextStyle.amountL,
                                        ),
                                      ],
                                    ),

                                    const SizedBox(height: 4),

                                    Text(
                                      'Total projected expenses over ${result.projection.length} years.',
                                      style: AppTextStyle.labelM.copyWith(
                                        color: context.colors.appTextMuted,
                                      ),
                                    ),
                                  ],
                                );
                              }),
                            ),
                            AppSectionBody(
                              padding: 20,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your Required Continuity Fund',
                                    style: AppTextStyle.titleL,
                                  ),
                                  Text(
                                    "The estimated amount you would need to cover the living expenses throughout the support period.",
                                    style: AppTextStyle.labelM.copyWith(
                                      color: colorScheme.appTextMuted,
                                    ),
                                  ),

                                  const SizedBox(height: 20),
                                  // Amount needed without investment growth
                                  Column(
                                    spacing: 16,
                                    children: [
                                      _ContinuityRow(
                                        title: 'Uninvested Fund Requirement',
                                        amount: result.uninvestedNeed,
                                        helper:
                                            'The total projected expenses if the fund earns no investment returns.',
                                      ),
                                      _ContinuityRow(
                                        title: 'Invested Fund Requirement',
                                        amount: result.investedNeed,
                                        helper:
                                            'The lump sum needed if the fund is invested and earns the assumed return.',
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 8),
                                  Text(
                                    'Potential Reduction: Uninvested - Invested',
                                    style: AppTextStyle.labelM.copyWith(
                                      color: colorScheme.appTextMuted,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),

                                  const Divider(height: 32),
                                  _ContinuityRow(
                                    title: 'Potential Savings from Investing',
                                    amount:
                                        (result.uninvestedNeed -
                                        result.investedNeed),
                                    helper:
                                        'The estimated reduction in the amount you need upfront by investing the fund.',
                                  ),
                                ],
                              ),
                            ),
                            AppButton(
                              text: 'Edit Plan',
                              onTap: () {
                                controller.startEditingExpenseContinuity(type);
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Column(children: [InvestmentReturnDisclaimer()]),
                    ],
                  ),
                );
              }),
            ],
          ),
        );
      },
    );
  }
}

class _ExpenseContinuityInputSection extends StatelessWidget {
  const _ExpenseContinuityInputSection({
    required this.type,
    required this.protectionPlan,
    required this.controller,
    required this.hasExistingResult,
  });

  final ProtectionType type;
  final ProtectionPlansTableData protectionPlan;
  final ProtectionQuestionnaireController controller;
  final bool hasExistingResult;
  @override
  Widget build(BuildContext context) {
    return AppSection(
      sectionTitle: 'Fund Inputs',
      child: Column(
        spacing: 20,
        children: [
          ProtectionHorizonCard(
            type: type,
            planEndDate: protectionPlan.endDate,
          ),
          ProtectionContinuityFundCard(type: type),
          Obx(() {
            final isComputing = controller.isComputingExpenseContinuity.value;

            final hasMonthlyTotal = controller.continuityMonthlyTotals
                .containsKey(type);

            return Column(
              children: [
                AppButton(
                  text: isComputing
                      ? 'Computing...'
                      : hasExistingResult
                      ? 'Recompute Plan'
                      : 'Compute Plan',
                  onTap: isComputing || !hasMonthlyTotal
                      ? null
                      : () async {
                          final success = await controller
                              .computeExpenseContinuity(
                                protectionPlanId: protectionPlan.id,
                                protectionType: type,
                                currentAge: 28,
                                retirementAge: 60,
                                planValidityYears: 5,
                                inflationRate: 0.03,
                                portfolioReturn: 0.06,
                              );

                          if (!success) return;

                          controller
                                  .expandedExpenseContinuityProjections[type] =
                              false;

                          // Return to the results section.
                          controller.cancelEditingExpenseContinuity(type);
                        },
                ),

                if (hasExistingResult) ...[
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: isComputing
                        ? null
                        : () {
                            controller.cancelEditingExpenseContinuity(type);
                          },
                    child: const Text('Cancel'),
                  ),
                ],
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _ContinuityRow extends StatelessWidget {
  const _ContinuityRow({
    required this.amount,
    required this.title,
    required this.helper,
  });

  final double amount;
  final String title;
  final String helper;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: Text(title, style: AppTextStyle.titleM)),
            SizedBox(width: 16),
            Text(amount.toCurrency(), style: AppTextStyle.amountL),
          ],
        ),
        Text(
          helper,
          style: AppTextStyle.bodyS.copyWith(color: colorScheme.appTextMuted),
        ),
      ],
    );
  }
}

class FundResultRow extends StatelessWidget {
  const FundResultRow({
    super.key,
    required this.title,
    required this.amount,
    required this.subtitle,
  });

  final String title;
  final double amount;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 4),
        Text(subtitle),
        const SizedBox(height: 4),
        Text(
          amount.toCurrency(),
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
