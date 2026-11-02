import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_snackbar.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/domain/enums/app_snack_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/sections/protection_score_container_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/planner/content_view/sections/financial_consultation_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/planner/content_view/widgets/protection_gap_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/cards/others_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
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
          FinancialConsultationSection(),
          SizedBox(height: 20),
          AppSection(
            sectionTitle: 'Insurance Offers',
            child: _InsuranceOfferWaiting(),
          ),
          // SizedBox(height: 20),
          // AppSection(
          //   sectionTitle: 'Recommended Policies',
          //   isHorizontalScrolling: true,
          //   child: Row(
          //     spacing: 12,
          //     children: [
          //       Row(
          //         // crossAxisAlignment: CrossAxisAlignment.start,
          //         // mainAxisAlignment: MainAxisAlignment.start,
          //         mainAxisSize: MainAxisSize.min,
          //         spacing: 12,
          //         children: dummyInsurancePolicyRecommendations
          //             .map((policy) => RecommendedPolicyCard(policy: policy))
          //             .toList(),
          //       ),
          //     ],
          //   ),
          // ),
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

class _InsuranceOfferNotStartedCard extends StatelessWidget {
  const _InsuranceOfferNotStartedCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppSectionBody(
      padding: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Explore insurance offers',
                  style: AppTextStyle.titleL,
                ),
              ),
              const SizedBox(width: 12),
              Icon(PhosphorIconsRegular.book, color: colors.appAccent),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "Ascend partners with insurance providers who use your financial profile and protection needs to prepare offers tailored to you.",
            style: AppTextStyle.bodyM.copyWith(),
          ),
          const SizedBox(height: 16),
          AppButton(
            text: 'Start receiving offers',
            onTap: () {
              Get.bottomSheet(
                _StartReceivingOfferSheet(),
                isScrollControlled: true,
              );
            },
            // leadingIcon: PhosphorIconsRegular.calendarBlank,
          ),
          const SizedBox(height: 6),
          Text(
            'Offers are anonymous. Only birthday, gender, cash flow and protection data are shared; net worth details remain private.',
            style: AppTextStyle.labelS.copyWith(color: colors.appTextMuted),
          ),
        ],
      ),
    );
  }
}

class _InsuranceOfferWaiting extends StatelessWidget {
  const _InsuranceOfferWaiting();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return AppSectionBody(
      padding: 24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  'Your insurance offers are in progress',
                  style: AppTextStyle.titleL,
                ),
              ),
              const SizedBox(width: 12),
              Icon(PhosphorIconsRegular.hourglassHigh, color: colors.appAccent),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "We're waiting for insurance agents to prepare offers based on your protection needs.",
            style: AppTextStyle.bodyM.copyWith(),
          ),
          const SizedBox(height: 16),
          Text('1 of 2 offers received', style: AppTextStyle.headlineM),
          const SizedBox(height: 12),

          AppCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AIA Philippines', style: AppTextStyle.titleL),

                Text(
                  '3-policy bundle | Expires in 14 days',
                  style: AppTextStyle.bodyS,
                ),

                SizedBox(height: 16),
                Text('View offer', style: AppTextStyle.titleM),
              ],
            ),
          ),
          Divider(color: colors.appTextMuted),
          Text(
            "Your personal and contact information stays private. Agents cannot contact you unless you choose to proceed with an offer",
            style: AppTextStyle.labelS.copyWith(color: colors.appTextMuted),
          ),
        ],
      ),
    );
  }
}

class _StartReceivingOfferSheet extends StatelessWidget {
  const _StartReceivingOfferSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      height: AppSheetHeight.full,
      title: 'Receive Insurance Offers',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: AppSection(
          child: Column(
            spacing: 20,
            children: [
              Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Start receiving insurance offers?',
                    style: AppTextStyle.titleL,
                  ),
                  Text(
                    "Ascend will share your cash flow data and protection breakdown with partner insurance providers so they can submit offers suited to your needs.",
                    style: AppTextStyle.bodyM,
                  ),
                ],
              ),
              Column(
                spacing: 12,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('What happens next?', style: AppTextStyle.titleL),
                  _WhatHappensNextTile(
                    title: "1. Receive offers from multiple insurers.",
                    body:
                        "Our insurance agent partners help you receive offers from different insurance companies based on your protection needs.",
                  ),
                  _WhatHappensNextTile(
                    title: "2. Compare offers privately.",
                    body:
                        "Review and compare insurance companies, coverage, benefits, and premiums without revealing your identity or contact information to insurance agents.",
                  ),
                  _WhatHappensNextTile(
                    title: "3. You're in control.",
                    body:
                        "Choose which offer you'd like to proceed with to connect with the agent, or decline all offers. Your contact information will only be shared when you choose to connect, and there's no obligation to buy.",
                  ),
                ],
              ),

              Column(
                spacing: 16,
                children: [
                  AppButton(
                    text: 'Confirm and start',
                    onTap: () async {
                      Get.back();
                      AppSnackbar.show(
                        type: AppSnackType.success,
                        title: 'Offer Request Submitted',
                        message:
                            'Your request has been submitted to our insurance partners. Offers will appear here as they become available.',
                      );
                    },
                  ),
                  AppButton(
                    text: 'Not now',
                    onTap: () {
                      Get.back();
                    },
                    type: ButtonType.ghost,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WhatHappensNextTile extends StatelessWidget {
  const _WhatHappensNextTile({required this.title, required this.body});
  final String title;
  final String body;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 4,
      children: [
        Text(title, style: AppTextStyle.titleL),
        Text(body, style: AppTextStyle.bodyM),
      ],
    );
  }
}
