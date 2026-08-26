import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sheets/create_cashflow_plan/create_expense_plan_sheet.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class SelectBudgetTypeSheet extends GetView<CashflowController> {
  const SelectBudgetTypeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSheet(
      title: 'Select Budget Type',
      child: AppSection(
        child: Column(
          spacing: 20,
          children: [
            AdaptivePressable(
              onTap: () {
                Get.back();
                Get.bottomSheet(
                  CreateExpensePlanSheet(),
                  backgroundColor: Colors.transparent,
                  isScrollControlled: true,
                ).whenComplete(() {
                  controller.resetIncomePlan();
                });
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: colorScheme.appBorder),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Expense Budget'),
                    Text('Set budget for your expense categories'),
                  ],
                ),
              ),
            ),
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: colorScheme.appBorder),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Debt Repayment Budget'),
                  Text('Set budget for your loans'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
