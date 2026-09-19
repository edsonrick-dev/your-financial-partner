import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class AscendAssessmentSheet extends StatelessWidget {
  const AscendAssessmentSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSheet(
      adaptiveHeight: true,
      title: "Ascend's Assessment",
      child: AppSection(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 20),
            Text(
              "Let's make Ascend a better financial partner.",
              style: AppTextStyle.displayM,
            ),
            // SizedBox(height: 12),
            // Text(
            //   "Take the assessment for Ascend to better know you.",
            //   style: AppTextStyle.headlineM,
            // ),
            SizedBox(height: 20),
            Text(
              "You've already created your financial picture. Now, "
              "help us understand you—your goals, habits, and mindset—so "
              "Ascend can give you more relevant guidance and a Financial "
              "Stability Profile built around your situation.",
              style: AppTextStyle.bodyL,
              textAlign: TextAlign.justify,
            ),

            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: colorScheme.bgLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(PhosphorIconsRegular.clock, size: 32),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Takes about 2 minutes',
                          style: AppTextStyle.titleL,
                        ),
                        SizedBox(height: 4),
                        Text(
                          'There are no right or wrong answers. Your answers are private and will only be used to personalize your Ascen experience',
                          textAlign: TextAlign.justify,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            AppButton(
              text: 'Start assessment',
              onTap: () {
                Get.toNamed(Routes.ONBOARDING);
              },
            ),

            SizedBox(height: context.bottomPaddingSub),
          ],
        ),
      ),
    );
  }
}
