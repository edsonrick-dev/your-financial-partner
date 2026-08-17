import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/controller/insurance_planner_controller.dart';
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
            actions: const [
              'Needs', 'Sources',
              // AppDetailsPageAction(
              //   title: 'Needs',
              //   page: _DisabilityNeedsContent(),
              // ),
              // AppDetailsPageAction(
              //   title: 'Sources',
              //   page: _DisabilitySourcesContent(),
              // ),
            ],
            onAdd: () {
              // Add source/need action
            },
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedDisabilityDetailsIndex.value,
                children: const [
                  _DisabilityNeedsContent(),
                  _DisabilitySourcesContent(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DisabilityNeedsContent extends StatelessWidget {
  const _DisabilityNeedsContent();

  @override
  Widget build(BuildContext context) {
    return const Text('Needs content goes here.');
  }
}

class _DisabilitySourcesContent extends StatelessWidget {
  const _DisabilitySourcesContent();

  @override
  Widget build(BuildContext context) {
    return const Text('Sources content goes here.');
  }
}
