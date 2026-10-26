import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/binding/insurance_policy_binding.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/add_policy_sheet/sections/select_insurance_product_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/show_add_policy_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/select_product/select_product_details_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/widgets/protection_gap_details_header.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/1_death_benefit/details_view/slides/death_needs_slide.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/1_death_benefit/details_view/slides/death_sources_slide.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/protection_types.dart';
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
            child: Obx(() {
              final protectionSource = controller.deathBenefitCovered.value;
              final severity = controller.deathBenefitSeverity;
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
            // child: Obx(() {
            //   final protectionNeed =
            //       controller.protectionNeedsTotals[type] ?? 0.0;
            //   final protectionSource = controller.deathBenefitCovered.value;

            //   return ProtectionGapDetailsHeader(
            //     type: type,
            //     severity: controller.deathBenefitSeverity,
            //     protectionNeed: protectionNeed,
            //     protectionSource: protectionSource,
            //     isCompleted: controller.protectionGapCompletion[type] ?? false,
            //     hasSources: protectionSource > 0,
            //   );
            // }),
          ),

          Obx(() {
            final selectedTab = controller.selectedDeathDetailsIndex.value;
            return AppDetailsPageActionSection(
              selectedIndex: controller.selectedDeathDetailsIndex,
              actions: ['Needs', 'Sources'],
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
