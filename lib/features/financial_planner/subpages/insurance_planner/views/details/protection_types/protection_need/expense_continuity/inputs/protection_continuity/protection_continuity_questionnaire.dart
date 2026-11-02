import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_gradient_card.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/protection_questionnaire/controller/protection_questionnaire_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/models/continuity_models/expense_continuity_result.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/forms/add_policy/show_add_policy_form.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/extensions/insurance_questtionaire_completion_extension.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/old/controller/insurance_planner_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/protection_need/protection_need_type.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/protection_needs/expense_continuity/expense_continuity_budget_card.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/views/details/protection_types/protection_types.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';

class ProtectionContinuityQuestionnaire
    extends GetView<ProtectionQuestionnaireController> {
  const ProtectionContinuityQuestionnaire({super.key, this.type});
  final ProtectionType? type;

  @override
  Widget build(BuildContext context) {
    // Keep the controller instance used to build this route for callbacks.
    // The horizon route is popped immediately before this route is pushed.
    final questionnaireController = controller;
    final colorScheme = context.colors;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            type == null
                ? 'Expense Continuity Plan'
                : '${type!.continuityFundTitle.capitalize}',
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
                      type?.continuityFundExplainerText ??
                          'Choose how much of each budget would continue under death, critical illness, and disability scenarios.',
                      style: AppTextStyle.bodyL.copyWith(
                        color: colorScheme.appInversedtext,
                      ),
                    ),
                  ),
                  Text(
                    type?.continuityFundQuestion ??
                        'How much of each expense should be covered for each scenario?',
                    style: AppTextStyle.headlineM,
                  ),
                  Text(
                    type?.continuityFundQuestionHelper ??
                        'Set all three protection shares together for every budget category.',
                    style: AppTextStyle.bodyL,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            AppSection(
              child: StreamBuilder<List<SavedCashflowPlanData>>(
                stream: questionnaireController.cashflowController
                    .watchSavedBudgetPlans(),
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
                    controller: questionnaireController,
                  );
                },
              ),
            ),
            if (type == null) ...[
              const SizedBox(height: 12),
              AppSection(
                child: Obx(
                  () => AppButton(
                    text:
                        questionnaireController
                            .isComputingAllExpenseContinuity
                            .value
                        ? 'Computing lifestyle needs...'
                        : 'Save answers and compute needs',
                    onTap:
                        questionnaireController
                            .isComputingAllExpenseContinuity
                            .value
                        ? null
                        : () async {
                            final navigator = Navigator.of(context);
                            final saved = await questionnaireController
                                .saveContinuityShares();
                            if (!saved) return;

                            final computed = await questionnaireController
                                .computeAllExpenseContinuity();
                            if (!computed || !context.mounted) return;

                            final reviewed = await Get.to<bool>(
                              () => _ContinuityNeedsSummaryPage(
                                results: Map.of(
                                  questionnaireController
                                      .expenseContinuityResults,
                                ),
                              ),
                            );
                            if (reviewed != true || !navigator.mounted) return;

                            final policiesStepCompleted = await Get.to<bool>(
                              () => const _InsurancePoliciesOnboardingPage(),
                            );
                            if (policiesStepCompleted == true &&
                                navigator.mounted) {
                              await Get.find<InsurancePlannerController>()
                                  .finishInsuranceQuestionnaireOnboarding();
                              if (navigator.mounted) navigator.pop(true);
                            }
                          },
                  ),
                ),
              ),
            ],
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
  final ProtectionType? type;
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
    if (widget.type == null) {
      return _AllProtectionTypesPlansList(
        plans: widget.plans,
        controller: widget.controller,
      );
    }

    return Obx(
      () => Column(
        spacing: 20,
        children: [
          for (final plan in widget.plans)
            ExpenseContinuityBudgetCard(
              key: ValueKey(plan.planId),
              plan: plan,
              type: widget.type!,
              continuityShare: widget.controller.getContinuityShare(
                plan.planId,
                widget.type!,
              ),
              onShareChanged: (share) {
                widget.controller.updateContinuityShare(
                  planId: plan.planId,
                  protectionType: widget.type!,
                  share: share,
                );
              },
            ),
        ],
      ),
    );
  }
}

class _AllProtectionTypesPlansList extends StatefulWidget {
  const _AllProtectionTypesPlansList({
    required this.plans,
    required this.controller,
  });

  final List<SavedCashflowPlanData> plans;
  final ProtectionQuestionnaireController controller;

