import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/insurance_policies_list.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class CriticalIllnessSourcesSlide extends GetView<InsurancePlannerController> {
  const CriticalIllnessSourcesSlide({super.key, required this.type});

  final ProtectionType type;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
      child: AppSection(child: InsuranceSourcesList(type: type)),
    );
  }
}
