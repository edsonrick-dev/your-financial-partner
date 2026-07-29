import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/controller/financial_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurnace_planner/widgets/protection_gap_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsurancePlannerScreen extends GetView<FinancialPlannerController> {
  const InsurancePlannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return SingleChildScrollView(
      child: Column(
        spacing: 12,
        children: [
          SizedBox(height: 12),
          _ProtectionScoreContainer(controller: controller),
          AppSection(
            sectionTitle: 'Protection Gaps',
            child: Column(
              spacing: 12,
              children: [
                ProtectionGapCard(
                  color: colorScheme.text,
                  icon: PhosphorIconsRegular.heart,
                  gapTitle: 'Death Benefit Gap',
                  gapAmount: 10000000,
                ),
                ProtectionGapCard(
                  color: colorScheme.text,
                  icon: PhosphorIconsRegular.heart,
                  gapTitle: 'Critical Illness Benefit Gap',
                  gapAmount: 10000000,
                ),
                ProtectionGapCard(
                  color: colorScheme.text,
                  icon: PhosphorIconsRegular.heart,
                  gapTitle: 'Disability Benefit Gap',
                  gapAmount: 10000000,
                ),
              ],
            ),
          ),

          AppSection(
            sectionTitle: 'Others',
            trailingType: SectionTrailingType.textButton,

            onTrailingPressed: () {
              Get.toNamed(Routes.TRANSACTION);
            },
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
                        title: 'Policies',
                      ),
                    ),
                    Expanded(
                      child: OthersCard(
                        icon: PhosphorIconsRegular.users,
                        title: 'Beneficiaries',
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

class OthersCard extends StatelessWidget {
  final IconData icon;
  final String title;
  const OthersCard({
    super.key,
    this.icon = PhosphorIconsRegular.flipHorizontal,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12),
      constraints: BoxConstraints(minHeight: 44),
      decoration: BoxDecoration(
        color: colorScheme.bgLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 12),
          Text(title),
          Spacer(),
          Icon(PhosphorIconsRegular.caretRight, size: 16),
        ],
      ),
    );
  }
}

class CashFlowOverviewTile extends StatelessWidget {
  const CashFlowOverviewTile({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Row(
      children: [
        Row(
          spacing: 12,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Opacity(
                  opacity: 0.2,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: colorScheme.appInflow,
                    ),
                  ),
                ),
                Icon(
                  AppIcons.categories.resolve('wow'),
                  color: colorScheme.appInflow,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Passive Income',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  '3 sources',
                  style: TextStyle(
                    color: colorScheme.textMuted,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ],
        ),
        Spacer(),
        Text(
          8120.toCurrency(),
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 15,
            height: 20 / 15,
            fontFeatures: [FontFeature.tabularFigures()],
          ),
        ),
        SizedBox(width: 12),
      ],
    );
  }
}

class _ProtectionScoreContainer extends StatelessWidget {
  const _ProtectionScoreContainer({required this.controller});

  final FinancialPlannerController controller;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSection(
      // sectionTitle: 'Annual Cashflow',
      child: Container(
        padding: EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.text, colorScheme.gradient2],
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 12,
          children: [
            Text(
              'Protection Score',
              style: TextStyle(
                color: colorScheme.inversePrimary,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Underinsured',
                  style: TextStyle(
                    color: colorScheme.inversePrimary,
                    fontSize: 32,
                    height: 40 / 32,
                    fontFeatures: [FontFeature.tabularFigures()],
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
