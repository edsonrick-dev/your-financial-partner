import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/app_gradient_card.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/controller/protection_questionnaire_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/benefits/expense_continuity/expense_continuity_budget_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class ExpenseContinuityQuestionnaire
    extends GetView<ProtectionQuestionnaireController> {
  const ExpenseContinuityQuestionnaire({super.key, required this.type});
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
          child: Text('Expense Continuity Plan', style: AppTextStyle.headlineL),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
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
                    "Tap each card to adjust your dependents' share.",
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
                  // WidgetsBinding.instance.addPostFrameCallback((_) {
                  //   controller.loadContinuitySharesForPlans(
                  //     plans.map((plan) => plan.planId),
                  //   );
                  // });
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
    await widget.controller.loadContinuitySharesForPlans(
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
