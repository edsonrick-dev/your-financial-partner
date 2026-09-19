import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class FinancialDependencyQuestion extends GetView<InsurancePlannerController> {
  const FinancialDependencyQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    return AppSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Who depends on your income or shares essential expenses with you?",
            style: AppTextStyle.headlineM,
          ),
          SizedBox(height: 16),
          Text('Select one.', style: AppTextStyle.bodyL),
          SizedBox(height: 16),
          Obx(
            () => Column(
              spacing: 20,
              children: [
                ...FinancialDependency.values.map(
                  (dependency) => _DependencyOption(
                    dependency: dependency,
                    isSelected:
                        controller.financialDependency.value == dependency,
                    onTap: () {
                      controller.setFinancialDependency(dependency);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}

class _DependencyOption extends StatelessWidget {
  const _DependencyOption({
    required this.dependency,
    required this.isSelected,
    required this.onTap,
  });

  final FinancialDependency dependency;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AdaptivePressable(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: context.colors.bgLight,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? context.colors.appText
                : context.colors.appBorder,
          ),
          boxShadow: AppShadows.card(Colors.black),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(dependency.title, style: AppTextStyle.titleL),
            SizedBox(height: 4),
            Text(
              dependency.description,
              style: AppTextStyle.bodyL.copyWith(
                color: context.colors.appTextMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum FinancialDependency {
  none(title: 'No one', description: "I don't financially support anyone."),

  incomeDependent(
    title: 'People depend on my income',
    description: 'Someone relies on my income for their living expenses.',
  ),

  sharedExpenses(
    title: 'I share essential expenses',
    description:
        'I share household expenses with someone who relies partly on my income.',
  ),

  both(
    title: 'Both',
    description:
        'I financially support someone and share essential expenses with them.',
  );

  final String title;
  final String description;

  const FinancialDependency({required this.title, required this.description});
}
