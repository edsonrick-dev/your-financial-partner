import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_gradient_card.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_fund_details_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_year.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/1_protection_horizon_questionnaire/protection_horizon_questionnaire_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/benefits/expense_continuity/expense_continuity_questionnaire.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/benefits/expense_continuity/investment_return_disclaimer.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/home/bindings/protection_questionnaire_binding.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:intl/intl.dart';

class ExpenseContinuityFundDetailsSheet extends StatefulWidget {
  const ExpenseContinuityFundDetailsSheet({
    super.key,
    required this.data,
    required this.type,
  });

  final ExpenseContinuityFundDetailsData data;
  final ProtectionType type;

  @override
  State<ExpenseContinuityFundDetailsSheet> createState() =>
      _ExpenseContinuityFundDetailsSheetState();
}

class _ExpenseContinuityFundDetailsSheetState
    extends State<ExpenseContinuityFundDetailsSheet> {
  bool _showAllYears = false;
  List<Widget> buildProjectionRows({
    required ExpenseContinuityFundDetailsData data,
    required List<ExpenseContinuityYear> projection,
    required bool showAllYears,
  }) {
    final rows = <Widget>[];

    _ProjectionRow buildRow(ExpenseContinuityYear item) {
      final yearsFromNow = data.planValidityYears + item.year - 1;
      final calendarYear = data.planDate.year + yearsFromNow;

      return _ProjectionRow(
        amount: item.withdrawal,
        fromNow: yearsFromNow,
        year: calendarYear,
        yearCount: item.year,
      );
    }

    if (showAllYears || projection.length <= 4) {
      return projection.map(buildRow).toList();
    }

    rows.addAll(projection.take(2).map(buildRow));

    rows.add(
      Center(
        child: Text(
          '...',
          style: AppTextStyle.titleM.copyWith(color: Colors.grey),
        ),
      ),
    );

    rows.addAll(projection.skip(projection.length - 2).map(buildRow));

    return rows;
  }

  @override
  Widget build(BuildContext context) {
    final insuranceController = Get.find<InsurancePlannerController>();

    final data = widget.type == ProtectionType.death
        ? insuranceController.deathBenefitResult.value!.expenseContinuityDetails
        : widget.data;

    final type = widget.type;

    final colorScheme = context.colors;

    final dateFormat = DateFormat('MMM d, yyyy');
    final yearFormat = DateFormat('yyyy');

    final planDate = data.planDate;
    final supportStartDate = data.supportStartDate;
    final supportEndDate = data.supportEndDate;

    return AppSheet(
      height: AppSheetHeight.full,
      title: 'Expense Continuity Fund',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: Column(
          spacing: 20,
          children: [
            AppSection(
              sectionTitle: 'Fund Inputs',
              child: Column(
                spacing: 20,
                children: [
                  _protectionHorizon(
                    type,
                    data,
                    colorScheme,
                    yearFormat,
                    supportStartDate,
                    supportEndDate,
                  ),
                  _expenseContinuity(
                    colorScheme,
                    yearFormat,
                    data,
                    context,
                    type,
                  ),
                ],
              ),
            ),

            AppSection(
              sectionTitle: 'Fund Computation',
              child: Column(
                spacing: 20,
                children: [
                  AppSectionBody(
                    padding: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Projected Annual Expenses',
                          style: AppTextStyle.titleL,
                        ),
                        Text(
                          'Based on ${(data.inflationRate * 100).toStringAsFixed(1)}% annual inflation',
                          style: AppTextStyle.labelM.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),

                        SizedBox(height: 16),

                        Column(
                          spacing: 8,
                          children: buildProjectionRows(
                            data: data,
                            projection: data.result.projection,
                            showAllYears: _showAllYears,
                          ),
                        ),
                        const Divider(height: 24),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Total Expense Need',
                                        style: AppTextStyle.titleL,
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  data.result.uninvestedNeed.toCurrency(),
                                  style: AppTextStyle.amountL,
                                ),
                              ],
                            ),
                            Text(
                              'Sum of projected expenses over ${data.supportYears} years',
                              style: AppTextStyle.labelM.copyWith(
                                color: colorScheme.appTextMuted,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 16),
                        AdaptivePressable(
                          onTap: () {
                            setState(() {
                              _showAllYears = !_showAllYears;
                            });
                          },
                          child: Center(
                            child: Text(
                              _showAllYears ? 'Show less' : 'Show all years',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSectionBody(
                    padding: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Required Expense Continuity Fund',
                          style: AppTextStyle.titleL,
                        ),
                        Text(
                          "Estimate how much your dependents would need to maintain their lifestyle if you're no longer around.",
                          style: AppTextStyle.labelM.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Amount needed if invested
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Invested Fund Requirement',
                                    style: AppTextStyle.titleM,
                                  ),
                                  Text(
                                    'Lump sum needed today',
                                    style: AppTextStyle.labelM.copyWith(
                                      color: colorScheme.appTextMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              data.result.investedNeed.toCurrency(),
                              style: AppTextStyle.amountL,
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // Amount needed without investment growth
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Uninvested Fund Requirement',
                                    style: AppTextStyle.titleM,
                                  ),
                                  Text(
                                    'Total projected expenses',
                                    style: AppTextStyle.labelM.copyWith(
                                      color: colorScheme.appTextMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              data.result.uninvestedNeed.toCurrency(),
                              style: AppTextStyle.amountL,
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        const Divider(),

                        const SizedBox(height: 8),

                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Potential Reduction',
                                    style: AppTextStyle.titleM,
                                  ),
                                  Text(
                                    'Difference from the uninvested requirement',
                                    style: AppTextStyle.labelM.copyWith(
                                      color: colorScheme.appTextMuted,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              (data.result.uninvestedNeed -
                                      data.result.investedNeed)
                                  .toCurrency(),
                              style: AppTextStyle.amountL,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              spacing: 20,
              children: [
                AppSection(
                  child: AdaptivePressable(
                    onTap: () {
                      showDialog<void>(
                        context: context,
                        builder: (dialogContext) {
                          return _HowThisWorks();
                        },
                      );
                    },
                    child: AppGradientCard(
                      child: Column(
                        spacing: 8,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'How does this work?',
                                  style: AppTextStyle.titleM.copyWith(
                                    fontStyle: FontStyle.italic,
                                    color: colorScheme.appInversedtext,
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.info_outline,
                                    size: 20,
                                    color: context.colors.appInversedtextMuted,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            "Learn how investing life insurance proceeds may reduce the lump sum needed to support your dependent's future expenses.",
                            style: AppTextStyle.labelM.copyWith(
                              color: colorScheme.appInversedtextMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                AppSection(
                  child: Opacity(
                    opacity: 0.8,
                    child: Text(
                      'Plan Created on ${dateFormat.format(planDate)} • Valid until ${yearFormat.format(supportStartDate)} (${data.planValidityYears} year validity)',
                    ),
                  ),
                ),
                InvestmentReturnDisclaimer(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  AppCard _expenseContinuity(
    ColorScheme colorScheme,
    DateFormat yearFormat,
    ExpenseContinuityFundDetailsData data,
    BuildContext context,
    ProtectionType type,
  ) {
    return AppCard(
      onTap: () async {
        debugPrint('CONTINUITY CARD: tapped');
        await Get.to(
          () => ExpenseContinuityQuestionnaire(type: type),
          binding: ProtectionQuestionnaireBinding(),
          preventDuplicates: false,
        );
        debugPrint('CONTINUITY CARD: Get.to returned');
        if (!mounted) return;

        if (type == ProtectionType.death) {
          final insuranceController = Get.find<InsurancePlannerController>();

          await insuranceController.calculateDeathBenefit();

          if (!mounted) return;

          setState(() {});
        }
      },
      padding: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Dependents' Annual Expenses", style: AppTextStyle.titleL),
          Text(
            "Today's cost of maintaning your dependent's lifestyle, before inflation",
            style: AppTextStyle.labelM.copyWith(
              color: colorScheme.appTextMuted,
            ),
          ),

          SizedBox(height: 16),
          Column(
            spacing: 8,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Annual', style: AppTextStyle.titleM),
                        Text(
                          yearFormat.format(data.planDate),
                          style: AppTextStyle.bodyS.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        data.currentAnnualExpenses.toCurrency(),
                        style: AppTextStyle.amountL,
                      ),
                      Text(
                        '${data.monthlyExpense.toCurrency()}/mo',
                        style: AppTextStyle.amountS.copyWith(
                          color: context.colors.appTextMuted,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  AppCard _protectionHorizon(
    ProtectionType type,
    ExpenseContinuityFundDetailsData data,
    ColorScheme colorScheme,
    DateFormat yearFormat,
    DateTime supportStartDate,
    DateTime supportEndDate,
  ) {
    return AppCard(
      onTap: () async {
        debugPrint('Horizon card tapped: $type');

        await Get.to(
          () => ProtectionHorizonQuestionnaire(type: type),
          binding: ProtectionQuestionnaireBinding(),
        );
        debugPrint('Horizon questionnaire closed: $type');
        if (!mounted) return;

        if (type == ProtectionType.death) {
          final insuranceController = Get.find<InsurancePlannerController>();

          await insuranceController.calculateDeathBenefit();

          if (!mounted) return;
          setState(() {});
        }
      },
      padding: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text('Protection Horizon', style: AppTextStyle.titleL),
              ),
              Text('${data.supportYears} years', style: AppTextStyle.amountL),
            ],
          ),
          Text(
            'How long your dependent needs financial support after your death.',

            style: AppTextStyle.labelM.copyWith(
              color: colorScheme.appTextMuted,
            ),
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Text('Coverage period: ', style: AppTextStyle.bodyM),
              ),
              Text(
                '${yearFormat.format(supportStartDate)} '
                '- ${yearFormat.format(supportEndDate)}',
                style: AppTextStyle.amountM,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HowThisWorks extends StatelessWidget {
  const _HowThisWorks();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'How does the Expense Continuity Fund work?',
                style: AppTextStyle.titleL,
              ),
              Text(
                'Your dependent may need money to cover everyday '
                'living expenses if you are no longer around.',
              ),

              const SizedBox(height: 16),

              Text('1. Estimate future expenses', style: AppTextStyle.titleM),
              const SizedBox(height: 4),
              const Text(
                'We project your dependent’s living expenses over '
                'your selected protection period, accounting '
                'for annual inflation.',
              ),

              const SizedBox(height: 16),

              Text('2. Invest the lump sum', style: AppTextStyle.titleM),
              const SizedBox(height: 4),
              const Text(
                'Instead of setting aside enough money to cover '
                'every future expense upfront, your dependent could '
                'invest the lump sum and withdraw money each '
                'year to pay for living expenses.',
              ),

              const SizedBox(height: 16),

              Text(
                '3. Account for investment growth',
                style: AppTextStyle.titleM,
              ),
              const SizedBox(height: 4),
              const Text(
                'If the investment earns returns, some future '
                'expenses may be funded by those returns. Your '
                'dependent may therefore need a smaller amount '
                'upfront than if the money were not invested.',
              ),

              const SizedBox(height: 16),

              Text('4. Understand the difference', style: AppTextStyle.titleM),
              const SizedBox(height: 8),

              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Invested Fund Requirement: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text:
                          'The estimated lump sum needed '
                          'today, assuming investment returns '
                          'and withdrawals cover projected expenses.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Uninvested Fund Requirement: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text:
                          'The total projected expenses '
                          'over the entire protection period, '
                          'assuming no investment returns.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Text.rich(
                TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Potential Reduction: ',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const TextSpan(
                      text:
                          'The difference between the '
                          'invested and uninvested requirements.',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Important: Investment returns are not '
                'guaranteed. Actual results depend on '
                'investment performance, fees, taxes, and '
                'the timing of withdrawals.',
                style: AppTextStyle.labelM.copyWith(
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
      // title: Text(
      //   'How does the Expense Continuity Fund work?',
      //   style: AppTextStyle.titleL,
      // ),
      // content:
      //    actions: [
      //   TextButton(
      //     onPressed: () => Navigator.of(
      //       dialogContext,
      //     ).pop(),
      //     child: const Text('Got it'),
      //   ),
      // ],
    );
  }
}

class _ProjectionRow extends StatelessWidget {
  const _ProjectionRow({
    required this.year,
    required this.amount,
    required this.fromNow,
    required this.yearCount,
  });

  final int year;
  final int fromNow;
  final int yearCount;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(year.toString(), style: AppTextStyle.titleM),
              Text(
                'After $fromNow years • Year $yearCount',
                style: AppTextStyle.bodyS.copyWith(
                  color: colorScheme.appTextMuted,
                ),
              ),
            ],
          ),
        ),
        Text(amount.toCurrency(), style: AppTextStyle.amountL),
      ],
    );
  }
}
