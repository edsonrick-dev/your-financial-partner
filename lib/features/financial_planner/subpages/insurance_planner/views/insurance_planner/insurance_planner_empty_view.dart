import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/financial_planner_empty_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/insurance_planner/insurance_planner_content_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/widgets/insurance_assessment_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsurancePlannerEmptyView extends StatelessWidget {
  const InsurancePlannerEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.only(
          top: context.topPadding,
          bottom: context.bottomPadding,
        ),
        child:
            //     Column(
            //       // mainAxisAlignment: MainAxisAlignment.center,
            //       crossAxisAlignment: CrossAxisAlignment.center,
            //       mainAxisSize: MainAxisSize.max,
            //       children: [
            //         Expanded(
            //           child: Padding(
            //             padding: const EdgeInsets.symmetric(horizontal: 24.0),
            //             child: Column(
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Icon(
            //                   PhosphorIconsRegular.shieldPlus,
            //                   size: 60,
            //                   color: colorScheme.appAccent,
            //                 ),
            //                 Text(
            //                   "Ascend's Insurance Planner",
            //                   style: AppTextStyle.headlineL,
            //                 ),
            //                 Text(
            //                   "See how prepared you are for life's what-ifs",
            //                   style: AppTextStyle.headlineS,
            //                   textAlign: TextAlign.center,
            //                 ),
            //                 SizedBox(height: 4),
            //                 Text(
            //                   "Understand what you need to protect and whether your current coverage may leave gaps.",
            //                   style: AppTextStyle.bodyM.copyWith(
            //                     color: colorScheme.appTextMuted,
            //                   ),
            //                   textAlign: TextAlign.center,
            //                 ),
            //                 SizedBox(height: 20),
            //                 AppButton(
            //                   text: 'Plan my insurance need',
            //                   onTap: () {
            //                     Get.bottomSheet(
            //                       InsuranceQuestionnaireSheet(),
            //                       isScrollControlled: true,
            //                     );
            //                     // Get.toNamed(Routes.CASHFLOWDETAILS);
            //                   },
            //                 ),
            //               ],
            //             ),
            //           ),
            //         ),
            //         SizedBox(height: 24),
            //         // Spacer(),
            //         AppSection(
            //           sectionTitle: 'What is Insurance?',
            //           child: Column(
            //             children: [
            //               Container(
            //                 constraints: BoxConstraints(minHeight: 52),
            //                 width: double.infinity,
            //                 padding: const EdgeInsets.all(16),
            //                 decoration: BoxDecoration(
            //                   borderRadius: BorderRadius.circular(12),
            //                   color: colorScheme.bgLight,
            //                   border: Border.all(color: colorScheme.appBorder),
            //                   boxShadow: [
            //                     BoxShadow(
            //                       color: colorScheme.text.withValues(alpha: 0.06),
            //                       blurRadius: 8,
            //                       offset: const Offset(0, 2),
            //                     ),
            //                   ],
            //                 ),
            //                 child: Row(
            //                   children: [
            //                     Expanded(
            //                       child: Column(
            //                         crossAxisAlignment: CrossAxisAlignment.start,
            //                         children: [
            //                           FittedBox(
            //                             child: Text(
            //                               'Insurance Gap = Needs – Sources',
            //                               style: AppTextStyle.labelM,
            //                             ),
            //                           ),
            //                           SizedBox(height: 8),
            //                           Text(
            //                             "Your needs are what you want to protect. "
            //                             "Your sources are what you already have available to protect them.",
            //                           ),
            //                         ],
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             ],
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // );
            AppSection(
              child: FinancialPlannerEmptySection(
                icon: PhosphorIconsRegular.shieldPlus,
                title: 'Protection planning\nis coming soon',
                description:
                    'We’re still building this part of Ascend. Insurance planning will help you understand your protection needs and identify gaps in your coverage.',
              ),
            ),
      ),
    );
  }
}

class InsuranceQuestionnaireSheet extends GetView<InsurancePlannerContentView> {
  const InsuranceQuestionnaireSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      height: AppSheetHeight.full,
      title: 'Plan Your Protection',
      child: SingleChildScrollView(
        child: Column(
          children: [
            AppSection(
              child: Column(
                children: [
                  Text(
                    "Answer a few questions about each type of "
                    "protection. Ascend will use your financial "
                    "plan to estimate your needs and identify any "
                    "coverage gaps.",
                    style: AppTextStyle.bodyL,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            AppSection(
              sectionTitle: 'Protection Assessments',
              trailingText: '0/3 completed',
              child: Column(
                spacing: 20,
                children: [
                  ///Death Benefit

                  ///Critical Illness Benefit
                  InsuranceAssessmentCard(
                    onTap: () {
                      Get.back();
                      Get.toNamed(Routes.DEATHEBENFITQUESTIONNAIRE);
                    },
                    icon: PhosphorIconsRegular.shield,
                    title: 'Death Benefit',
                    description:
                        'Protect the people and expenses that may remain after your death.',
                  ),
                  InsuranceAssessmentCard(
                    icon: PhosphorIconsRegular.hospital,
                    title: 'Critical Illness Benefit',
                    description:
                        'Prepare for the financial impact of a serious illness.',
                  ),
                  InsuranceAssessmentCard(
                    icon: PhosphorIconsRegular.wheelchair,
                    title: 'Disability Benefit',
                    description:
                        'Protect you and your family if a disability prevents you from working.',
                  ),
                  SizedBox(height: context.bottomPaddingSub),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
