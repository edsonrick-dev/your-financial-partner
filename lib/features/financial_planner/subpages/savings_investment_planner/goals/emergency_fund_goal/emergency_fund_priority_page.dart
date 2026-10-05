import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/calculator/emergency_fund_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/emergency_fund_allocation_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/emergency_fund_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EmergencyFundPriorityPage extends GetView<EmergencyFundController> {
  const EmergencyFundPriorityPage({
    super.key,
    required this.currentAmount,
    required this.monthlyBudget,
    required this.netMonthlyCashFlow,
  });

  final double currentAmount;
  final double monthlyBudget;
  final double netMonthlyCashFlow;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final calculator = EmergencyFundCalculator(
      currentAmount: currentAmount,
      monthlyBudget: monthlyBudget,
      netMonthlyCashFlow: netMonthlyCashFlow,
    );

    final emergencyFundContribution =
        calculator.monthlyEmergencyFundContribution;

    final otherGoalsContribution = calculator.monthlyOtherGoalsContribution;

    final opportunityFundContribution =
        calculator.monthlyOpportunityFundContribution;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your Emergency Fund Priority',
          style: AppTextStyle.headlineM,
        ),
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // CURRENT PRIORITY
              AppSection(
                child: Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    gradient: AppGradient.gradientA(colorScheme),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            PhosphorIconsRegular.target,
                            color: colorScheme.appInversedtextMuted,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Your current priority',
                            style: AppTextStyle.titleL.copyWith(
                              color: colorScheme.appInversedtextMuted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        calculator.currentMonths < 3
                            ? 'Build an emergency fund equal to 3 months of your planned budget. '
                                  'Until you reach this milestone, your emergency fund should be your top financial priority.'
                            : calculator.currentMonths < 6
                            ? 'You have reached 3 months of emergency-fund coverage. '
                                  'You can now direct part of your net monthly cash flow toward your other goals.'
                            : calculator.currentMonths < 12
                            ? 'You have reached 6 months of emergency-fund coverage. '
                                  'You can now balance building your emergency fund with your other goals.'
                            : 'Your emergency fund has reached 12 months of your planned budget. '
                                  'You can now direct your cash flow toward your other goals.',
                        style: AppTextStyle.bodyL.copyWith(
                          color: colorScheme.appInversedtext,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // RECOMMENDED ALLOCATION
              AppSection(
                child: AppSectionBody(
                  padding: 16,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Your Recommended Allocation',
                        style: AppTextStyle.titleL,
                      ),

                      const SizedBox(height: 16),

                      Text('Net Monthly Cash Flow'),
                      Text(
                        netMonthlyCashFlow.toCurrency(),
                        style: AppTextStyle.amountXL,
                      ),

                      const SizedBox(height: 20),
                      Text('Recommended Allocation'),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _AllocationColumn(
                              label: 'Emergency Fund',
                              percentage: calculator.emergencyFundRate,
                              amount: emergencyFundContribution,
                            ),
                          ),
                          Expanded(
                            child: _AllocationColumn(
                              label: 'Other Goals',
                              percentage: calculator.otherGoalsRate,
                              amount: otherGoalsContribution,
                            ),
                          ),
                        ],
                      ),

                      if (calculator.opportunityFundRate > 0) ...[
                        const SizedBox(height: 16),
                        _AllocationColumn(
                          label: 'Opportunity Fund',
                          percentage: calculator.opportunityFundRate,
                          amount: opportunityFundContribution,
                        ),
                      ],

                      if (calculator.nextMilestoneMonths != null) ...[
                        const SizedBox(height: 24),

                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: colorScheme.bgDark,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Next milestone',
                                style: AppTextStyle.titleS,
                              ),

                              const SizedBox(height: 4),

                              Text(
                                '${calculator.nextMilestoneMonths!.toStringAsFixed(0)} months '
                                '(${calculator.nextMilestoneAmount!.toCurrency()})',
                                style: AppTextStyle.titleL,
                              ),

                              const SizedBox(height: 12),

                              Text(
                                calculator.monthsToNextMilestone == null
                                    ? 'Unable to estimate with the current cash flow.'
                                    : 'By saving ${emergencyFundContribution.toCurrency()} monthly, next milestone achivable in '
                                          '${calculator.monthsToNextMilestone!.ceil().toString()} months.',
                                style: AppTextStyle.bodyM.copyWith(
                                  color: colorScheme.appTextMuted,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ALLOCATION RULES
              AppSection(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: colorScheme.bgLight,
                    border: Border.all(color: colorScheme.appBorder),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'How Your Allocation Changes',
                          style: AppTextStyle.titleL,
                        ),
                      ),

                      _AllocationRule(
                        title: 'Less than 3 months',
                        emergencyFundRate: 1.0,
                        otherGoalsRate: 0.0,
                        isCurrent: calculator.currentMonths < 3,
                      ),

                      const SizedBox(height: 16),

                      _AllocationRule(
                        title: '3–6 months',
                        emergencyFundRate: 0.75,
                        otherGoalsRate: 0.25,
                        isCurrent:
                            calculator.currentMonths >= 3 &&
                            calculator.currentMonths < 6,
                      ),

                      const SizedBox(height: 16),

                      _AllocationRule(
                        title: '6–12 months',
                        emergencyFundRate: 0.50,
                        otherGoalsRate: 0.50,
                        isCurrent:
                            calculator.currentMonths >= 6 &&
                            calculator.currentMonths < 12,
                      ),

                      const SizedBox(height: 16),

                      _AllocationRule(
                        title: 'More than 12 months',
                        emergencyFundRate: 0.0,
                        otherGoalsRate: 0.95,
                        opportunityFundRate: 0.05,
                        isCurrent: calculator.currentMonths >= 12,
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RichText(
                          text: TextSpan(
                            style: AppTextStyle.bodyS.copyWith(
                              color: colorScheme.appText,
                            ),
                            children: [
                              const TextSpan(text: '*'),
                              TextSpan(
                                text: 'Opportunity Fund',
                                style: AppTextStyle.titleS,
                              ),
                              const TextSpan(
                                text:
                                    ' — a small pool of liquid funds kept available '
                                    'for worthwhile opportunities without disrupting '
                                    'your emergency fund or planned goals.',
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              AppSection(
                child: AppButton(
                  text: 'Save My Emergency Fund Plan',
                  onTap: () async {
                    debugPrint('SAVE BUTTON TAPPED');

                    await controller.commitEmergencyFund(
                      targetAmount: calculator.targetAmount,
                      monthlyContribution:
                          calculator.monthlyEmergencyFundContribution,
                    );

                    debugPrint('SAVE COMPLETE');
                    Get.close(4);
                    // Get.find<MainShellController>().goToFinancialPlanner(
                    //   pageIndex: 3,
                    // );
                    debugPrint('Go BACK CLICKED');
                  },
                ),
              ),
              SizedBox(height: context.bottomPaddingSub),
            ],
          ),
        ),
      ),
    );
  }
}

