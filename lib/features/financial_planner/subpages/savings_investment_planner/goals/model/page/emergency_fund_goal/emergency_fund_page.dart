import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/page/emergency_fund_goal/fund_milestone/fund_milestone_page.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EmergencyFundPage extends GetView<FinancialProfileController> {
  const EmergencyFundPage({super.key, required this.type});
  final GoalType type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emergency Fund', style: AppTextStyle.headlineL),
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          FundMilestonePage(),
          // EmergencyFundSetAmount(),

          // _EmergencyFundNeed(type: type, colorScheme: colorScheme),
          const SizedBox(height: 8),

          AppSection(
            child: AppButton(text: 'Continue', onTap: () {}),
          ),
          SizedBox(height: context.bottomPaddingSub),
        ],
      ),
    );
  }
}

class EmergencyFundSetAmount extends StatelessWidget {
  const EmergencyFundSetAmount({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  AppSection(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Set aside amount from your accounts',
                          style: AppTextStyle.titleL,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'Select which payment accounts to use for your emergency fund '
                          'and how much is set aside.',
                          style: AppTextStyle.bodyM,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'You can adjust this anytime.',
                          style: AppTextStyle.bodyM.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),
                        SizedBox(height: 16),
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: colorScheme.bgLight,
                              ),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(PhosphorIconsRegular.wallet),
                                      SizedBox(width: 12),
                                      Expanded(
                                        child: Text(
                                          'BPI Savings',
                                          style: AppTextStyle.titleL,
                                        ),
                                      ),
                                      SizedBox(width: 16),
                                      Text(
                                        0.toCurrency(),
                                        style: AppTextStyle.amountL,
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          '${120000.toCurrency()} available',
                                          style: AppTextStyle.amountM,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          AppSection(
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.bg,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Total amount set', style: AppTextStyle.titleM),
                  Text(30000.toCurrency(), style: AppTextStyle.amountXL),
                  Text(
                    'from n accounts',
                    style: AppTextStyle.titleM.copyWith(
                      color: colorScheme.appTextMuted,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmergencyFundNeed extends StatelessWidget {
  const _EmergencyFundNeed({
    super.key,
    required this.type,
    required this.colorScheme,
  });

  final GoalType type;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppSection(
              child: AppSectionBody(
                padding: 16,
                child: Column(
                  children: [
                    Icon(type.icon, size: 60),
                    SizedBox(height: 16),
                    Text(
                      'Why Build Emergency Fund?',
                      style: AppTextStyle.headlineM,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 16),
                    Text(
                      'An emergency fund helps you cover '
                      'essential expenses when your income '
                      'is disrupted or an unexpected expense occurs.',
                      style: AppTextStyle.bodyL,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            AppSection(
              child: AppSectionBody(
                padding: 16,
                child: Column(
                  spacing: 16,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your Emergency Fund Target',
                      style: AppTextStyle.titleL,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('12 months', style: AppTextStyle.amountXL),

                        Text(
                          'of your average monthly budget',
                          style: AppTextStyle.titleM.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(360000.toCurrency(), style: AppTextStyle.amountXL),

                        Text(
                          'Based on your current budget plan',
                          style: AppTextStyle.titleM.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: colorScheme.bg,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 44,
                            width: 44,
                            child: Icon(PhosphorIconsRegular.calendarDots),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Average monthly budget',
                                style: AppTextStyle.titleS.copyWith(
                                  color: colorScheme.appTextMuted,
                                ),
                              ),
                              Text(
                                30000.toCurrency(),
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
            ),
          ],
        ),
      ),
    );
  }
}
