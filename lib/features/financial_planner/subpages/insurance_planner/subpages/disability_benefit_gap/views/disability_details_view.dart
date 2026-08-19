import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/insurance_under_construction_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/widgets/protection_gap_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_page_action_section.dart';

class DisabilityDetailsView extends GetView<InsurancePlannerController> {
  const DisabilityDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: Column(
        children: [
          AppDetailsHeader(
            title: 'Disability Benefit Gap',
            child: ProtectionGapDetailsHeader(
              severity: controller.disabilitySeverity,
              protectionNeed: controller.disabilityNeed.value,
              protectionSource: controller.disabilityCovered.value,
            ),
          ),

          AppDetailsPageActionSection(
            selectedIndex: controller.selectedDisabilityDetailsIndex,
            actions: const ['Needs', 'Sources'],
            onAdd: () {},
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedDisabilityDetailsIndex.value,
                children: const [
                  DisabilityNeedsContent(),
                  DisabilitySourcesContent(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DisabilityNeedsContent extends StatelessWidget {
  const DisabilityNeedsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const InsuranceUnderConstructionView(
      title: 'Needs are coming soon',
      description: 'We’re still building this part of your protection plan.',
    );
  }
}

class DisabilitySourcesContent extends StatelessWidget {
  const DisabilitySourcesContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const InsuranceUnderConstructionView(
      title: 'Sources are coming soon',
      description: 'We’re still building this part of your protection plan.',
    );
  }
}
