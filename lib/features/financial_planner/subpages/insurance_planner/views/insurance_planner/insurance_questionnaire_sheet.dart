import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/insurance_planner/insurance_planner_content_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/widgets/insurance_assessment_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
