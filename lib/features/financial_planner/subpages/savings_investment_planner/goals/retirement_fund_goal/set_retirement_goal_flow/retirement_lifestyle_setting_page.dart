import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/set_retirement_goal_flow/retirement_fund_need_page.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RetirementLifestyleSettingPage
    extends GetView<FinancialProfileController> {
  const RetirementLifestyleSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final inflationRate = controller.inflationRate * 100;
    return Scaffold(
      appBar: AppBar(
        title: Text('Retirement Lifestyle', style: AppTextStyle.headlineL),
        surfaceTintColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: AppSection(
          child: Column(
            spacing: 20,
            children: [
              AppSectionBody(
                padding: 16,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What Lifestyle Do You Want in Retirement?',
                      style: AppTextStyle.titleL,
                    ),

                    const SizedBox(height: 8),

                    Text(
                      'Choose how much of your current lifestyle you expect to maintain in retirement.',
                      style: AppTextStyle.bodyM.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),

                    const SizedBox(height: 16),

                    Obx(
                      () => Column(
                        children: [
                          RetirementLifestyleOption(
                            percentage: 1.0,
                            title: 'Maintain my current lifestyle',
                            amount: controller.annualBudget,
                            selected:
                                controller.retirementLifestyleShare.value ==
                                1.0,
                            onTap: () {
                              controller.retirementLifestyleShare.value = 1.0;
                            },
                          ),

                          const SizedBox(height: 8),

                          RetirementLifestyleOption(
                            percentage: 0.8,
                            title: 'Spend somewhat less',
                            amount: controller.annualBudget * 0.8,
                            selected:
                                controller.retirementLifestyleShare.value ==
                                0.8,
                            onTap: () {
                              controller.retirementLifestyleShare.value = 0.8;
                            },
                          ),

                          const SizedBox(height: 8),

                          RetirementLifestyleOption(
                            percentage: 0.6,
                            title: 'Spend considerably less',
                            amount: controller.annualBudget * 0.6,
                            selected:
                                controller.retirementLifestyleShare.value ==
                                0.6,
                            onTap: () {
                              controller.retirementLifestyleShare.value = 0.6;
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.appBorder),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Estimated lifestyle at retirement',
                      style: AppTextStyle.titleL,
                    ),
                    SizedBox(height: 8),
                    Obx(() {
                      final inflatedAnnualLifestyleAtRetirement =
                          controller.futureAnnualRetirementLifestyle;
                      final inflatedMonthlyLifestyleAtRetirement =
                          inflatedAnnualLifestyleAtRetirement / 12;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (inflatedAnnualLifestyleAtRetirement.toCurrency()),
                            style: AppTextStyle.amountXL,
                          ),
                          Text(
                            '≈${((inflatedMonthlyLifestyleAtRetirement).toCurrency())} / month',
                            style: AppTextStyle.amountL.copyWith(
                              color: colorScheme.appTextMuted,
                            ),
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: 16),
                    Obx(() {
                      final yearsToRetirement = controller.yearsToRetirement;
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Projected over ${(yearsToRetirement.toStringAsFixed(0))} years',
                            style: AppTextStyle.titleL,
                          ),
                          Text(
                            '(age ${controller.currentAge} → ${controller.retirementAge})',
                            style: AppTextStyle.titleL.copyWith(
                              color: colorScheme.appTextMuted,
                            ),
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: 16),
                    AdaptivePressable(
                      onTap: () {
                        Get.bottomSheet(InflationExplainer());
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 8,
                          horizontal: 8,
                        ),
                        decoration: BoxDecoration(
                          color: colorScheme.bgLight,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Inflation assumption: ${(inflationRate.toStringAsFixed(1))}% / year',
                                style: AppTextStyle.labelM,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(PhosphorIconsRegular.info, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Obx(
                () => AppButton(
                  isLoading: controller.isCalculatingRetirementFund.value,
                  text: 'Calculate my retirement fund need',
                  onTap: () async {
                    final success = await controller
                        .calculateRetirementFundNeed();

                    if (!success) return;

                    Get.to(() => RetirementFundNeedPage());
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class RetirementLifestyleOption extends StatelessWidget {
  const RetirementLifestyleOption({
    super.key,
    required this.percentage,
    required this.title,
    required this.amount,
    required this.selected,
    required this.onTap,
  });

  final double? percentage;
  final String title;
  final double? amount;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: selected
              ? colorScheme.primary.withValues(alpha: 0.08)
              : colorScheme.bg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected
                ? colorScheme.primary
                : colorScheme.appTextMuted.withValues(alpha: 0.2),
          ),
        ),
        child: Row(
          children: [
            SizedBox(
              width: 60,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  percentage == null
                      ? 'Custom'
                      : '${(percentage! * 100).round()}%',
                  style: AppTextStyle.titleL,
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyle.titleS),

                  if (amount != null)
                    Text(
                      amount!.toCurrency(),
                      style: AppTextStyle.amountL.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                ],
              ),
            ),

            Icon(
              selected
                  ? PhosphorIconsFill.checkCircle
                  : PhosphorIconsRegular.circle,
            ),
          ],
        ),
      ),
    );
  }
}

class InflationExplainer extends GetView<FinancialProfileController> {
  const InflationExplainer({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final inflationRate = controller.inflationRate * 100;
    return AppSheet(
      adaptiveHeight: true,
      title: 'Inflation Rate',
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppSection(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'We use inflation to estimate how '
                  'your desired lifestyle may change '
                  'over time.',
                  style: AppTextStyle.bodyL,
                ),
                SizedBox(height: 16),
                Text(
                  'Inflation assumption',
                  style: AppTextStyle.titleL.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),
                Text(
                  '${inflationRate.toStringAsFixed(2)}%',
                  style: AppTextStyle.amountXL,
                ),

                SizedBox(height: 16),
                Text(
                  'This affects your projected lifestyle '
                  'and the amount you may need for '
                  'retirement.',
                  style: AppTextStyle.bodyM.copyWith(
                    color: colorScheme.appTextMuted,
                  ),
                ),
                SizedBox(height: context.bottomPaddingSub),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
