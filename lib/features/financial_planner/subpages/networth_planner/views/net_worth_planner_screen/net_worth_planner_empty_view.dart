import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/features/financial_planner/financial_planner_empty_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class NetWorthEmptyView extends StatelessWidget {
  const NetWorthEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSection(
      child: FinancialPlannerEmptySection(
        icon: PhosphorIconsRegular.wallet,
        title: 'Build your net worth',
        description:
            'Start by adding accounts that represent what you own and what you owe. AscendYFP will calculate your net worth and help you track how your financial position changes over time.',
        actionText: 'Add your first account',
        onTap: () {
          Get.toNamed(Routes.NETWORTHDETAILS);
        },
      ),
    );
  }
}
