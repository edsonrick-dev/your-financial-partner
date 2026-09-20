import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/subpages/questionnaires/protection_horizon/widgets/survivor_budget_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class SurvivorBudgetQuestion extends GetView<InsurancePlannerController> {
  const SurvivorBudgetQuestion({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Column(
      children: [
        AppSection(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Survivor's Budget",
                style: AppTextStyle.headlineL.copyWith(
                  color: colorScheme.appAccent,
                ),
              ),
              SizedBox(height: 16),
              Container(
                constraints: BoxConstraints(minHeight: 52),
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: colorScheme.appText,
                ),
                child: Text(
                  "Not all expenses would continue after your death. Choose how much of each expense your family would still need.",
                  style: AppTextStyle.bodyL.copyWith(
                    color: colorScheme.appInversedtext,
                  ),
                ),
              ),
              SizedBox(height: 16),
              Text(
                "Which of your current expenses would still need to be covered if you were no longer here?",
                style: AppTextStyle.headlineM,
              ),
              SizedBox(height: 16),
              Text(
                "Tap each card to adjust the survivor share.",
                style: AppTextStyle.bodyL,
              ),
            ],
          ),
        ),
        SizedBox(height: 16),
        AppSection(
          child: StreamBuilder<List<SavedCashflowPlanData>>(
            stream: controller.cashflowController.watchSavedBudgetPlans(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text(
                  'Error: ${snapshot.error}',
                  style: AppTextStyle.bodyM,
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              final plans = snapshot.data ?? [];

              if (plans.isEmpty) {
                return const Text('No survivor budget plans found.');
              }

              return Obx(
                () => Column(
                  children: [
                    for (final plan in plans)
                      SurvivorBudgetCard(
                        plan: plan,
                        survivorShare: controller.getSurvivorShare(plan.planId),
                        onShareChanged: (share) {
                          controller.setSurvivorShare(plan.planId, share);
                        },
                      ),
                  ],
                ),
              );
            },
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}

class SurvivorBudgetSelection {
  final int planId;
  final double survivorShare;

  const SurvivorBudgetSelection({
    required this.planId,
    required this.survivorShare,
  });
}
