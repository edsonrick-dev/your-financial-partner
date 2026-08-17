import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/data/enums/frequency_type_enum.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/widgets/cashflow_plan_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

class PlannedIncomeList extends StatelessWidget {
  const PlannedIncomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 12,
        children: [
          AppSection(
            sectionTitle: 'Active Income',
            trailingType: SectionTrailingType.custom,
            trailingWidget: Text(
              123456789.toCurrency(),
              style: AppTextStyle.amountM,
            ),
            child: Column(
              spacing: 8,
              children: [
                CashflowPlanCard(
                  category: 'Salary',
                  amount: 42500,
                  budgetPeriod: FrequencyType.monthly,
                ),
                CashflowPlanCard(
                  category: 'Salary',
                  amount: 3000,
                  budgetPeriod: FrequencyType.annual,
                ),
                CashflowPlanCard(
                  category: 'Salary',
                  amount: 3300,
                  budgetPeriod: FrequencyType.semiAnnual,
                ),
                // CashflowPlanCard()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
