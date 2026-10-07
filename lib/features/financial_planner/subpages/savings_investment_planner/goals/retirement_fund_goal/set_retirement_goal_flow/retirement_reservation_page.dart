import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/app_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/emergency_fund_allocation_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/controller/retirement_fund_reservation_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/set_retirement_goal_flow/retirement_fund_plan_page.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class RetirementFundReservationPage
    extends GetView<RetirementFundReservationController> {
  const RetirementFundReservationPage({
    super.key,
    required this.retirementFundNeed,
  });

  final double retirementFundNeed;

  @override
  Widget build(BuildContext context) {
    final financialProfileController = Get.find<FinancialProfileController>();
    final colorScheme = context.colors;

    return Scaffold(
      appBar: AppBar(
        title: Text('Set Aside for Retirement', style: AppTextStyle.headlineL),
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
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
                            'Tell us about your existing retirement savings',
                            style: AppTextStyle.titleL,
                          ),

                          const SizedBox(height: 16),

                          Text(
                            'Select the accounts where you already '
                            'keep money for retirement and enter '
                            'how much you have set aside.',
                            style: AppTextStyle.bodyM,
                          ),

                          const SizedBox(height: 16),

                          Text(
                            'You can adjust this anytime.',
                            style: AppTextStyle.bodyM.copyWith(
                              color: colorScheme.appTextMuted,
                            ),
                          ),

                          const SizedBox(height: 16),

                          Obx(
                            () => Column(
                              spacing: 12,
                              children: controller.accounts.map((account) {
                                final reservedAmount =
                                    controller.reservedAmounts[account.id] ?? 0;

                                final allocableAmount =
                                    controller.allocableAmounts[account.id] ??
                                    0;

                                return AllocateFundAccountCard(
                                  accountName: account.name,
                                  allocatedAmount: reservedAmount,
                                  allocableAmount: allocableAmount,
                                  onTap: () async {
                                    final calculatorController =
                                        Get.find<AppCalculatorController>();

                                    calculatorController.initialize(
                                      reservedAmount,
                                    );

                                    final result =
                                        await Get.bottomSheet<double>(
                                          const AppCalculator(
                                            title: 'Set Aside for Retirement',
                                          ),
                                          isScrollControlled: true,
                                        );

                                    if (result == null) {
                                      return;
                                    }

                                    controller.updateReservation(
                                      account.id,
                                      result,
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 8),

            Obx(
              () => AppSection(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.appBorder),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total amount set aside',
                        style: AppTextStyle.titleM,
                      ),
                      Text(
                        controller.totalReserved.toCurrency(),
                        style: AppTextStyle.amountXL,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Obx(
              () => AppSection(
                child: AppButton(
                  text: 'Continue',
                  isLoading: financialProfileController
                      .isCalculatingRetirementContribution
                      .value,
                  onTap: () async {
                    final currentSavings = controller.totalReserved;

                    financialProfileController.currentRetirementSavings.value =
                        currentSavings;

                    final success = await financialProfileController
                        .calculateRequiredRetirementContributions();

                    if (!success) {
                      return;
                    }

                    Get.to(
                      () => RetirementFundPlanPage(
                        currentRetirementSavings: currentSavings,
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
