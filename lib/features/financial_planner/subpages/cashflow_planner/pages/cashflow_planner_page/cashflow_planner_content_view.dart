import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sections/cashflow_summary_container_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/metric_bar_row.dart';
import 'package:getx_drift_app/features/profile/controller/extensions/financial_profile_emergency_fund_extension.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/widgets/cards/others_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CashflowPlannerContentView extends GetView<CashflowController> {
  const CashflowPlannerContentView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return SingleChildScrollView(
      child: Column(
        children: [
          CashflowSummaryContainerSection(),
          SizedBox(height: 24),
          AppSection(
            sectionTitle: 'Plan Overview',
            trailingType: SectionTrailingType.textButton,
            trailingText: 'See plans',
            onTrailingPressed: () {
              Get.toNamed(Routes.CASHFLOWDETAILS);
            },
            child: Column(
              spacing: 20,
              children: [
                Obx(
                  () => AppSectionBody(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          MetricBarRow(
                            label: 'Income',
                            amount: controller.plannedAnnualIncome.value,
                            ratio: controller.annualIncomeRatio,
                            color: colorScheme.appInflow,
                          ),
                          MetricBarRow(
                            label: 'Budget',
                            amount: controller.annualBudget.value,
                            ratio: controller.annualBudgetRatio,
                            color: colorScheme.appOutflow,
                          ),

                          MetricBarRow(
                            label: controller.annualBudgetDifference >= 0
                                ? 'Surplus'
                                : 'Deficit',
                            amount: controller.annualBudgetDifference.abs(),
                            ratio: controller.annualBudgetDifferenceRatio,
                            color: controller.annualBudgetDifference >= 0
                                ? colorScheme.appInflow
                                : colorScheme.appOutflow,
                            textColor: controller.annualBudgetDifference >= 0
                                ? colorScheme.appInflow
                                : colorScheme.appOutflow,
                          ),

                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Min. Emergency Fund Need (3mo.)',
                                  style: AppTextStyle.labelS,
                                ),
                              ),
                              Text(
                                controller.minimumEmergencyFund
                                    .toCompactCurrency(),
                                style: AppTextStyle.labelS,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Ideal Annual Income',
                                  style: AppTextStyle.labelS,
                                ),
                              ),
                              Text(
                                controller.idealAnnualIncome
                                    .toCompactCurrency(),
                                style: AppTextStyle.labelS,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Target Monthly Income',
                                  style: AppTextStyle.labelS,
                                ),
                              ),
                              Text(
                                controller.idealMonthlyIncome
                                    .toCompactCurrency(),
                                style: AppTextStyle.labelS,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Budget Gap',
                                  style: AppTextStyle.labelS,
                                ),
                              ),
                              Text(
                                controller.annualBudgetGap.toCompactCurrency(),
                                style: AppTextStyle.labelS,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          AppSection(
            sectionTitle: 'Your Financial Targets',
            child: Column(children: [EmergencyFundTargetCard()]),
          ),
          SizedBox(height: 20),
          AppSection(
            sectionTitle: 'Cashflow Tools',
            child: Column(
              spacing: 16,
              children: [
                OthersCard(
                  title: 'Bill Manager',
                  onTap: () {
                    Get.toNamed(Routes.BILLS);
                  },
                ),
                OthersCard(title: 'Categories'),
                // AppSectionBody(
                //   child: Column(
                //     children: [
                //       Padding(
                //         padding: const EdgeInsets.all(16.0),
                //         child: Column(
                //           crossAxisAlignment: CrossAxisAlignment.center,
                //           children: [
                //             Icon(PhosphorIconsRegular.receipt, size: 40),
                //             SizedBox(height: 20),
                //             Text(
                //               'No Bills Created Yet',
                //               style: AppTextStyle.headlineL,
                //             ),
                //             SizedBox(height: 8),
                //             FittedBox(
                //               child: Text(
                //                 textAlign: TextAlign.center,
                //                 'Go to Bill Manager to create your first bill',
                //                 style: AppTextStyle.bodyM,
                //               ),
                //             ),
                //           ],
                //         ),
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.all(8.0),
                //         child: AppButton(
                //           text: 'Go to Bill Manager',
                //           onTap: () {
                //             Get.toNamed(Routes.BILLS);
                //           },
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),

          SizedBox(height: 24),
        ],
      ),
    );
  }
}

class EmergencyFundTargetCard extends GetView<FinancialProfileController> {
  const EmergencyFundTargetCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final targetBand = controller.currentEmergencyFundTargetBand;
    final target = controller.currentEmergencyFundTarget;
    final targetMonths = controller.currentEmergencyFundTargetMonths;
    final gap = controller.emergencyFundTargetGap;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: colorScheme.bgLight,
        boxShadow: AppShadows.card(colorScheme.appText),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Stack(children: [Icon(PhosphorIconsRegular.shield)]),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  targetBand == null
                      ? 'Emergency Fund Complete'
                      : '${targetMonths!.round()}-Month Emergency Fund',
                  style: AppTextStyle.titleL,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          if (target != null) ...[
            Text(target.toCurrency(), style: AppTextStyle.amountL),

            Text(
              '3x of your average monthly budget',
              style: AppTextStyle.bodyS,
            ),

            RichText(
              text: TextSpan(
                style: AppTextStyle.bodyS.copyWith(
                  color: colorScheme.appTextMuted,
                ),
                children: [
                  const TextSpan(text: '('),
                  TextSpan(
                    text: controller.averageMonthlyBudget.toCurrency(),
                    style: AppTextStyle.amountS,
                  ),
                  const TextSpan(text: '/mo)'),
                ],
              ),
            ),

            RichText(
              text: TextSpan(
                style: AppTextStyle.bodyS.copyWith(
                  color: colorScheme.appTextMuted,
                ),
                children: [
                  const TextSpan(text: 'Your emergency fund is '),
                  TextSpan(
                    text: gap!.toCurrency(),
                    style: AppTextStyle.amountS,
                  ),
                  const TextSpan(text: ' short of your target.'),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
