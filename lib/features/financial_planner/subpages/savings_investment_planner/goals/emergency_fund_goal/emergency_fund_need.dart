import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/details/cashflow_details_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class EmergencyFundNeed extends GetView<FinancialProfileController> {
  const EmergencyFundNeed({super.key});

  @override
  Widget build(BuildContext context) {
    final type = GoalType.emergencyFund;
    final colorScheme = context.colors;

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppSection(
              child: AppSectionBody(
                padding: 24,
                child: Column(
                  children: [
                    Icon(type.icon, size: 60),
                    SizedBox(height: 16),
                    Text(
                      'Why Build Emergency Fund?',
                      style: AppTextStyle.headlineM,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 12),
                    Text(
                      type.description,
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
                        Obx(() {
                          final fundNeeded = controller.annualBudget;
                          return Text(
                            fundNeeded.toCurrency(),
                            style: AppTextStyle.amountXL,
                          );
                        }),

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
                              Obx(() {
                                final monthlyBudget = controller.monthlyBudget;
                                return Text(
                                  monthlyBudget.toCurrency(),
                                  style: AppTextStyle.amountL,
                                );
                              }),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            AppSection(
              child: Column(
                spacing: 12,
                children: [
                  AppButton(text: 'Allocate fund for emergency', onTap: () {}),
                  AppButton(
                    text: 'Update my budget',
                    type: ButtonType.outline,
                    onTap: () {
                      controller
                              .cashflowController
                              .seletectedDetailsTabIndex
                              .value =
                          1;
                      Get.toNamed(
                        Routes.CASHFLOWDETAILS,
                        arguments: {
                          CashflowDetailsArguments.from:
                              CashflowDetailsArguments.emergencyFund,
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
