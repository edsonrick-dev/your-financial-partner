import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/benefits/expense_continuity/expense_continuity_fund_details.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_card_builder.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CriticalIllnessNeedsSlide extends GetView<InsurancePlannerController> {
  const CriticalIllnessNeedsSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
      child: AppSection(
        child: Column(
          spacing: 20,
          children: ProtectionNeedCardBuilder.build(
            type: ProtectionType.criticalIllness,
          ),
        ),
      ),
    );
  }
}
