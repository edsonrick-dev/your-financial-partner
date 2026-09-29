import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SavingsPlannerEmptyView extends StatelessWidget {
  const SavingsPlannerEmptyView({super.key});

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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      PhosphorIconsRegular.coins,
                      size: 60,
                      color: colorScheme.appAccent,
                    ),
                    Text(
                      textAlign: TextAlign.center,
                      "Ascend's Savings & Investments Planner",
                      style: AppTextStyle.headlineL,
                    ),

                    Text(
                      "Make your money work for your goals",
                      style: AppTextStyle.headlineS,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 4),
                    Text(
                      "Take our risk tolerance assessment, understand your risk profile, set your financial goals, and track whether your savings and investments are keeping you on course.",
                      style: AppTextStyle.bodyM.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20),
                    AppButton(
                      text: "Take Ascend's Risk Tolerance Assessment",
                      onTap: () {
                        Get.toNamed(Routes.RISKTOLERANCEASSESSMENT);
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24),
            // Spacer(),
            AppSection(
              sectionTitle: 'What are Savings & Investments?',
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
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  maxLines: 2,
                                  'Savings & Investments → Goals Progress',
                                  style: AppTextStyle.labelM,
                                ),
                              ),
                              // FittedBox(
                              //   child: Text(
                              //     'Money allocated toward your financial goals',
                              //     style: AppTextStyle.labelM,
                              //   ),
                              // ),
                              SizedBox(height: 8),
                              Text(
                                "Your savings and investments are the means to achieve your financial goals. Ascend helps you determine how much to contribute, understand your risk tolerance, and track your progress toward each goal.",
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
