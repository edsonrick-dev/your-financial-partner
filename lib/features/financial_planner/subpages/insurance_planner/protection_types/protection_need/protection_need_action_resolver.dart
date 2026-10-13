import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_gradient_card.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/protection_horizon.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/controller/protection_questionnaire_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/pages/1_protection_horizon_questionnaire/protection_horizon_questionnaire_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/benefits/expense_continuity/expense_continuity_budget_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/benefits/expense_continuity/expense_continuity_fund_details.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/benefits/expense_continuity/expense_continuity_questionnaire.dart';

import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_need/protection_need_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/home/bindings/protection_questionnaire_binding.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class ProtectionNeedActionResolver {
  ProtectionNeedActionResolver._();

  static VoidCallback? resolve({
    required ProtectionType type,
    required ProtectionNeedType needType,
    required InsurancePlannerController controller,
  }) {
    switch ((type, needType)) {
      case (
        ProtectionType.death ||
            ProtectionType.criticalIllness ||
            ProtectionType.disability,
        ProtectionNeedType.expenseContinuity,
      ):
        return () => _openExpenseContinuitySheet(type: type);
      default:
        return null;
    }
  }

  static Future<void> _openExpenseContinuitySheet({
    required ProtectionType type,
  }) async {
    final binding = ProtectionQuestionnaireBinding();
    binding.dependencies();
    Get.bottomSheet(
      AppSheet(
        title: '${type.label} Expense Continuity Fund',
        height: AppSheetHeight.full,
        child: ExpenseContinuityPage(type: type),
      ),
      isScrollControlled: true,
    );
  }

  // static Future<void> _openExpenseContinuitySheet({
  //   required ProtectionType type,
  //   required InsurancePlannerController controller,
  // }) async {
  //   final scenarios = await database.protectionDao.getProtectionScenarios();

  //   final scenario = scenarios.firstWhereOrNull(
  //     (scenario) => scenario.protectionType == type.name,
  //   );

  //   final details = switch (type) {
  //     ProtectionType.death =>
  //       controller.deathBenefitResult.value?.expenseContinuityDetails,
  //     ProtectionType.criticalIllness =>
  //       controller.criticalIllnessBenefitResult.value?.expenseContinuityDetails,
  //     ProtectionType.disability =>
  //       controller.disabilityBenefitResult.value?.expenseContinuityDetails,
  //   };
  //   final binding = ProtectionQuestionnaireBinding();
  //   binding.dependencies();
  //   Get.bottomSheet(
  //     AppSheet(
  //       title: 'Expense Continuity Fund',
  //       height: AppSheetHeight.full,
  //       child: ExpenseContinuityPage(type: type),
  //     ),
  //     // ExpenseContinuityFundDetailsSheet(
  //     //   type: type,
  //     //   data: details,
  //     //   savedHorizon: scenario?.horizon,
  //     // ),
  //     isScrollControlled: true,
  //   );
  // }
}

class ExpenseContinuityPage extends StatelessWidget {
  const ExpenseContinuityPage({super.key, required this.type});
  final ProtectionType type;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: database.protectionDao.getActiveProtectionPlan(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Failed to load protection plan.'));
        }

        final protectionPlan = snapshot.data;

