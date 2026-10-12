import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/widgets/protection_gap_details_header.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/1_death_benefit/details_view/slides/death_needs_slide.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class DeathBenefitDetailsView extends GetView<InsurancePlannerController> {
  const DeathBenefitDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final type = ProtectionType.death;
    return Scaffold(
      backgroundColor: colorScheme.surface,

      body: Column(
        children: [
          AppDetailsHeader(
            title: 'Death Benefit Gap',
            child: Obx(
              () => ProtectionGapDetailsHeader(
                severity: controller.deathBenefitSeverity,
                protectionNeed: controller.deathBenefitNeed.value,
                protectionSource: controller.deathBenefitCovered.value,
              ),
            ),
          ),

          AppDetailsPageActionSection(
            selectedIndex: controller.selectedDeathDetailsIndex,
            actions: const ['Needs', 'Sources'],
            // onAdd: () {
            //   // Add source/need action
            // },
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedDeathDetailsIndex.value,
                children: [
                  DeathNeedsSlide(type: type),
                  DeathSourcesSlide(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DeathSourcesSlide extends StatelessWidget {
  const DeathSourcesSlide({super.key});

  @override
  Widget build(BuildContext context) {
    // final colorScheme = context.colors;
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
      child: Column(
        children: [
          AppSection(
            sectionTitle: 'Insurance Sources',
            child: Column(children: [InsurancePolicyCard()]),
          ),
          AppSection(sectionTitle: 'Non-Insurance Sources', child: Column()),
          // const InsuranceUnderConstructionView(
          //   title: 'Sources are coming soon',
          //   description:
          //       'We’re still building this part of your protection plan.',
          // ),
        ],
      ),
    );
  }
}

class InsurancePolicyCard extends StatelessWidget {
  const InsurancePolicyCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppCard(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(PhosphorIconsRegular.acorn),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'AIA Critical Protection 100',
                        style: AppTextStyle.titleL,
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      100000.toCompactCurrency(),
                      style: AppTextStyle.amountL.copyWith(
                        fontSize: 20,
                        height: 24 / 20,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8),
                Text(
                  'This is the description of the policy',
                  style: AppTextStyle.labelM.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