class _AllocationColumn extends StatelessWidget {
  const _AllocationColumn({
    required this.label,
    required this.percentage,
    required this.amount,
  });

  final String label;
  final double percentage;
  final double amount;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.labelM.copyWith(color: colorScheme.appTextMuted),
        ),
        Text(amount.toCurrency(), style: AppTextStyle.amountL),
        Text(
          '${(percentage * 100).toStringAsFixed(0)}%',
          style: AppTextStyle.amountS,
        ),
      ],
    );
  }
}

class _AllocationRule extends StatelessWidget {
  const _AllocationRule({
    required this.title,
    required this.emergencyFundRate,
    required this.otherGoalsRate,
    this.opportunityFundRate = 0,
    required this.isCurrent,
  });

  final String title;
  final double emergencyFundRate;
  final double otherGoalsRate;
  final double opportunityFundRate;
  final bool isCurrent;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: isCurrent
          ? BoxDecoration(
              color: colorScheme.appInflow.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(12),
            )
          : null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // if (isCurrent) ...[

              // ],
              Text(title, style: AppTextStyle.titleM),
              if (isCurrent) ...[
                const SizedBox(width: 8),
                Icon(
                  PhosphorIconsRegular.arrowLeft,
                  size: 18,
                  color: colorScheme.appInflow,
                ),
                const SizedBox(width: 8),
                Text(
                  'You Are Here',
                  style: AppTextStyle.labelM.copyWith(
                    color: colorScheme.appInflow,
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              if (opportunityFundRate > 0) ...[
                const SizedBox(height: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Opportunity Fund', style: AppTextStyle.labelM),
                      Text(
                        '${(opportunityFundRate * 100).toStringAsFixed(0)}%',
                        style: AppTextStyle.amountL,
                      ),
                    ],
                  ),
                ),
              ] else ...[
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Emergency Fund', style: AppTextStyle.labelM),
                      Text(
                        '${(emergencyFundRate * 100).toStringAsFixed(0)}%',
                        style: AppTextStyle.amountL,
                      ),
                    ],
                  ),
                ),
              ],

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Other Goals', style: AppTextStyle.labelM),
                    Text(
                      '${(otherGoalsRate * 100).toStringAsFixed(0)}%',
                      style: AppTextStyle.amountL,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
