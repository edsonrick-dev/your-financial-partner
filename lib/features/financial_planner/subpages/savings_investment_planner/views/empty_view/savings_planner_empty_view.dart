import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/routes/app_routes.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_insights/cashflow/models/cashflow_status.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/controller/savings_planner_controller.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class SavingsPlannerEmptyView extends GetView<SavingsPlannerController> {
  const SavingsPlannerEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return SingleChildScrollView(
      padding: EdgeInsets.only(
        top: context.topPadding,
        bottom: context.bottomPadding,
      ),
      child: AppSection(
        child: Column(
          children: [
            SizedBox(height: 48),
            Icon(
              PhosphorIconsRegular.chartLineUp,
              size: 64,
              color: colorScheme.appAccent,
            ),

            const SizedBox(height: 16),

            Text(
              "Ascend's Savings & Investments Planner",
              style: AppTextStyle.headlineL,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 8),

            Text(
              'Make your money work for your goals.',
              style: AppTextStyle.headlineS,
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: colorScheme.bgLight,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Complete your plan setup', style: AppTextStyle.titleM),

                  const SizedBox(height: 16),

                  _PlannerRequirement(
                    title: "Risk Tolerance Assessment",
                    description: 'Understand your investment risk profile.',
                    isComplete:
                        controller.isRiskToleranceAssessmentFinished.value,
                  ),

                  const SizedBox(height: 16),

                  Obx(
                    () => _PlannerRequirement(
                      title: 'Net Worth Plan',
                      description: 'Record what you own and what you owe.',
                      isComplete: controller.hasNetWorth,
                    ),
                  ),

                  const SizedBox(height: 16),

                  _PlannerRequirement(
                    title: 'Income Plan',
                    description: 'Plan how much money comes in.',
                    isComplete: controller.hasIncome,
                  ),

                  const SizedBox(height: 16),

                  _PlannerRequirement(
                    title: 'Expense Plan',
                    description: 'Plan where your money goes.',
                    isComplete: controller.hasBudget,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            AppButton(
              onTap: _handleAction,
              trailingIcon: PhosphorIconsRegular.arrowRight,
              text: _actionText,
            ),

            const SizedBox(height: 12),

            Text(
              'Your Savings & Investments Planner becomes available once everything is complete.',
              style: AppTextStyle.bodyS.copyWith(
                color: colorScheme.appTextMuted,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  String get _actionText {
    if (!controller.isRiskToleranceAssessmentFinished.value) {
      return "Take Ascend's Risk Tolerance Assessment";
    }

    if (!controller.hasNetWorth) {
      return 'Complete net worth plan';
    }

    if (!controller.hasIncome) {
      return 'Build income plan';
    }

    if (!controller.hasBudget) {
      return 'Build expense plan';
    }

    return 'Continue';
  }

  void _handleAction() {
    final cashflowController =
        controller.financialProfileController.cashflowController;

    if (!controller.isRiskToleranceAssessmentFinished.value) {
      Get.toNamed(Routes.RISKTOLERANCEASSESSMENT);
      return;
    }

    if (!controller.hasNetWorth) {
      Get.toNamed(Routes.NETWORTHDETAILS);
      return;
    }

    if (!controller.hasIncome) {
      cashflowController.seletectedDetailsTabIndex.value = 0;
      Get.toNamed(Routes.CASHFLOWDETAILS);
      return;
    }

    if (!controller.hasBudget) {
      cashflowController.seletectedDetailsTabIndex.value = 1;
      Get.toNamed(Routes.CASHFLOWDETAILS);
      return;
    }
  }
}

class _PlannerRequirement extends StatelessWidget {
  final String title;
  final String description;
  final bool isComplete;

  const _PlannerRequirement({
    required this.title,
    required this.description,
    required this.isComplete,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          isComplete
              ? PhosphorIconsFill.checkCircle
              : PhosphorIconsRegular.circle,
          size: 24,
          color: isComplete ? colorScheme.appInflow : colorScheme.appTextMuted,
        ),

        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyle.titleM),

              const SizedBox(height: 2),

              Text(
                description,
                style: AppTextStyle.bodyS.copyWith(color: colorScheme.appText),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
