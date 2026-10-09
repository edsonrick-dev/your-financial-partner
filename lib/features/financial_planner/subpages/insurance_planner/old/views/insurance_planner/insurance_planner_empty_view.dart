import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/shell/protection_questionnaire_sheet.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class InsurancePlannerEmptyView extends GetView<InsurancePlannerController> {
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
                    SizedBox(height: 20),
                    AppButton(
                      text: 'Open Death Benefit Sheet Design',
                      onTap: () {
                        Get.bottomSheet(
                          DeathBenefitNeedSheet(),
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

class DeathBenefitNeedSheet extends StatelessWidget {
  const DeathBenefitNeedSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSheet(
      height: AppSheetHeight.full,
      title: 'Death Benefit Need',
      child: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: Column(
          children: [
            Text('Plan Created on October 5, 2026', style: AppTextStyle.labelM),
            AppSection(
              sectionTitle: 'Period Details',
              child: Column(
                spacing: 20,
                children: [
                  AppSectionBody(
                    padding: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Plan Validity",
                          style: AppTextStyle.labelM.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Planning Timeframe',
                                style: AppTextStyle.titleL,
                              ),
                            ),
                            Text('5 years', style: AppTextStyle.amountL),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          "Projects expenses forward to account for inflation before the support period.",
                          style: AppTextStyle.bodyM,
                        ),
                      ],
                    ),
                  ),
                  AppSectionBody(
                    padding: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Protection Horizon',
                                style: AppTextStyle.titleL,
                              ),
                            ),
                            Text('10 years', style: AppTextStyle.amountL),
                          ],
                        ),
                        SizedBox(height: 4),
                        Text(
                          'How long your family needs financial support after your death.',
                          style: AppTextStyle.bodyM,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            AppSection(
              sectionTitle: 'Family Expense Continuity',
              child: Column(
                spacing: 20,
                children: [
                  AppSectionBody(
                    padding: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Current Annual Expenses',
                          style: AppTextStyle.titleL,
                        ),
                        Text(
                          "Today's cost of maintaning your family's lifestyle, before inflation",
                          style: AppTextStyle.labelM.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),

                        SizedBox(height: 16),
                        Column(
                          spacing: 8,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Annual',
                                        style: AppTextStyle.titleM,
                                      ),
                                      Text(
                                        '2026',
                                        style: AppTextStyle.bodyS.copyWith(
                                          color: colorScheme.appTextMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      264120.toCurrency(),
                                      style: AppTextStyle.amountL,
                                    ),
                                    Text(
                                      "${22010.toCurrency()}/mo",
                                      style: AppTextStyle.amountS.copyWith(
                                        color: context.colors.appTextMuted,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  AppSectionBody(
                    padding: 16,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Projected Annual Expenses',
                          style: AppTextStyle.titleL,
                        ),
                        Text(
                          'Based on 3% annual inflation',
                          style: AppTextStyle.labelM.copyWith(
                            color: colorScheme.appTextMuted,
                          ),
                        ),

                        SizedBox(height: 16),
                        Column(
                          spacing: 8,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('2031', style: AppTextStyle.titleM),
                                      Text(
                                        'After 5 years • Year 1',
                                        style: AppTextStyle.bodyS.copyWith(
                                          color: colorScheme.appTextMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      264120.toCurrency(),
                                      style: AppTextStyle.amountL,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('2032', style: AppTextStyle.titleM),
                                      Text(
                                        'After 6 years • Year 2',
                                        style: AppTextStyle.bodyS.copyWith(
                                          color: colorScheme.appTextMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      264120.toCurrency(),
                                      style: AppTextStyle.amountL,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Text('...', style: AppTextStyle.titleM),

                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('2039', style: AppTextStyle.titleM),
                                      Text(
                                        'After 14 years • Year 9',
                                        style: AppTextStyle.bodyS.copyWith(
                                          color: colorScheme.appTextMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      264120.toCurrency(),
                                      style: AppTextStyle.amountL,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('2040', style: AppTextStyle.titleM),
                                      Text(
                                        'After 15 years • Year 10',
                                        style: AppTextStyle.bodyS.copyWith(
                                          color: colorScheme.appTextMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      264120.toCurrency(),
                                      style: AppTextStyle.amountL,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
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
