import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/domain/app_calculator.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/emergency_fund_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/emergency_fund_priority_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/emergency_fund_goal/fund_milestone/fund_milestone_page.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/savings_investment_planner/goals/model/goal_type.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class EmergencyFundAllocationPage extends GetView<GoalReservationController> {
  const EmergencyFundAllocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Scaffold(
      appBar: AppBar(
        title: Text('Build Your Emergency Fund', style: AppTextStyle.headlineL),
        surfaceTintColor: Colors.transparent,
      ),
      body: SafeArea(
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
                          Text(
                            'Set aside amount from your accounts',
                            style: AppTextStyle.titleL,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'Select which payment accounts to use for your emergency fund '
                            'and how much is set aside.',
                            style: AppTextStyle.bodyM,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'You can adjust this anytime.',
                            style: AppTextStyle.bodyM.copyWith(
                              color: colorScheme.appTextMuted,
                            ),
                          ),
                          SizedBox(height: 16),
                          Obx(
                            () => Column(
                              spacing: 12,
                              children: controller.accounts.map((account) {
                                final allocatedAmount =
                                    controller.allocatedAmounts[account.id] ??
                                    0;

                                final allocableAmount =
                                    controller.allocableAmounts[account.id] ??
                                    0;

                                return AllocateFundAccountCard(
                                  accountName: account.name,
                                  allocatedAmount: allocatedAmount,
                                  allocableAmount: allocableAmount,
                                  onTap: () async {
                                    final calculatorController =
                                        Get.find<AppCalculatorController>();

                                    calculatorController.initialize(
                                      allocatedAmount,
                                    );

                                    final result =
                                        await Get.bottomSheet<double>(
                                          const AppCalculator(
                                            title:
                                                'Allocation for Emergency Fund',
                                          ),
                                          isScrollControlled: true,
                                        );

                                    if (result == null) return;

                                    controller.updateAllocation(
                                      account.id,
                                      result,
                                    );
                                  },
                                );
                              }).toList(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            Obx(() {
              // final accountCount = controller.allocatedAmounts.values
              //     .where((amount) => amount > 0)
              //     .length;

              return AppSection(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(color: colorScheme.appBorder),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Total amount set aside',
                        style: AppTextStyle.titleM,
                      ),
                      Text(
                        controller.totalAllocated.toCurrency(),
                        style: AppTextStyle.amountXL,
                      ),
                      // Text(
                      //   'from $accountCount ${accountCount == 1 ? 'account' : 'accounts'}',
                      //   style: AppTextStyle.labelM.copyWith(
                      //     color: colorScheme.appTextMuted,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            }),

            Obx(() {
              final allocation = controller.totalAllocated;

              if (allocation > 0) {
                return Column(
                  children: [
                    const SizedBox(height: 16),
                    AppSection(
                      child: AppButton(
                        onTap: () {
                          Get.to(
                            () => EmergencyFundMilestonePage(
                              amountSetAside: allocation,
                            ),
                            binding: BindingsBuilder(() {
                              Get.put(EmergencyFundController());
                            }),
                          );
                        },
                        text:
                            'Set aside ${controller.totalAllocated.toCompactCurrency()}',
                      ),
                    ),
                  ],
                );
              }

              return SizedBox.shrink();
            }),
          ],
        ),
      ),
    );
  }
}

class AllocateFundAccountCard extends StatelessWidget {
  const AllocateFundAccountCard({
    super.key,
    required this.accountName,
    required this.allocatedAmount,
    required this.allocableAmount,
    this.onTap,
  });

  final String accountName;
  final double allocatedAmount;
  final double allocableAmount;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(accountName, style: AppTextStyle.titleL),
          const SizedBox(height: 8),

          Row(
            children: [
              Text(allocatedAmount.toCurrency(), style: AppTextStyle.amountL),
              Text(' / ', style: AppTextStyle.amountS),
              Text(allocableAmount.toCurrency(), style: AppTextStyle.amountS),
            ],
          ),

          Text(
            'Allocated / Allocable',
            style: AppTextStyle.labelS.copyWith(
              color: colorScheme.appTextMuted,
            ),
          ),
        ],
      ),
    );
  }
}

class GoalReservationController extends GetxController {
  final accounts = <AccountsTableData>[].obs;

  final allocatedAmounts = <int, double>{}.obs;
  final allocableAmounts = <int, double>{}.obs;

  int? emergencyFundGoalId;
  void updateAllocation(int accountId, double amount) {
    final allocableAmount = allocableAmounts[accountId] ?? 0;

    if (amount < 0) return;

    if (amount > allocableAmount) {
      Get.snackbar(
        'You can allocate up to ${allocableAmount.toCurrency()}.',
        '${amount.toCurrency()} is higher than the allocable amount.',
      );
      return;
    }

    allocatedAmounts[accountId] = amount;
    allocatedAmounts.refresh();
  }

  double get totalAllocated {
    return allocatedAmounts.values.fold(0.0, (sum, amount) => sum + amount);
  }

  @override
  void onInit() {
    super.onInit();

    _initialize();
  }

  Future<void> _initialize() async {
    await _loadEmergencyFundGoal();

    _watchAccounts();
  }

  Future<void> _loadEmergencyFundGoal() async {
    final goal = await database.goalsDao.getGoalByType(GoalType.emergencyFund);

    emergencyFundGoalId = goal?.id;
  }

  Future<void> _loadAllocations(List<AccountsTableData> items) async {
    final goalId = emergencyFundGoalId;

    for (final account in items) {
      final reservations = await database.goalReservationsDao
          .getReservationsForAccount(account.id);

      double allocated = 0;
      double reservedForOtherGoals = 0;

      for (final reservation in reservations) {
        if (goalId != null && reservation.goalId == goalId) {
          allocated += reservation.amount;
        } else {
          reservedForOtherGoals += reservation.amount;
        }
      }

      allocatedAmounts[account.id] = allocated;

      allocableAmounts[account.id] =
          (account.currentValue - reservedForOtherGoals).clamp(
            0.0,
            double.infinity,
          );
    }

    allocatedAmounts.refresh();
    allocableAmounts.refresh();
  }

  void _watchAccounts() {
    database.accountsDao.watchCashAndBankAccounts().listen((items) async {
      await _loadAllocations(items);

      final allocableAccounts = items
          .where((account) => (allocableAmounts[account.id] ?? 0) > 0)
          .toList();

      accounts.assignAll(allocableAccounts);
    });
  }
}
