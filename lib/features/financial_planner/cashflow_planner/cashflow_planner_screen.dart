import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
import 'package:getx_drift_app/features/widgets/cards/bills_card.dart';
import 'package:getx_drift_app/features/widgets/cards/budget_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:intl/intl.dart';

class CashflowPlannerScreen extends GetView<FinancialPlannerController> {
  const CashflowPlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return SingleChildScrollView(
      child: Obx(
        () => Column(
          spacing: 12,
          children: [
            _cashflowSummarySection(controller: controller),
            AppSection(
              sectionTitle: 'CTA',
              child: Column(
                spacing: 12,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        'View Cashflow Plans',
                        style: TextStyle(color: colorScheme.inversePrimary),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      AppSheets.budgetSheets();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: Text(
                          'Add Plans',
                          style: TextStyle(color: colorScheme.inversePrimary),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AppSection(
              sectionTitle: 'Budgets',
              trailingType: SectionTrailingType.textButton,
              trailingText: 'View all',
              onTrailingPressed: () {
                Get.toNamed(Routes.TRANSACTION);
              },
              // showTrailing: true,
              child: Column(
                spacing: 12,
                children: [
                  BudgetCard(
                    title: 'Food',
                    iconKey: 'bowlFood',
                    consumption: 250,
                    budget: 400,
                  ),
                ],
              ),
            ),
            AppSection(
              sectionTitle: 'Bills',
              trailingType: SectionTrailingType.textButton,
              trailingText: 'View all',
              onTrailingPressed: () {
                Get.toNamed(Routes.TRANSACTION);
              },
              // showTrailing: true,
              child: Column(
                spacing: 12,
                children: [
                  BillsCard(
                    iconKey: 'internet',
                    billName: 'Internet Home Fiber',
                    billType: 'Internet Bill',
                    dueDate: DateTime(2026, 6, 4),
                    amountDue: 6000,
                  ),
                ],
              ),
            ),

            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: controller.projections.length,
              itemBuilder: (_, index) {
                final item = controller.projections[index];

                return Card(
                  child: ListTile(
                    title: Text(DateFormat.MMMM().format(item.month)),
                    subtitle: Text(
                      'Income: ${item.income}'
                      '\nAllocated: ${item.allocated}'
                      '\nSurplus: ${item.surplus}',
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _cashflowSummarySection extends StatelessWidget {
  const _cashflowSummarySection({required this.controller});

  final FinancialPlannerController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSection(
      sectionTitle: 'Annual Cashflow',
      child: Container(
        padding: EdgeInsets.all(12),
        width: double.infinity,
        decoration: BoxDecoration(
          color: colorScheme.appOnSurface,
          border: Border.all(color: colorScheme.appBorder),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text('Income'),
                      Obx(() => Text(controller.annualIncome.toCurrency())),
                    ],
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text('Allocation'),
                      Obx(() => Text(controller.annualAllocated.toCurrency())),
                    ],
                  ),
                ),
              ],
            ),
            Text(
              controller.annualSurplus == 0
                  ? 'Balanced'
                  : controller.annualSurplus > 0
                  ? 'Positive'
                  : 'Negative',
            ),
          ],
        ),
      ),
    );
  }
}
