import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/subpages/insurance_under_construction_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/views/insurance_planner/insurance_planner_empty_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/widgets/protection_gap_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_details_header.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
            actions: const ['Needs', 'Sources'],
            // onAdd: () {
            //   // Add source/need action
            // },
          ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.selectedDeathDetailsIndex.value,
                children: const [DeathNeedsContent(), DeathSourceContent()],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProtectionNeedCard extends GetView<InsurancePlannerController> {
  const ProtectionNeedCard({
    super.key,
    required this.icon,
    required this.title,
    required this.description,
    required this.amount,
    this.countLabel,
    this.count,
    this.onTap,
  });
  final IconData icon;
  final String title;
  final String description;
  final double amount;
  final double? count;
  final String? countLabel;
  final VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSection(
      child: Column(
        children: [
          AdaptivePressable(
            onTap: onTap,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.bgLight,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(icon),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(title, style: AppTextStyle.titleL),
                            ),
                            SizedBox(width: 16),
                            Text(
                              amount == 0
                                  ? amount.toCurrency(decimalDigits: 0)
                                  : amount.toCompactCurrency(),
                              style: AppTextStyle.amountL.copyWith(
                                fontSize: 20,
                                height: 24 / 20,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          description,
                          style: AppTextStyle.labelM.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),
                        // if (count != null && countLabel != null)
                        //   Text(
                        //     '${count!.toStringAsFixed(0)} $countLabel',
                        //     style: AppTextStyle.titleL,
                        //   ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DeathNeedsContent extends StatelessWidget {
  const DeathNeedsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
      child: Column(
        spacing: 20,
        children: [
          ProtectionNeedCard(
            icon: PhosphorIconsRegular.users,
            title: 'Family Expense Continuity Fund',
            description:
                "Supports your family's living expenses throughout the selected protection horizon",
            amount: 4726072.34,
            onTap: () {
              Get.bottomSheet(
                DeathBenefitNeedSheet(),
                isScrollControlled: true,
              );
            },
          ),
          ProtectionNeedCard(
            icon: PhosphorIconsRegular.heartBreak,
            title: 'Funeral and Final Expense',
            description:
                'Covers estimated funeral costs and other end-of-life expenses',
            amount: 150000.34,
            onTap: () {
              Get.bottomSheet(
                DeathBenefitNeedSheet(),
                isScrollControlled: true,
              );
            },
          ),
          ProtectionNeedCard(
            icon: PhosphorIconsRegular.bank,
            title: 'Debts and Obligations',
            description:
                'Accounts for outstanding liabilities your family may need to settle',
            amount: 150000.34,
            onTap: () {
              Get.bottomSheet(
                DeathBenefitNeedSheet(),
                isScrollControlled: true,
              );
            },
          ),
          ProtectionNeedCard(
            icon: PhosphorIconsRegular.houseLine,
            title: 'Estate Settlement Fund',
            description:
                'Provides for estimated costs associated with settling your estate',
            amount: 0,
            onTap: () {
              Get.bottomSheet(
                DeathBenefitNeedSheet(),
                isScrollControlled: true,
              );
            },
          ),
          ProtectionNeedCard(
            icon: PhosphorIconsRegular.graduationCap,
            title: 'Education Funding',
            description:
                'Provides for the future education expenses included in your plans',
            amount: 150000,
            count: 3,
            countLabel: 'Plans',
            onTap: () {
              Get.bottomSheet(
                DeathBenefitNeedSheet(),
                isScrollControlled: true,
              );
            },
          ),
        ],
      ),
    );
    // const InsuranceUnderConstructionView(
    //   title: 'Needs are coming soon',
    //   description: 'We’re still building this part of your protection plan.',
    // );
  }
}

class DeathSourceContent extends StatelessWidget {
  const DeathSourceContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const InsuranceUnderConstructionView(
      title: 'Sources are coming soon',
      description: 'We’re still building this part of your protection plan.',
    );
  }
}
