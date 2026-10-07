import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/controller/savings_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/calculator/emergency_fund_calculator.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

class EmergencyFundFAQs extends GetView<SavingsPlannerController> {
  const EmergencyFundFAQs({
    super.key,
    required this.goal,
    required this.currentAmount,
  });

  final GoalsTableData goal;
  final double currentAmount;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final monthlyBudget = controller.financialProfileController.monthlyBudget;

    final netMonthlyCashFlow = controller.disposableIncome / 12;

    final calculator = EmergencyFundCalculator(
      currentAmount: currentAmount,
      monthlyBudget: monthlyBudget,
      netMonthlyCashFlow: netMonthlyCashFlow,
    );
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
          child: Column(
            spacing: 20,
            children: [
              AppSection(
                sectionTitle: 'When can I achieve this?',
                child: AppSectionBody(
                  padding: 16,
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _MetricRow(
                        title: 'Fund Gap',
                        trailing: calculator.remainingToTarget.toCurrency(),
                      ),
                      _MetricRow(
                        title: 'Monthly Contribution',
                        trailing: calculator.monthlyEmergencyFundContribution
                            .toCurrency(),
                      ),

                      Text(
                        'Fund Gap / Monthly Contribution',
                        style: AppTextStyle.labelM.copyWith(
                          fontStyle: FontStyle.italic,
                          color: colorScheme.appInversedtextMuted,
                        ),
                      ),
                      Divider(color: colorScheme.appInversedtext),
                      _MetricRow(
                        title: 'Achievable In',
                        trailing: '${calculator.monthsToTarget!.ceil()} months',
                      ),
                    ],
                  ),
                ),
              ),
              AppSection(
                sectionTitle: 'How much do I need?',
                child: AppSectionBody(
                  padding: 16,
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _MetricRow(
                        title: 'Planned Monthly Expense',
                        trailing: controller
                            .financialProfileController
                            .monthlyBudget
                            .toCurrency(),
                      ),
                      _MetricRow(
                        title: 'Coverage Target',
                        trailing: '12 months',
                      ),

                      Text(
                        'Monthly Expenses x Coverage Target',
                        style: AppTextStyle.labelM.copyWith(
                          fontStyle: FontStyle.italic,
                          color: colorScheme.appInversedtextMuted,
                        ),
                      ),
                      Divider(color: colorScheme.appInversedtext),
                      _MetricRow(
                        title: 'Target Amount',
                        trailing: goal.targetAmount.toCurrency(),
                      ),
                    ],
                  ),
                ),
              ),
              AppSection(
                sectionTitle: 'How many months can my fund cover?',
                child: AppSectionBody(
                  padding: 16,
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _MetricRow(
                        title: 'Current Amount',
                        trailing: currentAmount.toCurrency(),
                      ),
                      _MetricRow(
                        title: 'Monthly Expense',
                        trailing: controller
                            .financialProfileController
                            .monthlyBudget
                            .toCurrency(),
                      ),

                      Text(
                        'Current Amount / Monthly Expense',
                        style: AppTextStyle.labelM.copyWith(
                          fontStyle: FontStyle.italic,
                          color: colorScheme.appInversedtextMuted,
                        ),
                      ),
                      Divider(color: colorScheme.appInversedtext),
                      _MetricRow(
                        title: 'Months Covered',
                        trailing:
                            '${calculator.currentMonths.toStringAsFixed(1)} months',
                      ),
                    ],
                  ),
                ),
              ),
              // AppSection(
              //   sectionTitle: 'How much do I set aside for this goal?',
              //   child: AppSectionBody(
              //     padding: 16,
              //     child: Column(
              //       spacing: 16,
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         _MetricRow(
              //           title: 'Current Amount',
              //           trailing: currentAmount.toCurrency(),
              //         ),
              //         _MetricRow(
              //           title: 'Monthly Expense',
              //           trailing: controller
              //               .financialProfileController
              //               .monthlyBudget
              //               .toCurrency(),
              //         ),

              //         Text(
              //           'Current Amount / Monthly Expense',
              //           style: AppTextStyle.labelM.copyWith(
              //             fontStyle: FontStyle.italic,
              //             color: colorScheme.appInversedtextMuted,
              //           ),
              //         ),
              //         Divider(color: colorScheme.appInversedtext),
              //         _MetricRow(
              //           title: 'Months Covered',
              //           trailing:
              //               '${calculator.currentMonths.toStringAsFixed(1)} months',
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              AppSection(
                sectionTitle: 'How is my required allocation computed?',
                child: AppSectionBody(
                  padding: 16,
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        spacing: 8,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _MetricRow(
                            title: 'Your Emergency Fund Milestone',
                            trailing: calculator.currentStage,
                          ),
                          // Container(
                          //   padding: EdgeInsets.symmetric(
                          //     horizontal: 8,
                          //     vertical: 8,
                          //   ),
                          //   decoration: BoxDecoration(
                          //     color: colorScheme.bg,
                          //     borderRadius: BorderRadius.circular(8),
                          //   ),
                          //   child: Text(
                          //     'Your months covered fall within this milestone.',
                          //     style: AppTextStyle.bodyM,
                          //   ),
                          // ),
                        ],
                      ),

                      _MetricRow(
                        title: 'Milestone Allocation',
                        trailing:
                            '${(calculator.emergencyFundRate * 100).toStringAsFixed(0)}%',
                      ),

                      _MetricRow(
                        title: 'Monthly Net Cashflow',
                        trailing: calculator.netMonthlyCashFlow.toCurrency(),
                      ),

                      Text(
                        'Allocation x Monthly Net Cashflow',
                        style: AppTextStyle.labelM.copyWith(
                          fontStyle: FontStyle.italic,
                          color: colorScheme.appInversedtextMuted,
                        ),
                      ),
                      Divider(color: colorScheme.appInversedtext),

                      _MetricRow(
                        title: 'Monthly Allocation',
                        trailing: calculator.monthlyEmergencyFundContribution
                            .toCurrency(),
                      ),
                    ],
                  ),
                ),
              ),

              AppSection(
                sectionTitle: 'What are the milestone allocations?',
                child: AppSectionBody(
                  padding: 16,
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Milestone', style: AppTextStyle.titleM),
                          Text('Allocation', style: AppTextStyle.titleM),
                        ],
                      ),
                      _MetricRow(title: 'Less than 3 months', trailing: '100%'),
                      _MetricRow(title: '3–6 months', trailing: '75%'),
                      _MetricRow(title: '6–12 months', trailing: '50%'),
                      _MetricRow(title: '12 months and beyond', trailing: '0%'),
                      Text(
                        'Your current milestone: ${calculator.currentStage}',
                        style: AppTextStyle.bodyM.copyWith(
                          color: colorScheme.appText,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              AppSection(
                sectionTitle:
                    'Why does my allocation changes as milestone change',
                child: AppSectionBody(
                  padding: 16,
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your emergency fund becomes more secure as you '
                        'build more months of expense coverage. As your '
                        'fund reaches higher milestones, Ascend suggests gradually '
                        'reducing the portion of your net cash flow allocated '
                        'to the emergency fund so you can direct more money '
                        'toward other financial goals.',
                        style: AppTextStyle.bodyL,
                      ),
                    ],
                  ),
                ),
              ),
              AppSection(
                sectionTitle: 'Why do I need an emergency fund?',
                child: AppSectionBody(
                  padding: 16,
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'An emergency fund gives you a financial cushion for '
                        'unexpected expenses or income disruptions. By keeping '
                        'these funds readily available, you can handle '
                        'emergencies without taking on debt or withdrawing '
                        'money from investments meant for your long-term goals.',
                        style: AppTextStyle.bodyL,
                      ),
                    ],
                  ),
                ),
              ),
              AppSection(
                sectionTitle: 'Why is my target 12 months?',
                child: AppSectionBody(
                  padding: 16,
                  child: Column(
                    spacing: 16,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ascend uses 12 months of planned expenses as the '
                        'emergency-fund target to provide a stronger '
                        'financial cushion against prolonged income '
                        'disruptions or unexpected expenses.',
                        style: AppTextStyle.bodyL,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({required this.title, required this.trailing});
  final String title;
  final String trailing;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Expanded(
          child: Text(
            title,
            style: AppTextStyle.titleL.copyWith(color: colorScheme.appText),
          ),
        ),
        SizedBox(width: 16),
        Text(trailing, style: AppTextStyle.amountL),
      ],
    );
  }
}
