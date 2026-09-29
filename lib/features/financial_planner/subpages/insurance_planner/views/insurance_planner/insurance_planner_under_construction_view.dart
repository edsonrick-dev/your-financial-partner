import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/financial_planner_empty_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsurancePlannerUnderConstructionView extends StatelessWidget {
  const InsurancePlannerUnderConstructionView({super.key});

  @override
  Widget build(BuildContext context) {
    // final colorScheme = context.colors;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          top: context.topPadding,
          bottom: context.bottomPadding,
        ),
        child: AppSection(
          child: FinancialPlannerEmptySection(
            icon: PhosphorIconsRegular.shieldPlus,
            title: 'Protection planning\nis coming soon',
            description:
                'We’re still building this part of Ascend. Insurance planning will help you understand your protection needs and identify gaps in your coverage.',
          ),
        ),
      ),
    );
  }
}
