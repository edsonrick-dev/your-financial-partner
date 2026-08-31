import 'package:flutter/material.dart';
import 'package:getx_drift_app/features/financial_planner/financial_planner_empty_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SavingsPlannerEmptyView extends StatelessWidget {
  const SavingsPlannerEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSection(
      child: FinancialPlannerEmptySection(
        icon: PhosphorIconsRegular.chartLineUp,
        title: 'Savings & investment planner\nis coming soon',
        description:
            "We're still building this part of Ascend. Soon, you'll be able to set savings and investment goals, plan how much to put toward them, and track your progress over time.",
      ),
    );
  }
}
