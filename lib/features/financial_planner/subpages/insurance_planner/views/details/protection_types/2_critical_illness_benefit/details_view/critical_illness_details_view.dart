import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/binding/insurance_policy_binding.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/add_policy_sheet/add_policy_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/show_add_policy_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/widgets/protection_gap_details_header.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/2_critical_illness_benefit/details_view/slides/critical_illness_needs_slide.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/2_critical_illness_benefit/details_view/slides/critical_illness_sources_slide.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';

class CriticalIllnessDetailsView extends GetView<InsurancePlannerController> {
  const CriticalIllnessDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final type = ProtectionType.criticalIllness;

    return Scaffold(
      body: Column(
        children: [
          AppDetailsHeader(
            title: 'Critical Illness Benefit Gap',
            child: Obx(() {
              final protectionSource = controller.criticalIllnessCovered.value;
              final severity = controller.criticalIllnessSeverity;
              final protectionNeed =
                  controller.protectionNeedsTotals[type] ?? 0.0;
              final isCompleted =
                  controller.protectionGapCompletion[type] ?? false;

              return ProtectionGapDetailsHeader(
                type: type,
                severity: severity,
                protectionNeed: protectionNeed,
                protectionSource: protectionSource,
                isCompleted: isCompleted,
                hasSources: protectionSource > 0,
              );
            }),
          ),
          Obx(() {
            final detailsIndex =
                controller.selectedCriticalIllnessDetailsIndex.value;
            return AppDetailsPageActionSection(
              selectedIndex: controller.selectedCriticalIllnessDetailsIndex,
              actions: const ['Needs', 'Sources'],
              onAdd: detailsIndex == 1
                  ? () {
                      showAddPolicyForm();
                    }
                  : null,
            );
          }),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedCriticalIllnessDetailsIndex.value,
                children: [
                  CriticalIllnessNeedsSlide(type: type),
                  CriticalIllnessSourcesSlide(type: type),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
