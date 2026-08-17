import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/controller/insurance_planner_controller.dart';
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
            actions: const [
              'Needs', 'Sources',
              // AppDetailsPageAction(title: 'Needs', page: _DeathNeedsContent()),
              // AppDetailsPageAction(
              //   title: 'Sources',
              //   page: _DeathSourcesContent(),
              // ),
            ],
            onAdd: () {
              // Add source/need action
            },
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedDeathDetailsIndex.value,
                children: const [_DeathNeedsContent(), _DeathSourcesContent()],
              ),
            ),
          ),
          // Light content goes here
          // ProtectionGapSummaryCard(...)
          // AppSection(...)
        ],
      ),
    );
  }
}

class _DeathNeedsContent extends StatelessWidget {
  const _DeathNeedsContent();

  @override
  Widget build(BuildContext context) {
    return const Text('Needs content goes here.');
  }
}

class _DeathSourcesContent extends StatelessWidget {
  const _DeathSourcesContent();

  @override
  Widget build(BuildContext context) {
    return const Text('Sources content goes here.');
  }
}
