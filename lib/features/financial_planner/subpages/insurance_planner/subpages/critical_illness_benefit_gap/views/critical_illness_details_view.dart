import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/widgets/protection_gap_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_page_action_section.dart';

class CriticalIllnessDetailsView extends GetView<InsurancePlannerController> {
  const CriticalIllnessDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          AppDetailsHeader(
            title: 'Critical Illness Benefit Gap',
            child: ProtectionGapDetailsHeader(
              severity: controller.criticalIllnessSeverity,
              protectionNeed: controller.criticalIllnessNeed.value,
              protectionSource: controller.criticalIllnessCovered.value,
            ),
          ),
          AppDetailsPageActionSection(
            selectedIndex: controller.selectedCriticalIllnessDetailsIndex,
            actions: const [
              'Needs', 'Sources',
              // AppDetailsPageAction(
              //   title: 'Needs',
              //   page: _CriticalIllnessNeedsContent(),
              // ),
              // AppDetailsPageAction(
              //   title: 'Sources',
              //   page: _CriticalIllnessSourcesContent(),
              // ),
            ],
            onAdd: () {
              // Add source/need action
            },
          ),
          // Light content goes here
          // ProtectionGapSummaryCard(...)
          // AppSection(...)
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedCriticalIllnessDetailsIndex.value,
                children: const [
                  _CriticalIllnessNeedsContent(),
                  _CriticalIllnessSourcesContent(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CriticalIllnessNeedsContent extends StatelessWidget {
  const _CriticalIllnessNeedsContent();

  @override
  Widget build(BuildContext context) {
    return const Text('Needs content goes here.');
  }
}

class _CriticalIllnessSourcesContent extends StatelessWidget {
  const _CriticalIllnessSourcesContent();

  @override
  Widget build(BuildContext context) {
    return const Text('Sources content goes here.');
  }
}
