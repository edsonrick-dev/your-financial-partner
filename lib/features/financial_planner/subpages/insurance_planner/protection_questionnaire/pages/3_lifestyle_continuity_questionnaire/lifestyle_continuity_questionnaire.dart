import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_gradient_card.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/3_lifestyle_continuity_questionnaire/widgets/lifestyle_continuity_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/controller/protection_questionnaire_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class LifestyleContinuityQuestionnaire
    extends GetView<ProtectionQuestionnaireController> {
  const LifestyleContinuityQuestionnaire({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Lifestyle Continuity Questionnaire',
            style: AppTextStyle.headlineL,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    AppSection(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppGradientCard(
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
                        stream: controller.cashflowController
                            .watchSavedBudgetPlans(),
                        builder: (context, snapshot) {
                          if (snapshot.hasError) {
                            return Text(
                              'Error: ${snapshot.error}',
                              style: AppTextStyle.bodyM,
                            );
                          }

                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          final plans = snapshot.data ?? [];

                          if (plans.isEmpty) {
                            return const Text(
                              'No survivor budget plans found.',
                            );
                          }
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            controller.loadContinuitySharesForPlans(
                              plans.map((plan) => plan.planId),
                            );
                          });
                          return Obx(
                            () => Column(
                              spacing: 20,
                              children: [
                                for (final plan in plans)
                                  LifestyleContinuityCard(
                                    key: ValueKey(plan.planId),
                                    plan: plan,
                                    continuityShares: {
                                      for (final type in ProtectionType.values)
                                        type: controller.getContinuityShare(
                                          plan.planId,
                                          type,
                                        ),
                                    },
                                    onSharesChanged: (shares) {
                                      for (final entry in shares.entries) {
                                        controller.setContinuityShare(
                                          planId: plan.planId,
                                          protectionType: entry.key,
                                          share: entry.value,
                                        );
                                      }
                                    },
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 8),
            AppSection(
              child: Obx(
                () => AppButton(
                  text: controller.isSavingContinuityShares.value
                      ? 'Saving...'
                      : 'Save these survivor shares',
                  onTap: controller.isSavingContinuityShares.value
                      ? null
                      : () async {
                          final saved = await controller.saveContinuityShares();

                          if (saved && context.mounted) {
                            Navigator.of(context).pop(true);
                          }
                        },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
