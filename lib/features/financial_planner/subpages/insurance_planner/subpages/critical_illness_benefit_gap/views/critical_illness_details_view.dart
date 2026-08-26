import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/insurance_under_construction_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/widgets/protection_gap_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';

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
            actions: const ['Needs', 'Sources'],
            onAdd: () {
              // Add source/need action
            },
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedCriticalIllnessDetailsIndex.value,
                children: const [
                  CriticalIllnessNeedsContent(),
                  CriticalIllnessSourcesContent(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CriticalIllnessNeedsContent extends StatelessWidget {
  const CriticalIllnessNeedsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const InsuranceUnderConstructionView(
      title: 'Needs are coming soon',
      description: 'We’re still building this part of your protection plan.',
    );
  }
}

class CriticalIllnessSourcesContent extends StatelessWidget {
  const CriticalIllnessSourcesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const InsuranceUnderConstructionView(
      title: 'Sources are coming soon',
      description: 'We’re still building this part of your protection plan.',
    );
  }
}
