import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/controller/savings_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/investor_profile/investor_profile_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/investor_profile/investory_profile_model.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class InvestorProfileSection extends GetView<SavingsPlannerController> {
  const InvestorProfileSection({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final profile = controller.investorProfile.value;

    if (profile == null) {
      return const Text('Investor profile not available.');
    }
    return AdaptivePressable(
      onTap: () {
        Get.bottomSheet(
          InvestorProfileSheet(profile: profile),
          isScrollControlled: true,
        );
      },
      child: AppSection(
        child: Container(
          padding: const EdgeInsets.all(24),
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: AppGradient.gradientA(colorScheme),
            borderRadius: BorderRadius.circular(24),
          ),
          // padding: ,
          child: Builder(
            builder: (context) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 8,
                children: [
                  Text(
                    'Investor Profile',
                    style: AppTextStyle.titleL.copyWith(
                      color: colorScheme.appInversedtextMuted,
                    ),
                  ),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      profile.label,
                      style: AppTextStyle.amountXL.copyWith(
                        color: colorScheme.appInversedtext,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
