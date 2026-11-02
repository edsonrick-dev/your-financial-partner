import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/show_add_policy_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/3_disability_benefit/slides/disability_sources_slide.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/widgets/protection_gap_details_header.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/3_disability_benefit/details_view/slides/disability_needs_slide.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';

class DisabilityDetailsView extends GetView<InsurancePlannerController> {
  const DisabilityDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final type = ProtectionType.disability;
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Column(
        children: [
          AppDetailsHeader(
            title: 'Disability Benefit Gap',
            child: Obx(() {
              final protectionSource = controller.disabilityCovered.value;
              final severity = controller.disabilitySeverity;
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
            final selectedTab = controller.selectedDisabilityDetailsIndex.value;

            return AppDetailsPageActionSection(
              selectedIndex: controller.selectedDisabilityDetailsIndex,
              actions: const ['Needs', 'Sources'],
              onAdd: selectedTab == 1
                  ? () {
                      showAddPolicyForm();
                    }
                  : null,
            );
          }),

          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedDisabilityDetailsIndex.value,
                children: [
                  DisabilityNeedsSlide(),
                  DisabilitySourcesSlide(type: type),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
