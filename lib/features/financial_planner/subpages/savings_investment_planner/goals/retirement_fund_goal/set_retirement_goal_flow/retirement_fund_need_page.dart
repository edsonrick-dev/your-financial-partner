import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/controller/retirement_fund_reservation_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/projection/retirement_projection_engine.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/set_retirement_goal_flow/retirement_projection_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/set_retirement_goal_flow/retirement_reservation_page.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RetirementFundNeedPage extends GetView<FinancialProfileController> {
  const RetirementFundNeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Scaffold(
      appBar: AppBar(
        title: Text('Retirement Fund Need', style: AppTextStyle.headlineL),
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: AppSection(
                child: Column(
                  spacing: 20,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: colorScheme.appBorder),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Obx(() {
                        final retirementFundNeed =
                            controller.retirementFundNeed.value;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Retirement fund needed',
                              style: AppTextStyle.titleL,
                            ),

                            const SizedBox(height: 8),

                            Text(
                              'The amount you may need when you retire to support '
                              'your planned lifestyle until age ${controller.retirementFundEndAge}.',
                              style: AppTextStyle.bodyM.copyWith(),
                            ),

                            const SizedBox(height: 16),

                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                retirementFundNeed.toCurrency(),
                                style: AppTextStyle.amountXL,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              'Required at age ${controller.retirementAge}',
                              style: AppTextStyle.amountL.copyWith(
                                color: colorScheme.appTextMuted,
                              ),
                            ),
                          ],
                        );
                      }),
                    ),

                    AppCard(
                      onTap: () {
                        Get.to(() => const RetirementProjectionPage());
                      },
                      child: Column(
                        spacing: 8,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'See how your fund may last',
                                  style: AppTextStyle.titleL,
                                ),
                              ),
                              Icon(PhosphorIconsRegular.caretRight, size: 20),
                            ],
                          ),
                          Text(
                            'Projected withdrawals and remaining balance through age 80.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          AppSection(
            child: AppButton(
              text: 'Continue',
              onTap: () {
                Get.to(
                  () => RetirementFundReservationPage(
                    retirementFundNeed: controller.retirementFundNeed.value,
                  ),
                  binding: BindingsBuilder(() {
                    Get.put(RetirementFundReservationController());
                  }),
                );
              },
            ),
          ),

          SizedBox(height: context.bottomPaddingSub),
        ],
      ),
    );
  }
}

class _RetirementWithdrawalTable extends StatelessWidget {
  final List<RetirementProjection> projections;

  const _RetirementWithdrawalTable({required this.projections});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final textStyle = AppTextStyle.amountS;
    final headerStyle = AppTextStyle.titleM;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.bgLight,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: DataTable(
        columnSpacing: 16,
        horizontalMargin: 8,
        columns: [
          DataColumn(label: Text('Age', style: headerStyle)),
          DataColumn(
            label: Text('Beginning', style: headerStyle),
            numeric: true,
          ),
          DataColumn(
            label: Text('Withdrawal', style: headerStyle),
            numeric: true,
          ),
          DataColumn(
            label: Text('Remaining', style: headerStyle),
            numeric: true,
          ),
          DataColumn(label: Text('Return', style: headerStyle), numeric: true),
          DataColumn(label: Text('Growth', style: headerStyle), numeric: true),
          DataColumn(label: Text('Ending', style: headerStyle), numeric: true),
        ],
        rows: projections.map((projection) {
          return DataRow(
            cells: [
              DataCell(Text(projection.age.toString(), style: textStyle)),
              DataCell(
                Text(
                  projection.beginningBalance.toCompactCurrency(
                    kThreshold: 100000,
                  ),
                  style: textStyle,
                ),
              ),

              DataCell(
                Text(
                  '-${projection.withdrawal.toCompactCurrency(kThreshold: 100000)}',
                  style: textStyle.copyWith(color: colorScheme.appOutflow),
                ),
              ),
              DataCell(
                Text(
                  (projection.remainingBalance).toCompactCurrency(
                    kThreshold: 100000,
                  ),
                  style: textStyle,
                ),
              ),
              DataCell(
                Text(
                  '+${(projection.returnRate * 100).toStringAsFixed(1)}%',
                  style: textStyle.copyWith(color: colorScheme.appInflow),
                ),
              ),
              DataCell(
                Text(
                  '+${projection.interestEarned.toCompactCurrency(kThreshold: 100000)}',
                  style: textStyle.copyWith(color: colorScheme.appInflow),
                ),
              ),
              DataCell(
                Text(
                  projection.endBalance.toCompactCurrency(kThreshold: 100000),
                  style: textStyle,
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }
}
