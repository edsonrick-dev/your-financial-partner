import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/default_data/default_policy_recommendations.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/sections/protection_score_container_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/widgets/protection_gap_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/widgets/recommended_policy_card.dart';
import 'package:getx_drift_app/features/widgets/cards/others_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsurancePlannerScreen extends GetView<InsurancePlannerController> {
  const InsurancePlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return SingleChildScrollView(
      child: Column(
        spacing: 12,
        children: [
          SizedBox(height: 12),
          Obx(
            () => ProtectionScoreContainerSection(
              profile: controller.protectionProfile,
              unmetGoals: controller.unmetProtectionGoals,
            ),
          ),
          AppSection(
            sectionTitle: 'Protection Breakdown',
            child: AppSectionBody(
              child: Column(
                spacing: 16,
                children: [
                  ProtectionGapCard(
                    color: colorScheme.appInfo,
                    icon: PhosphorIconsRegular.ambulance,
                    gapTitle: 'Death Benefit Gap',
                    amountCovered: controller.deathBenefitCovered.value,
                    amountNeed: controller.deathBenefitNeed.value,
                    onTap: () {
                      Get.toNamed(Routes.DEATHBENEFITGAP);
                    },
                  ),
                  ProtectionGapCard(
                    color: colorScheme.appInfo,
                    icon: PhosphorIconsRegular.hospital,
                    gapTitle: 'Critical Illness Benefit Gap',

                    amountCovered: controller.criticalIllnessCovered.value,
                    amountNeed: controller.criticalIllnessNeed.value,
                    onTap: () {
                      Get.toNamed(Routes.CRITICALILLNESSBENEFITGAP);
                    },
                  ),
                  ProtectionGapCard(
                    color: colorScheme.appInfo,
                    icon: PhosphorIconsRegular.wheelchair,
                    gapTitle: 'Disability Benefit Gap',

                    amountCovered: controller.disabilityCovered.value,
                    amountNeed: controller.disabilityNeed.value,
                    onTap: () {
                      Get.toNamed(Routes.DISABILITYBENEFITGAP);
                    },
                  ),
                ],
              ),
            ),
          ),
          AppSection(
            sectionTitle: 'Recommended Policies',
            isHorizontalScrolling: true,
            child: Row(
              // crossAxisAlignment: CrossAxisAlignment.start,
              // mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              spacing: 12,
              children: dummyInsurancePolicyRecommendations
                  .map((policy) => RecommendedPolicyCard(policy: policy))
                  .toList(),
            ),
          ),
          AppSection(
            sectionTitle: 'Others',
            // showTrailing: true,
            child: Column(
              spacing: 12,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    Expanded(
                      child: OthersCard(
                        icon: PhosphorIconsRegular.article,
                        title: 'My Policies',
                        onTap: () {
                          Get.toNamed(Routes.INSURANCEPOLICIES);
                        },
                      ),
                    ),
                    Expanded(
                      child: OthersCard(
                        icon: PhosphorIconsRegular.users,
                        title: 'Beneficiaries',
                        onTap: () {
                          Get.toNamed(Routes.BENEFICIARIES);
                        },
                      ),
                    ),
                  ],
                ),

                // BudgetCard(
                //   title: 'Food',
                //   iconKey: 'bowlFood',
                //   consumption: 250,
                //   budget: 400,
                // ),
              ],
            ),
          ),
          // AppSection(
          //   sectionTitle: 'Bills',
          //   trailingType: SectionTrailingType.textButton,
          //   trailingText: 'View all',
          //   onTrailingPressed: () {
          //     Get.toNamed(Routes.TRANSACTION);
          //   },
          //   // showTrailing: true,
          //   child: Column(
          //     spacing: 12,
          //     children: [
          //       BillsCard(
          //         iconKey: 'internet',
          //         billName: 'Internet Home Fiber',
          //         billType: 'Internet Bill',
          //         dueDate: DateTime(2026, 6, 4),
          //         amountDue: 6000,
          //       ),
          //     ],
          //   ),
          // ),

          // ListView.builder(
          //   shrinkWrap: true,
          //   physics: const NeverScrollableScrollPhysics(),
          //   itemCount: controller.projections.length,
          //   itemBuilder: (_, index) {
          //     final item = controller.projections[index];

          //     return Card(
          //       child: ListTile(
          //         title: Text(item.month.fullName),
          //         subtitle: Text(
          //           'Income: ${item.income}'
          //           '\nAllocated: ${item.allocated}'
          //           '\nSurplus: ${item.surplus}',
          //         ),
          //       ),
          //     );
          //   },
          // ),
        ],
      ),
    );
  }
}
