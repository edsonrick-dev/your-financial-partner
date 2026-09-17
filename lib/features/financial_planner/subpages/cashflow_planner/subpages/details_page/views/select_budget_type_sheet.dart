import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sheets/create_cashflow_plan/create_expense_plan_sheet.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class SelectBudgetTypeSheet extends GetView<CashflowController> {
  const SelectBudgetTypeSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      title: 'Select Budget Type',
      adaptiveHeight: true,
      // height: AppSheetHeight.quarter,
      child: SingleChildScrollView(
        child: AppSection(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 20,
            children: [
              AppCard(
                onTap: () {
                  Get.back();
                  Get.bottomSheet(
                    CreateExpensePlanSheet(),
                    backgroundColor: Colors.transparent,
                    isScrollControlled: true,
                  ).whenComplete(() {
                    // controller.resetBudgetPlan();
                  });
                },
                padding: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Expense Budget', style: AppTextStyle.titleL),
                    Text('Set budget for your expense categories'),
                  ],
                ),
              ),
              AppCard(
                onTap: () {
                  Get.back();
                },
                padding: 12,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Debt Repayment Budget', style: AppTextStyle.titleL),
                    Text('Set budget for your loans'),
                  ],
                ),
              ),

              // AdaptivePressable(
              //   onTap: () {
              //     Get.back();
              //     Get.bottomSheet(
              //       CreateExpensePlanSheet(),
              //       backgroundColor: Colors.transparent,
              //       isScrollControlled: true,
              //     ).whenComplete(() {
              //       controller.resetBudgetPlan();
              //     });
              //   },
              //   child: Container(
              //     width: double.infinity,
              //     padding: EdgeInsets.all(8),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(8),
              //       border: Border.all(color: colorScheme.appBorder),
              //     ),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text('Expense Budget'),
              //         Text('Set budget for your expense categories'),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: context.bottomPaddingSub),
            ],
          ),
        ),
      ),
    );
  }
}
