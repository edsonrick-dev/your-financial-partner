import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/budget_list.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/views/planned_income_list.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_page_action_section.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

class CashflowDetailsView extends GetView<CashflowController> {
  const CashflowDetailsView({super.key});

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
                Text(
                  'What to put here',
                  style: AppTextStyle.amountXL.copyWith(
                    color: colorScheme.appOutflow,
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            123456789.toCurrency(),
                            style: AppTextStyle.amountL.copyWith(
                              color: colorScheme.appInflow,
                            ),
                          ),
                          Text(
                            'Annual Income',
                            style: AppTextStyle.titleM.copyWith(
                              color: colorScheme.inversePrimary.withAlpha(150),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            123456789.toCurrency(),
                            style: AppTextStyle.amountL.copyWith(
                              color: colorScheme.appOutflow,
                            ),
                          ),
                          Text(
                            'Annual Budget',
                            style: AppTextStyle.titleM.copyWith(
                              color: colorScheme.inversePrimary.withAlpha(150),
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
            onAdd: () {},
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.seletectedDetailsTabIndex.value,
                children: const [PlannedIncomeList(), BudgetList()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
