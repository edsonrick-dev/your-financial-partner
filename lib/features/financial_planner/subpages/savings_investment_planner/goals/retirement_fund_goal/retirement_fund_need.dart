import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/projection/retirement_projection_engine.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/widget/app_age_picker.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/app_dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class RetirementFundNeed extends GetView<FinancialProfileController> {
  const RetirementFundNeed({super.key});

  @override
  Widget build(BuildContext context) {
    final type = GoalType.retirement;
    final colorScheme = context.colors;
    final inflationRate = controller.inflationRate * 100;

    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          children: [
            _RetirementFundExplainer(type: type),
            SizedBox(height: 20),

            AppSection(
              child: Column(
                children: [
                  AppDropdownField(
                    label: 'How old are you now?',
                    value: '${controller.currentAge.value} years old',
                    showIcon: false,
                    onTap: () {
                      // Current age
                      Get.bottomSheet(
                        AppAgePickerSheet(
                          title: 'Select your age',
                          initialAge: controller.currentAge.value,
                          minAge: 18,
                          maxAge: 80,
                          onContinue: (age) {
                            controller.currentAge.value = age;
                          },
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'This determines how many years you have to build your retirement fund.',
                    style: AppTextStyle.bodyS.copyWith(
                      color: colorScheme.appTextMuted,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            AppSection(
              child: Column(
                children: [
                  Obx(
                    () => AppDropdownField(
                      label: 'At what age do you want to retire?',
                      value: '${controller.retirementAge.value} years old',
                      showIcon: false,
                      onTap: () {
                        // Current age
                        Get.bottomSheet(
                          // Retirement age
                          AppAgePickerSheet(
                            title: 'Select your retirement age',
                            initialAge: controller.retirementAge.value,
                            minAge: controller.currentAge.value + 1,
                            maxAge: 80,
                            onContinue: (age) {
                              controller.retirementAge.value = age;
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'Your retirement age determines how long your savings have to grow before you begin withdrawing from them.',
                    style: AppTextStyle.bodyS.copyWith(
                      color: colorScheme.appTextMuted,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 20),
            AppSection(
              child: Column(
                children: [
                  Obx(
                    () => AppDropdownField(
                      label: 'How long should your retirement fund last?',
                      value:
                          '${controller.retirementFundEndAge.value} years old',
                      showIcon: false,
                      onTap: () {
                        // Current age
                        Get.bottomSheet(
                          // Fund end age
                          AppAgePickerSheet(
                            title:
                                'Select when your retirement fund should last until',
                            initialAge: controller.retirementFundEndAge.value,
                            minAge: controller.retirementAge.value,
                            maxAge: 100,
                            onContinue: (age) {
                              controller.retirementFundEndAge.value = age;
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    'Choose the age your retirement savings should support you until.',
                    style: AppTextStyle.bodyS.copyWith(
                      color: colorScheme.appTextMuted,
                    ),
                  ),
                ],
              ),
            ),

            AppSection(
              child: AppSectionBody(
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
            ),
            SizedBox(height: 20),
            AppSection(
              child: Container(
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
            ),
            const SizedBox(height: 20),
            AppSection(
              child: AppButton(
                text: 'Calculate',
                onTap: () {
                  controller.calculateRetirementFundNeed();
                },
              ),
            ),
            const SizedBox(height: 20),
            AppSection(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.appBorder),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Obx(() {
                  final retirementFundNeed =
                      controller.retirementFundNeed.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Retirement fund needed',
                        style: AppTextStyle.titleL,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'The amount you may need when you retire to support '
                        'your planned lifestyle until age ${controller.retirementFundEndAge}.',
                        style: AppTextStyle.bodyM.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),

                      const SizedBox(height: 16),

                      Text(
                        retirementFundNeed.toCurrency(),
                        style: AppTextStyle.amountXL,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Required at age ${controller.retirementAge}',
                        style: AppTextStyle.amountL.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),
                    ],
                  );
                }),
              ),
            ),
            SizedBox(height: 20),
            AppSection(
              sectionTitle: 'How your fund may last',
              subtitle:
                  'Projected withdrawals and remaining balance through age 80.',
              isHorizontalScrolling: true,
              child: Obx(() {
                final projections = controller.retirementProjection.toList();

                return _RetirementWithdrawalTable(projections: projections);
              }),
            ),
            const SizedBox(height: 20),

            AppSection(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: colorScheme.appBorder),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Obx(() {
                  final retirementFundNeed =
                      controller.retirementFundNeed.value;

                  final currentRetirementSavings =
                      controller.currentRetirementSavings.value;

                  final requiredMonthlyContribution =
                      controller.requiredMonthlyContribution.value;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Build your retirement fund',
                        style: AppTextStyle.titleL,
                      ),

                      const SizedBox(height: 8),

                      Text(
                        'Build toward your retirement fund by making regular investments.',
                        style: AppTextStyle.bodyM.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),

                      const SizedBox(height: 20),

                      Text(
                        'Retirement fund needed',
                        style: AppTextStyle.titleS.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),

                      Text(
                        retirementFundNeed.toCurrency(),
                        style: AppTextStyle.amountXL,
                      ),

                      const SizedBox(height: 16),

                      Text(
                        'Current retirement savings',
                        style: AppTextStyle.titleS.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),

                      Text(
                        currentRetirementSavings.toCurrency(),
                        style: AppTextStyle.amountXL,
                      ),

                      const SizedBox(height: 16),

                      Text(
                        'Required monthly investment',
                        style: AppTextStyle.titleS.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),

                      Text(
                        requiredMonthlyContribution.toCurrency(),
                        style: AppTextStyle.amountXL,
                      ),
                      Text(
                        'Based on your retirement fund target and a portfolio that gradually shifts toward more conservative investments as your withdrawals approach.',
                        style: AppTextStyle.bodyL,
                      ),
                    ],
                  );
                }),
              ),
            ),
            SizedBox(height: context.bottomPaddingSub),
          ],
        ),
      ),
    );
  }
}

class _RetirementFundExplainer extends StatelessWidget {
  const _RetirementFundExplainer({required this.type});

  final GoalType type;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppSection(
      child: Container(
        padding: EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: AppGradient.gradientA(colorScheme),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          children: [
            Icon(type.icon, size: 60, color: colorScheme.appInversedtext),
            SizedBox(height: 16),

            Text(
              'Plan Your Retirement',
              style: AppTextStyle.headlineM.copyWith(
                color: colorScheme.appInversedtext,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 12),

            Text(
              'Let’s determine how much you may need to fund the lifestyle you want in retirement.',
              style: AppTextStyle.bodyL.copyWith(
                color: colorScheme.appInversedtext,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _RetirementWithdrawalTable extends StatelessWidget {
  final List<RetirementProjection> projections;

  const _RetirementWithdrawalTable({required this.projections});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    final textStyle = AppTextStyle.amountS;
    final headerStyle = AppTextStyle.titleM;
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.bgLight,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: DataTable(
        columnSpacing: 16,
        horizontalMargin: 8,
        columns: [
          DataColumn(label: Text('Age', style: headerStyle)),
          DataColumn(
            label: Text('Beginning', style: headerStyle),
            numeric: true,
          ),
          DataColumn(
            label: Text('Withdrawal', style: headerStyle),
            numeric: true,
          ),
          DataColumn(
            label: Text('Remaining', style: headerStyle),
            numeric: true,
          ),
          DataColumn(label: Text('Return', style: headerStyle), numeric: true),
          DataColumn(label: Text('Growth', style: headerStyle), numeric: true),
          DataColumn(label: Text('Ending', style: headerStyle), numeric: true),
        ],
        rows: projections.map((projection) {
          return DataRow(
            cells: [
              DataCell(Text(projection.age.toString(), style: textStyle)),
              DataCell(
                Text(
                  projection.beginningBalance.toCompactCurrency(
                    kThreshold: 100000,
                  ),
                  style: textStyle,
                ),
              ),

              DataCell(
                Text(
                  '-${projection.withdrawal.toCompactCurrency(kThreshold: 100000)}',
                  style: textStyle.copyWith(color: colorScheme.appOutflow),
                ),
              ),
              DataCell(
                Text(
                  (projection.remainingBalance).toCompactCurrency(
                    kThreshold: 100000,
                  ),
                  style: textStyle,
                ),
              ),
              DataCell(
                Text(
                  '+${(projection.returnRate * 100).toStringAsFixed(1)}%',
                  style: textStyle.copyWith(color: colorScheme.appInflow),
                ),
              ),
              DataCell(
                Text(
                  '+${projection.interestEarned.toCompactCurrency(kThreshold: 100000)}',
                  style: textStyle.copyWith(color: colorScheme.appInflow),
                ),
              ),
              DataCell(
                Text(
                  projection.endBalance.toCompactCurrency(kThreshold: 100000),
                  style: textStyle,
                ),
              ),
            ],
          );
        }).toList(),
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

class RetirementAgePicker extends StatefulWidget {
  const RetirementAgePicker({
    super.key,
    required this.initialAge,
    required this.onChanged,
  });

  final int initialAge;
  final ValueChanged<int> onChanged;

  @override
  State<RetirementAgePicker> createState() => _RetirementAgePickerState();
}

class _RetirementAgePickerState extends State<RetirementAgePicker> {
  late int selectedAge;

  @override
  void initState() {
    super.initState();
    selectedAge = widget.initialAge;
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 41, // 50–90
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemBuilder: (context, index) {
          final age = 50 + index;
          final isSelected = age == selectedAge;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedAge = age;
              });

              widget.onChanged(age);
            },
            child: SizedBox(
              width: 56,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: isSelected ? 56 : 44,
                    width: isSelected ? 56 : 44,
                    decoration: BoxDecoration(
                      color: isSelected ? colorScheme.primary : colorScheme.bg,
                      shape: BoxShape.circle,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '$age',
                      style: isSelected
                          ? AppTextStyle.titleL
                          : AppTextStyle.titleM.copyWith(
                              color: colorScheme.appTextMuted,
                            ),
                    ),
                  ),
                  const SizedBox(height: 6),
                  if (isSelected)
                    Container(
                      height: 4,
                      width: 4,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
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