        if (protectionPlan == null) {
          return const Center(child: Text('No protection plan found.'));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
          child: Column(
            children: [
              AppSection(
                sectionTitle: 'Fund Inputs',
                child: Column(
                  spacing: 20,
                  children: [
                    ProtectionHorizonCard(
                      type: type,
                      planEndDate: protectionPlan.endDate,
                    ),

                    ProtectionContinuityFundCard(type: type),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class ProtectionContinuityFundCard
    extends GetView<ProtectionQuestionnaireController> {
  const ProtectionContinuityFundCard({super.key, required this.type});
  final ProtectionType type;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return AppCard(
      onTap: () async {
        await Get.to(
          () => ProtectionExpenseContinuityQuestionnaire(type: type),
        );
      },
      padding: 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(type.continuityFundTitle, style: AppTextStyle.titleL),
          SizedBox(height: 8),
          Text(
            type.continuityFundDescription,
            style: AppTextStyle.labelM.copyWith(
              color: colorScheme.appTextMuted,
            ),
          ),

          SizedBox(height: 16),
          // Text(
          //   'Tap to configure the expenses used to calculate this fund.',
          //   style: AppTextStyle.bodyM.copyWith(color: colorScheme.appTextMuted),
          // ),
          Obx(() {
            final monthlyAmount =
                controller.continuityMonthlyTotals[type] ?? 0.0;

            final annualAmount = monthlyAmount * 12;

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Annual', style: AppTextStyle.titleL),
                      Text(
                        DateTime.now().year.toString(),
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
                      annualAmount.toCurrency(),
                      style: AppTextStyle.amountL,
                    ),
                    Text(
                      '${monthlyAmount.toCurrency()}/mo',
                      style: AppTextStyle.amountS.copyWith(
                        color: colorScheme.appTextMuted,
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class ProtectionExpenseContinuityQuestionnaire
    extends GetView<ProtectionQuestionnaireController> {
  const ProtectionExpenseContinuityQuestionnaire({
    super.key,
    required this.type,
  });
  final ProtectionType type;

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
            '${type.continuityFundTitle.capitalize}',
            style: AppTextStyle.headlineL,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
        child: Column(
          children: [
            AppSection(
              child: Column(
                spacing: 16,
                children: [
                  AppGradientCard(
                    child: Text(
                      type.continuityFundExplainerText,
                      style: AppTextStyle.bodyL.copyWith(
                        color: colorScheme.appInversedtext,
                      ),
                    ),
                  ),
                  Text(
                    type.continuityFundQuestion,
                    style: AppTextStyle.headlineM,
                  ),
                  Text(
                    type.continuityFundQuestionHelper,
                    style: AppTextStyle.bodyL,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
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

                  return _ContinuityPlansList(
                    plans: plans,
                    type: type,
                    controller: controller,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ContinuityPlansList extends StatefulWidget {
  const _ContinuityPlansList({
    required this.plans,
    required this.type,
    required this.controller,
  });

  final List<SavedCashflowPlanData> plans;
  final ProtectionType type;
  final ProtectionQuestionnaireController controller;

  @override
  State<_ContinuityPlansList> createState() => _ContinuityPlansListState();
}

class _ContinuityPlansListState extends State<_ContinuityPlansList> {
  @override
  void initState() {
    super.initState();
    _loadShares();
  }

  @override
  void didUpdateWidget(covariant _ContinuityPlansList oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.plans.map((p) => p.planId).join(',') !=
        widget.plans.map((p) => p.planId).join(',')) {
      _loadShares();
    }
  }

  Future<void> _loadShares() async {
    await widget.controller.loadContinuitySharesForPlans1(
      widget.plans.map((plan) => plan.planId),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Column(
        spacing: 20,
        children: [
          for (final plan in widget.plans)
            ExpenseContinuityBudgetCard(
              key: ValueKey(plan.planId),
              plan: plan,
              type: widget.type,
              continuityShare: widget.controller.getContinuityShare(
                plan.planId,
                widget.type,
              ),
              onShareChanged: (share) {
                widget.controller.updateContinuityShare(
                  planId: plan.planId,
                  protectionType: widget.type,
                  share: share,
                );
              },
            ),
        ],
      ),
    );
  }
}

class ProtectionHorizonCard extends GetView<ProtectionQuestionnaireController> {
  const ProtectionHorizonCard({
    super.key,
    required this.type,
    required this.planEndDate,
  });

  final ProtectionType type;
  final DateTime planEndDate;

  String _formatCoveredPeriod(ProtectionHorizon horizon) {
    final startYear = planEndDate.year;
    final years = horizon.years;

    if (years == null) {
      return '$startYear - Until retirement';
    }

    final endYear = startYear + years;

    return '$startYear - $endYear';
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Obx(() {
      final horizon = controller.getHorizonObservable(type).value;

      return AppCard(
        onTap: () {
          Get.to(
            () => ProtectionHorizonQuestionnaire(type: type),
            binding: ProtectionQuestionnaireBinding(),
          );
        },
        padding: 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text('Protection horizon', style: AppTextStyle.titleL),
                ),
                Text(horizon.horizonLabel, style: AppTextStyle.titleL),
              ],
            ),
            SizedBox(height: 8),
            Text(
              type.horizonExplainerText,
              style: AppTextStyle.labelM.copyWith(
                color: colorScheme.appTextMuted,
              ),
            ),
            if (horizon != ProtectionHorizon.zero) ...[
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: Text('Covered period:', style: AppTextStyle.bodyM),
                  ),
                  Text(
                    _formatCoveredPeriod(horizon),
                    style: AppTextStyle.amountM,
                  ),
                ],
              ),
            ],
          ],
        ),
      );
    });
  }
}
// class ProtectionHorizonCard extends GetView<ProtectionQuestionnaireController> {
//   const ProtectionHorizonCard({super.key, required this.type});

//   final ProtectionType type;

//   String _formatCoveredPeriod(ProtectionHorizon horizon) {
//     final now = DateTime.now();
//     final years = horizon.years;

//     if (years == null) {
//       return '${now.year} - Until retirement';
//     }

//     final endYear = now.year + years;

//     return '${now.year} - $endYear';
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Obx(() {
//       final horizon = controller.getHorizonObservable(type).value;

//       return AppCard(
//         onTap: () {
//           Get.to(
//             () => ProtectionHorizonQuestionnaire(type: type),
//             binding: ProtectionQuestionnaireBinding(),
//           );
//         },
//         padding: 16,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Row(
//               children: [
//                 Expanded(
//                   child: Text('Protection Horizon', style: AppTextStyle.titleL),
//                 ),
//                 Text(horizon.horizonLabel, style: AppTextStyle.titleL),
//               ],
//             ),
//             Text(type.horizonExplainerText, style: AppTextStyle.labelM),

//             if (horizon != ProtectionHorizon.zero) ...[
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   Expanded(
//                     child: Text('Covered period:', style: AppTextStyle.bodyM),
//                   ),
//                   Text(
//                     _formatCoveredPeriod(horizon),
//                     style: AppTextStyle.amountM,
//                   ),
//                 ],
//               ),
//             ],
//           ],
//         ),
//       );
//     });
//   }
// }
