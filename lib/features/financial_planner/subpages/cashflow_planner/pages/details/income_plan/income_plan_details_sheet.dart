import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/app/routes/app_sheets/app_sheets.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/data/database/daos/cashflow_plan_dao/cashflow_plan_dao.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/budget_period_enum.dart';
import 'package:getx_drift_app/domain/enums/cashflow_planner_enums/cashflow_distribution.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/controller/cashflow_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/models/saved_cashflow_plan_data.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/details/budget_plan/budget/cashflow_plan_summary_section.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/details/budget_plan/budget/cashflow_plan_transactions_view.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/sheets/create_cashflow_plan/create_income_plan_sheet.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/utils/cashflow_allocation_label.dart';
import 'package:getx_drift_app/features/transactions/controllers/transaction_controller.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/earn_transaction/earn_transaction_sheet.dart';
import 'package:getx_drift_app/features/transactions/transaction_types/transaction_type.dart';
import 'package:getx_drift_app/features/transactions/transaction_with_details.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section_body.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class IncomePlanDetailsSheet extends StatelessWidget {
  const IncomePlanDetailsSheet({
    super.key,
    required this.plan,
    required this.selectedIndex,
  });

  final SavedCashflowPlanData plan;
  final RxInt selectedIndex;

  Future<void> _onTap(BuildContext context) async {
    if (selectedIndex.value == 0) {
      _addTransaction();
      return;
    }

    final savedPlan = await _loadPlan();

    if (savedPlan == null) {
      return;
    }

    await _editIncomePlan(savedPlan);
  }

  void _addTransaction() {
    AppSheets.transaction.earn(categoryId: plan.categoryId);
  }

  Future<CashflowPlanWithCategory?> _loadPlan() async {
    final plans = await database.cashflowPlanDao
        .watchAllPlansWithDetails()
        .first;

    return plans.firstWhereOrNull((item) => item.plan.id == plan.planId);
  }

  Future<void> _editIncomePlan(CashflowPlanWithCategory savedPlan) async {
    final controller = Get.find<CashflowController>();

    await controller.loadCashflowPlanForEdit(savedPlan);

    Get.bottomSheet(
      const CreateIncomePlanSheet(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      height: AppSheetHeight.full,
      title: '${plan.category} Plan',
      child: StreamBuilder<List<TransactionWithDetails>>(
        stream: database.transactionsDao.watchTransactionsForCashflowPlan(plan),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Unable to load transactions.'));
          }

          final transactions = snapshot.data ?? [];

          final now = DateTime.now();

          final monthStart = DateTime(now.year, now.month, 1);

          final nextMonth = DateTime(now.year, now.month + 1, 1);

          final transactedAmount = transactions
              .where(
                (item) =>
                    !item.transaction.date.isBefore(monthStart) &&
                    item.transaction.date.isBefore(nextMonth),
              )
              .fold<double>(
                0,
                (total, item) => total + item.transaction.amount,
              );

          return Column(
            children: [
              CashflowPlanSummarySection(
                transactionType: TransactionType.earn,
                plan: plan,
                transactionAmount: transactedAmount,
                planned: plan.amount,
              ),

              const SizedBox(height: 12),

              Obx(
                () => AppDetailsPageActionSection(
                  selectedIndex: selectedIndex,
                  actions: const ['Transactions', 'Plan Details'],
                  icon: selectedIndex.value == 1
                      ? PhosphorIconsRegular.pencil
                      : PhosphorIconsRegular.plus,
                  onAdd: () {
                    _onTap(context);
                  },
                ),
              ),

              Expanded(
                child: Obx(
                  () => IndexedStack(
                    index: selectedIndex.value,
                    children: [
                      CashflowPlanTransactionsView(plan: plan),

                      _IncomePlanDetails(plan: plan),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _IncomePlanDetails extends StatelessWidget {
  const _IncomePlanDetails({required this.plan});

  final SavedCashflowPlanData plan;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<CashflowPlanWithCategory>>(
      stream: database.cashflowPlanDao.watchAllPlansWithDetails(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Unable to load plan details.'));
        }

        final plans = snapshot.data ?? [];

        final savedPlan = plans.firstWhereOrNull(
          (item) => item.plan.id == plan.planId,
        );

        if (savedPlan == null) {
          return const Center(child: Text('Plan not found.'));
        }

        return PlanDetailsContent(savedPlan: savedPlan);
      },
    );
  }
}

class PlanDetailsContent extends StatelessWidget {
  const PlanDetailsContent({super.key, required this.savedPlan});

  final CashflowPlanWithCategory savedPlan;

  @override
  Widget build(BuildContext context) {
    final plan = savedPlan.plan;

    final distributionType = CashFlowDistribution.values.firstWhere(
      (distribution) => distribution.name == plan.distributionType,
    );

    final isCustom = distributionType == CashFlowDistribution.custom;
    final period = BudgetPeriod.values.firstWhere(
      (item) => item.name == plan.period,
    );
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // _PlanDetailSection(
          //   title: 'Plan',
          //   children: [
          //     _PlanDetailRow(
          //       label: 'Income Source',
          //       value: savedPlan.category.name,
          //     ),
          // _PlanDetailRow(
          //   label: 'Plan Period',
          //   value: _formatPeriod(plan.period),
          // ),
          // _PlanDetailRow(
          //   label: 'Distribution',
          //   value: isCustom ? 'Custom Distribution' : 'Even Distribution',
          // ),
          //   ],
          // ),
          AppSection(
            // sectionTitle: 'Amount',
            // trailingWidget: AdaptivePressable(child: Text('Edit amount')),
            // trailingType: SectionTrailingType.custom,
            child: Column(
              children: [
                AppSectionBody(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Text('Amount Set'),
                        if (!isCustom) ...[
                          _PlanDetailRow(
                            label: '${_formatPeriod(plan.period)} Amount',
                            isValueCurrency: true,
                            value: plan.amount.toCurrency(),
                          ),
                        ] else if (isCustom &&
                            savedPlan.allocations.isNotEmpty) ...[
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  _formatPeriod(plan.period),
                                  style: AppTextStyle.titleL,
                                ),
                              ),
                              Text(
                                isCustom
                                    ? 'Custom Distribution'
                                    : '${_formatPeriod(plan.period)} Distribution',
                              ),
                            ],
                          ),
                          ...savedPlan.allocations.map(
                            (allocation) => _PlanDetailRow(
                              label: cashflowAllocationLabel(
                                period: period,
                                index: allocation.allocationIndex,
                              ),
                              isValueCurrency: true,
                              value: allocation.amount.toCurrency(),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          AppSection(
            child: AppSectionBody(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    _PlanDetailRow(
                      label: 'Plan Created',
                      value: _formatDate(plan.startDate),
                    ),
                    _PlanDetailRow(
                      label: 'Last Modified',
                      value: _formatDate(plan.updatedAt),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: context.bottomPaddingSub),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.month}/${date.day}/${date.year}';
  }

  String _formatPeriod(String period) {
    return period[0].toUpperCase() + period.substring(1);
  }
}

class _PlanDetailRow extends StatelessWidget {
  const _PlanDetailRow({
    required this.label,
    required this.value,
    this.isValueCurrency = false,
  });

  final String label;
  final String value;
  final bool isValueCurrency;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: Text(label, style: AppTextStyle.bodyL)),

          const SizedBox(width: 16),

          Text(
            value,
            textAlign: TextAlign.end,
            style: isValueCurrency ? AppTextStyle.amountL : AppTextStyle.titleL,
          ),
        ],
      ),
    );
  }
}
