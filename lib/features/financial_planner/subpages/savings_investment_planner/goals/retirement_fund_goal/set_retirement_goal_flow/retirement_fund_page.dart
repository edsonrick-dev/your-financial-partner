import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_gradient.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/retirement_fund_goal/set_retirement_goal_flow/retirement_lifestyle_setting_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/widget/app_age_picker.dart';
import 'package:getx_drift_app/features/profile/controller/financial_profile_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/app_dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class RetirementFundPage extends GetView<FinancialProfileController> {
  const RetirementFundPage({super.key, required this.type});
  final GoalType type;

  @override
  Widget build(BuildContext context) {
    final type = GoalType.retirement;
    final colorScheme = context.colors;
    return Scaffold(
      appBar: AppBar(
        title: Text('Retirement Goal', style: AppTextStyle.headlineL),
        surfaceTintColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: AppSection(
                child: Column(
                  spacing: 20,
                  children: [
                    _RetirementFundExplainer(type: type),

                    Column(
                      children: [
                        Obx(
                          () => AppDropdownField(
                            label: 'At what age do you want to retire?',
                            value:
                                '${controller.retirementAge.value} years old',
                            showIcon: false,
                            onTap: () {
                              // Current age
                              Get.bottomSheet(
                                // Retirement age
                                AppAgePickerSheet(
                                  title: 'Select your retirement age',
                                  initialAge: controller.retirementAge.value,
                                  minAge: (controller.currentAge ?? 18) + 1,
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

                    Column(
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
                                  initialAge:
                                      controller.retirementFundEndAge.value,
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
                  ],
                ),
              ),
            ),
          ),
          AppSection(
            child: AppButton(
              text: 'Continue',
              onTap: () {
                Get.to(RetirementLifestyleSettingPage());
              },
            ),
          ),
          SizedBox(height: context.bottomPaddingSub),
        ],
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
    return Container(
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
