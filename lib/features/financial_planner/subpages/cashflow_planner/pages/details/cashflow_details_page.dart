import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/budget/budget_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sheets/create_cashflow_plan/create_income_plan_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/income_plan/income_plan_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/select_budget_type_sheet.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';

class CashflowDetailsPage extends GetView<CashflowController> {
  const CashflowDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Scaffold(
      body: Column(
        children: [
          AppDetailsHeader(
            title: 'Cash Flow',
            child: Column(
              children: [
                Obx(
                  () => Column(
                    children: [
                      Text(
                        controller.annualCashflowDifference.abs().toCurrency(),
                        style: AppTextStyle.amountXL.copyWith(
                          color: controller.hasAnnualSurplus
                              ? colorScheme.appInversedtext
                              : colorScheme.appOutflowInversed,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        controller.hasAnnualSurplus
                            ? 'Annual Surplus'
                            : 'Annual Deficit',
                        style: AppTextStyle.titleM.copyWith(
                          color: colorScheme.textInversedMuted,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Obx(
                            () => Text(
                              controller.plannedAnnualIncome.value.toCurrency(),
                              style: AppTextStyle.amountL.copyWith(
                                color: colorScheme.appInflowInverse,
                              ),
                            ),
                          ),
                          Text(
                            'Annual Income',
                            style: AppTextStyle.titleM.copyWith(
                              color: colorScheme.textInversedMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Obx(
                            () => Text(
                              controller.annualBudget.value.toCurrency(),
                              style: AppTextStyle.amountL.copyWith(
                                color: colorScheme.appOutflowInversed,
                              ),
                            ),
                          ),
                          Text(
                            'Annual Budget',
                            style: AppTextStyle.titleM.copyWith(
                              color: colorScheme.textInversedMuted,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppDetailsPageActionSection(
            selectedIndex: controller.seletectedDetailsTabIndex,
            actions: const [
              'Income', 'Budget',
              // AppDetailsPageAction(title: 'Income', page: PlannedIncomeList()),
              // AppDetailsPageAction(title: 'Budget', page: BudgetList()),
            ],
            onAdd: () {
              controller.seletectedDetailsTabIndex.value == 0
                  ? Get.bottomSheet(
                      const CreateIncomePlanSheet(),
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                    ).whenComplete(() {
                      controller.resetIncomePlan();
                    })
                  : Get.bottomSheet(
                      SelectBudgetTypeSheet(),
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                    ).whenComplete(() {
                      controller.resetBudgetPlan();
                    });
            },
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.seletectedDetailsTabIndex.value,
                children: const [IncomePlanPage(), BudgetPage()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
