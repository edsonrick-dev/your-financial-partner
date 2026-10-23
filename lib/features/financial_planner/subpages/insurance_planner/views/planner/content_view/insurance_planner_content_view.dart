import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/data/default_data/default_policy_recommendations.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/sections/protection_score_container_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/planner/content_view/widgets/protection_gap_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/widgets/recommended_policy_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/cards/others_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsurancePlannerContentView extends GetView<InsurancePlannerController> {
  const InsurancePlannerContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Obx(() {
            final status = controller.protectionAssessmentStatus;

            return ProtectionScoreContainerSection(
              profile: controller.protectionProfile,
              unmetGoals: controller.unmetProtectionGoals,
              status: status,
            );
          }),
          // Obx(
          //   () => ProtectionScoreContainerSection(
          //     profile: controller.protectionProfile,
          //     unmetGoals: controller.unmetProtectionGoals,
          //     isComplete: controller.areAllProtectionGapsComplete,
          //   ),
          // ),
          SizedBox(height: 20),
          AppSection(
            sectionTitle: 'Protection Gap Breakdown',
            child: Column(
              spacing: 16,
              children: ProtectionType.values.map((type) {
                return Obx(() {
                  final isCompleted =
                      controller.protectionGapCompletion[type] ?? false;

                  final amountCovered = switch (type) {
                    ProtectionType.death =>
                      controller.deathBenefitCovered.value,
                    ProtectionType.criticalIllness =>
                      controller.criticalIllnessCovered.value,
                    ProtectionType.disability =>
                      controller.disabilityCovered.value,
                  };
                  final amountNeed =
                      controller.protectionNeedsTotals[type] ?? 0.0;
                  // final amountNeed = switch (type) {
                  //   case ProtectionType.death => return
                  //     controller.protectionNeedsTotals[type] ?? 0.0;
                  //   ProtectionType.criticalIllness =>
                  //     controller.criticalIllnessNeed.value,
                  //   ProtectionType.disability =>
                  //     controller.disabilityNeed.value,
                  // };

                  return ProtectionGapCard(
                    icon: type.icon,
                    gapTitle: type.label,
                    amountCovered: amountCovered,
                    amountNeed: amountNeed,
                    isCompleted: isCompleted,
                    onTap: () async {
                      await Get.toNamed(type.gapRoute);

                      await controller.refreshProtectionGapCompletion();
                    },
                  );
                });
              }).toList(),
            ),
          ),

          SizedBox(height: 20),
          AppSection(
            sectionTitle: 'Recommended Policies',
            isHorizontalScrolling: true,
            child: Row(
              spacing: 12,
              children: [
                Row(
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  // mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  spacing: 12,
                  children: dummyInsurancePolicyRecommendations
                      .map((policy) => RecommendedPolicyCard(policy: policy))
                      .toList(),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          AppSection(
            sectionTitle: 'Others',
            // showTrailing: true,
            child: Column(
              spacing: 12,
              children: [
                OthersCard(
                  icon: PhosphorIconsRegular.article,
                  title: 'My Policies',
                  onTap: () {
                    Get.toNamed(Routes.INSURANCEPOLICIES);
                  },
                ),
                OthersCard(
                  icon: PhosphorIconsRegular.users,
                  title: 'Beneficiaries',
                  onTap: () {
                    Get.toNamed(Routes.BENEFICIARIES);
                  },
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
        ],
      ),
    );
  }
}
