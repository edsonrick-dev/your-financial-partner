import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/section_trailing_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/controller/savings_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/views/sheet/goal_setting_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/views/sections/investor_profile_section.dart';
import 'package:getx_drift_app/features/profile/widgets/requirement_row.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SavingsPlannerContentView extends GetView<SavingsPlannerController> {
  const SavingsPlannerContentView({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        spacing: 20,
        children: [
          InvestorProfileSection(),
          AppSection(
            sectionTitle: 'Goals',
            trailingWidget: AdaptivePressable(
              child: SizedBox(
                height: 44,
                width: 44,
                child: Icon(PhosphorIconsRegular.plus, size: 20),
              ),
            ),
            trailingType: SectionTrailingType.custom,
            child: AppSectionBody(
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  // spacing: 12,
                  children: [
                    if (controller.canSetUpGoals) ...[
                      _BuildFirstGoal(),
                    ] else ...[
                      _FinancialSetupIncomplete(),
                    ],
                  ],
                ),
              ),
            ),
          ),
          AppSection(
            sectionTitle: 'Financial Instruments',
            trailingWidget: AdaptivePressable(
              child: SizedBox(
                height: 44,
                width: 44,
                child: Icon(PhosphorIconsRegular.plus, size: 20),
              ),
            ),
            trailingType: SectionTrailingType.custom,
            child: AppSectionBody(child: Column()),
          ),
        ],
      ),
    );
  }
}

class _BuildFirstGoal extends StatelessWidget {
  const _BuildFirstGoal();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            PhosphorIconsRegular.target,
            size: 60,
            color: colorScheme.appAccent,
          ),

          const SizedBox(height: 8),

          Text(
            'You have no goals set yet',
            style: AppTextStyle.headlineM,
            textAlign: TextAlign.center,
          ),

          Text(
            'Give your money a purpose',
            style: AppTextStyle.headlineS,
            textAlign: TextAlign.center,
          ),

          Text(
            'Create goals to give your savings and investments a clear direction.',
            style: AppTextStyle.bodyM.copyWith(color: colorScheme.appTextMuted),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          AppButton(
            type: ButtonType.outline,
            text: 'Set Financial Goals',
            onTap: () {
              Get.bottomSheet(GoalSettingSheet(), isScrollControlled: true);
              // Open GoalSetupSheet
            },
          ),
        ],
      ),
    );
  }
}

class _FinancialSetupIncomplete extends GetView<SavingsPlannerController> {
  const _FinancialSetupIncomplete();

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            PhosphorIconsRegular.target,
            size: 60,
            color: colorScheme.appAccent,
          ),

          SizedBox(height: 8),

          Text(
            'Set your financial goals',
            style: AppTextStyle.headlineM,
            textAlign: TextAlign.center,
          ),

          Text(
            "Give your money a purpose",
            style: AppTextStyle.headlineS,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Text(
            "Before setting your financial goals, the following are required:",
            style: AppTextStyle.bodyM.copyWith(color: colorScheme.appTextMuted),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Obx(
            () => Column(
              children: [
                RequirementRow(
                  label: 'Net worth setup',
                  isComplete: controller.hasNetWorth,
                ),
                const SizedBox(height: 8),
                RequirementRow(
                  label: 'Income plan',
                  isComplete: controller.hasIncome,
                ),
                const SizedBox(height: 8),
                RequirementRow(
                  label: 'Budget plan',
                  isComplete: controller.hasBudget,
                ),
                const SizedBox(height: 8),
                RequirementRow(
                  label: 'Positive net cash flow',
                  isComplete: controller.hasPositiveNetCashflow,
                ),
              ],
            ),
          ),

          SizedBox(height: 16),

          AppButton(
            type: ButtonType.outline,
            text: controller.financialSetupCta,
            onTap: () {
              controller.goToFinancialSetup();
            },
          ),
        ],
      ),
    );
  }
}
