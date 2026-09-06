import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sections/cashflow_summary_container_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/metric_bar_row.dart';
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
          SizedBox(height: 20),
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
            sectionTitle: 'Bills Management',
            child: AppSectionBody(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Icon(PhosphorIconsRegular.receipt, size: 40),
                        SizedBox(height: 20),
                        Text(
                          'No Bills Created Yet',
                          style: AppTextStyle.headlineL,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Go to Bill Manager to create your first bill',
                          style: AppTextStyle.bodyM,
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: AppButton(
                      text: 'Go to Bill Manager',
                      onTap: () {
                        Get.toNamed(Routes.BILLS);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),

          SizedBox(height: 24),
        ],
      ),
    );
  }
}
