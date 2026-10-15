import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/widgets/protection_gap_details_header.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/details_view/slides/death_needs_slide.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/details_view/slides/death_sources_slide.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';

class DeathBenefitDetailsView extends GetView<InsurancePlannerController> {
  const DeathBenefitDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final type = ProtectionType.death;

    return Scaffold(
      backgroundColor: colorScheme.surface,

      body: Column(
        children: [
          AppDetailsHeader(
            title: 'Death Benefit Gap',
            child: Obx(
              () => ProtectionGapDetailsHeader(
                severity: controller.deathBenefitSeverity,
                protectionNeed: controller.protectionNeedsTotals[type] ?? 0.0,
                protectionSource: controller.deathBenefitCovered.value,
              ),
            ),
          ),

          Obx(() {
            final selectedTab = controller.selectedDeathDetailsIndex.value;
            return AppDetailsPageActionSection(
              selectedIndex: controller.selectedDeathDetailsIndex,
              actions: ['Needs', 'Sources'],
              onAdd: selectedTab == 1 ? () {} : null,
            );
          }),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedDeathDetailsIndex.value,
                children: [
                  DeathNeedsSlide(type: type),
                  DeathSourcesSlide(type: type),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