  @override
  State<_AllProtectionTypesPlansList> createState() =>
      _AllProtectionTypesPlansListState();
}

class _AllProtectionTypesPlansListState
    extends State<_AllProtectionTypesPlansList> {
  @override
  void initState() {
    super.initState();
    _loadShares();
  }

  @override
  void didUpdateWidget(covariant _AllProtectionTypesPlansList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.plans.map((plan) => plan.planId).join(',') !=
        widget.plans.map((plan) => plan.planId).join(',')) {
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
        spacing: 16,
        children: widget.plans.map((plan) {
          final annualAmount = plan.budgetPeriod.toAnnual(plan.amount);
          final shares = {
            for (final type in ProtectionType.values)
              type: widget.controller.getContinuityShare(plan.planId, type),
          };

          return AppCard(
            onTap: () async {
              final updatedShares =
                  await Get.bottomSheet<Map<ProtectionType, double>>(
                    _AllProtectionTypesContinuitySheet(
                      plan: plan,
                      initialShares: shares,
                    ),
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                  );

              if (updatedShares == null) return;
              for (final entry in updatedShares.entries) {
                widget.controller.setContinuityShare(
                  planId: plan.planId,
                  protectionType: entry.key,
                  share: entry.value,
                );
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(plan.category, style: AppTextStyle.titleL),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      annualAmount.toCurrency(),
                      style: AppTextStyle.amountM,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  'Annual budget · Tap to adjust',
                  style: AppTextStyle.bodyS.copyWith(
                    color: context.colors.appTextMuted,
                  ),
                ),
                const SizedBox(height: 16),
                for (final type in ProtectionType.values) ...[
                  _ScenarioAmountRow(
                    type: type,
                    share: shares[type] ?? 0,
                    amount: annualAmount * (shares[type] ?? 0),
                  ),
                  if (type != ProtectionType.values.last)
                    const SizedBox(height: 10),
                ],
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _AllProtectionTypesContinuitySheet extends StatefulWidget {
  const _AllProtectionTypesContinuitySheet({
    required this.plan,
    required this.initialShares,
  });

  final SavedCashflowPlanData plan;
  final Map<ProtectionType, double> initialShares;

  @override
  State<_AllProtectionTypesContinuitySheet> createState() =>
      _AllProtectionTypesContinuitySheetState();
}

class _AllProtectionTypesContinuitySheetState
    extends State<_AllProtectionTypesContinuitySheet> {
  late final Map<ProtectionType, double> _shares = {
    for (final type in ProtectionType.values)
      type: (widget.initialShares[type] ?? 0).clamp(0.0, 1.0),
  };

  @override
  Widget build(BuildContext context) {
    final annualAmount = widget.plan.budgetPeriod.toAnnual(widget.plan.amount);

    return AppSheet(
      title: '${widget.plan.category} Continuity',
      height: AppSheetHeight.full,
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
              child: AppSection(
                child: Column(
                  spacing: 20,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Annual budget: ${annualAmount.toCurrency()}',
                      style: AppTextStyle.titleL,
                    ),
                    for (final type in ProtectionType.values)
                      _ContinuityShareSlider(
                        type: type,
                        share: _shares[type]!,
                        annualAmount: annualAmount,
                        onChanged: (value) {
                          setState(() => _shares[type] = value);
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
          AppSection(
            child: AppButton(
              text: 'Save changes',
              onTap: () => Get.back<Map<ProtectionType, double>>(
                result: Map.of(_shares),
              ),
            ),
          ),
          SizedBox(height: context.bottomPaddingSub),
        ],
      ),
    );
  }
}

class _ContinuityShareSlider extends StatelessWidget {
  const _ContinuityShareSlider({
    required this.type,
    required this.share,
    required this.annualAmount,
    required this.onChanged,
  });

  final ProtectionType type;
  final double share;
  final double annualAmount;
  final ValueChanged<double> onChanged;

  @override
  Widget build(BuildContext context) {
    final continuedAmount = annualAmount * share;
    final colors = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(type.label, style: AppTextStyle.titleL)),
            Text('${(share * 100).round()}%', style: AppTextStyle.amountM),
          ],
        ),
        Text(
          '${continuedAmount.toCurrency()} / year',
          style: AppTextStyle.bodyM.copyWith(color: colors.appTextMuted),
        ),
        Slider(
          value: share.clamp(0.0, 1.0),
          min: 0,
          max: 1,
          divisions: 20,
          activeColor: type.color,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class _ScenarioAmountRow extends StatelessWidget {
  const _ScenarioAmountRow({
    required this.type,
    required this.share,
    required this.amount,
  });

  final ProtectionType type;
  final double share;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(color: type.color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            '${type.label} · ${(share * 100).round()}%',
            style: AppTextStyle.bodyM,
          ),
        ),
        Text('${amount.toCurrency()}/yr', style: AppTextStyle.amountM),
      ],
    );
  }
}

class _ContinuityNeedsSummaryPage extends StatelessWidget {
  const _ContinuityNeedsSummaryPage({required this.results});

  final Map<ProtectionType, ExpenseContinuityResult> results;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: Text(
          'Lifestyle continuity needs',
          style: AppTextStyle.headlineL,
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
              children: [
                AppSection(
                  child: AppGradientCard(
                    child: Text(
                      'Your estimated continuity funds are ready. Review the amount needed for each protection scenario.',
                      style: AppTextStyle.bodyL.copyWith(
                        color: colors.appInversedtext,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                for (final type in ProtectionType.values)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: AppSection(
                      child: AppCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(type.label, style: AppTextStyle.titleL),
                            const SizedBox(height: 12),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Invested fund needed',
                                        style: AppTextStyle.bodyM.copyWith(
                                          color: colors.appTextMuted,
                                        ),
                                      ),
                                      Text(
                                        'Uninvested total',
                                        style: AppTextStyle.bodyM.copyWith(
                                          color: colors.appTextMuted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      results[type]!.investedNeed.toCurrency(),
                                      style: AppTextStyle.amountL,
                                    ),
                                    Text(
                                      results[type]!.uninvestedNeed
                                          .toCurrency(),
                                      style: AppTextStyle.amountM,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          AppSection(
            child: AppButton(
              text: 'Continue to insurance policies',
              onTap: () => Get.back<bool>(result: true),
            ),
          ),
          SizedBox(height: context.bottomPaddingSub),
        ],
      ),
    );
  }
}

class _InsurancePoliciesOnboardingPage extends StatefulWidget {
  const _InsurancePoliciesOnboardingPage();

  @override
  State<_InsurancePoliciesOnboardingPage> createState() =>
      _InsurancePoliciesOnboardingPageState();
}

class _InsurancePoliciesOnboardingPageState
    extends State<_InsurancePoliciesOnboardingPage> {
  bool _isLoading = true;
  bool _hasPolicies = false;

  @override
  void initState() {
    super.initState();
    _refreshPolicyStatus();
  }

  Future<void> _refreshPolicyStatus() async {
    final hasPolicies = await database.userInsurancePolicyDao
        .hasInsurancePolicies();
    if (!mounted) return;

    setState(() {
      _hasPolicies = hasPolicies;
      _isLoading = false;
    });
  }

  Future<void> _addPolicy() async {
    await showAddPolicyForm<void>();
    await _refreshPolicyStatus();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final title = _hasPolicies
        ? 'Add another insurance policy?'
        : 'Add your first insurance policy';
    final description = _hasPolicies
        ? 'Add any other policies you have, or skip to finish setting up your insurance planner.'
        : 'Add a policy to include its coverage in your insurance plan. You can also skip this step and add one later.';

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        title: Text('Insurance policies', style: AppTextStyle.headlineL),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(bottom: context.bottomPaddingSub),
              children: [
                AppSection(
                  child: AppGradientCard(
                    child: Text(
                      'Your lifestyle continuity needs are calculated. Next, add the insurance policies you already have.',
                      style: AppTextStyle.bodyL.copyWith(
                        color: colors.appInversedtext,
                      ),
                    ),
                  ),
                ),
                AppSection(
                  child: AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: AppTextStyle.headlineM),
                        const SizedBox(height: 10),
                        Text(description, style: AppTextStyle.bodyM),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          AppSection(
            child: Column(
              spacing: 10,
              children: [
                AppButton(
                  text: _isLoading
                      ? 'Checking saved policies...'
                      : _hasPolicies
                      ? 'Add another policy'
                      : 'Add insurance policy',
                  onTap: _isLoading ? null : _addPolicy,
                ),
                AppButton(
                  text: 'Skip and finish setup',
                  type: ButtonType.outline,
                  onTap: () => Get.back<bool>(result: true),
                ),
              ],
            ),
          ),
          SizedBox(height: context.bottomPaddingSub),
        ],
      ),
    );
  }
}
