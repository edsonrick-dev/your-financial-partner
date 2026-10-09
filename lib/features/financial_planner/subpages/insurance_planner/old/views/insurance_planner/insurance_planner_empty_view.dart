import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/views/insurance_planner/protection_questionnaire_sheet.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
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
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            SizedBox(height: 48),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      PhosphorIconsRegular.shieldPlus,
                      size: 60,
                      color: colorScheme.appAccent,
                    ),
                    Text(
                      "Ascend's Insurance Planner",
                      style: AppTextStyle.headlineL,
                    ),
                    Text(
                      "See how prepared you are for life's what-ifs",
                      style: AppTextStyle.headlineS,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Understand what you need to protect and whether your current coverage may leave gaps.",
                      style: AppTextStyle.bodyM.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    AppButton(
                      text: 'Plan my insurance need',
                      onTap: () {
                        Get.bottomSheet(
                          ProtectionQuestionnaireSheet(),
                          isScrollControlled: true,
                        );
                        // Get.toNamed(Routes.CASHFLOWDETAILS);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            // Spacer(),
            AppSection(
              sectionTitle: 'What is Insurance?',
              child: Column(
                children: [
                  Container(
                    constraints: BoxConstraints(minHeight: 52),
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: colorScheme.bgLight,
                      border: Border.all(color: colorScheme.appBorder),
                      boxShadow: [
                        BoxShadow(
                          color: colorScheme.text.withValues(alpha: 0.06),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  'Insurance Gap = Needs – Sources',
                                  style: AppTextStyle.labelM,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                "Your needs are what you want to protect. "
                                "Your sources are what you already have available to protect them.",
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
