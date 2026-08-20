import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/insurance_under_construction_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/widgets/protection_gap_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_page_action_section.dart';

class DeathBenefitDetailsView extends GetView<InsurancePlannerController> {
  const DeathBenefitDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Scaffold(
      backgroundColor: colorScheme.surface,

      body: Column(
        children: [
          AppDetailsHeader(
            title: 'Death Benefit Gap',
            child: ProtectionGapDetailsHeader(
              severity: controller.deathBenefitSeverity,
              protectionNeed: controller.deathBenefitNeed.value,
              protectionSource: controller.deathBenefitCovered.value,
            ),
          ),

          AppDetailsPageActionSection(
            selectedIndex: controller.selectedDeathDetailsIndex,
            actions: const ['Needs', 'Sources'],
            onAdd: () {
              // Add source/need action
            },
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedDeathDetailsIndex.value,
                children: const [DeathNeedsContent(), DeathSourceContent()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DeathNeedsContent extends StatelessWidget {
  const DeathNeedsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const InsuranceUnderConstructionView(
      title: 'Needs are coming soon',
      description: 'We’re still building this part of your protection plan.',
    );
  }
}

class DeathSourceContent extends StatelessWidget {
  const DeathSourceContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const InsuranceUnderConstructionView(
      title: 'Sources are coming soon',
      description: 'We’re still building this part of your protection plan.',
    );
  }
}
