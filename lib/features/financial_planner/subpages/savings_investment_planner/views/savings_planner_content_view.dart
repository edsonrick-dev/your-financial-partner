import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/investor_profile/investor_profile_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/views/savings_planner_screen.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class SavingsPlannerContentView extends GetView<SavingsPlannerController> {
  const SavingsPlannerContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AppSection(
            child: AppButton(
              text: 'Open Investor Profile Sheet',
              onTap: () {
                final profile = controller.investorProfile;

                if (profile == null) {
                  return;
                }

                Get.bottomSheet(
                  InvestorProfileSheet(profile: profile),
                  isScrollControlled: true,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
