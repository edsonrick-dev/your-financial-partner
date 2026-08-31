import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/features/financial_planner/financial_planner_empty_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CashflowPlannerEmptyView extends GetView<CashflowController> {
  const CashflowPlannerEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSection(
      child: FinancialPlannerEmptySection(
        icon: PhosphorIconsRegular.wallet,
        title: 'Plan your cashflow',
        description:
            'Start by adding your expected income then budget where it should go. Ascend will help you compare your plan with what actually happens as you use the app.',
        actionText: 'Set up your income plan',
        onTap: () {
          controller.seletectedDetailsTabIndex(0);
          Get.toNamed(Routes.CASHFLOWDETAILS);
        },
      ),
    );
  }
}
