import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/subpages/insurance_under_construction_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/widgets/protection_gap_details_header.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/shared_widgets/protection_need_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
            // onAdd: () {
            //   // Add source/need action
            // },
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedCriticalIllnessDetailsIndex.value,
                children: const [
                  CriticalIllnessNeedsSlide(),
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

class CriticalIllnessNeedsSlide extends StatelessWidget {
  const CriticalIllnessNeedsSlide({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
      child: AppSection(
        child: Column(
          spacing: 20,
          children: [
            ProtectionNeedCard(
              icon: PhosphorIconsRegular.hospital,
              title: 'Medical Fund',
              description:
                  "Supports your family's living expenses throughout the selected protection horizon",
              amount: 0,
              onTap: () {},
            ),
            ProtectionNeedCard(
              icon: PhosphorIconsRegular.users,
              title: 'Family Expense Continuity Fund',
              description:
                  "Supports you and your family's living expenses throughout the selected protection horizon",
              amount: 0,
              onTap: () {},
            ),
            // const InsuranceUnderConstructionView(
            //   title: 'Needs are coming soon',
            //   description:
            //       'We’re still building this part of your protection plan.',
            // ),
          ],
        ),
      ),
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
