import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/app/globals/app_globals.dart';
import 'package:getx_drift_app/core/constants/icons/app_icons.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/extensions/build_context_extension.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/subpages/details_page/app_button.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/account_type_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/views/details_sheet/cash_and_bank_details_sheet/update_account_balance_sheet.dart';
import 'package:getx_drift_app/features/onboarding/onboarding_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/fields/dropdown_field.dart';
import 'package:getx_drift_app/features/widgets/fields/text_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';

class OnboaringAddIncomePlan extends GetView<OnboardingController> {
  const OnboaringAddIncomePlan({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    // final networthController = Get.find<NetWorthController>();
    // final accountCount = networthController.cashAndBankAccounts.length;

    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          AppSection(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: colorScheme.appAccent,
                    borderRadius: BorderRadius.circular(99),
                  ),
                  child: Text('Step 2 of 3', style: AppTextStyle.labelS),
                ),
                Text('How does money come in?', style: AppTextStyle.displayM),

                const SizedBox(height: 12),

                Text(
                  '''Tell us the income you expect to receive each month so Ascend can help you plan ahead.''',
                  style: AppTextStyle.bodyL,
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: colorScheme.appBorder),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 16,
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      child: Row(
                        children: [
                          const Expanded(child: Text('Add income plan')),
                        ],
                      ),
                    ),
                    AppSection(
                      child: Column(
                        spacing: 20,
                        children: [
                          AppTextField(
                            label: 'Income name',
                            focusNode: FocusNode(),
                            controller: TextEditingController(),
                          ),
                          AppAmountField(
                            label: 'Expected monthly income',
                            amount: 0,
                          ),
                          AppDropdownField(
                            label: 'Default payment account',
                            value: '',
                            onTap: () {},
                          ),
                        ],
                      ),
                    ),
                    // const Expanded(child: PaymentAccountSetupList()),
                  ],
                ),
              ),
            ),
          ),

          AppSection(
            child: Obx(
              () => Column(
                spacing: 8,
                children: [
                  AppButton(
                    text: 'Save income',
                    onTap: () {
                      // Get.toNamed(Routes.ONBOARDING_LEARN_WITH_ASCEND_INTRO);
                    },
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: context.bottomPaddingSub),
        ],
      ),
    );
  }
}

class PaymentAccountSetupList extends StatelessWidget {
  const PaymentAccountSetupList({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: database.accountsDao.watchAccounts(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final accounts = snapshot.data!.where((account) {
          final type = AccountType.fromName(account.accountType);
          return type.isPaymentAccount && type != AccountType.creditCard;
        }).toList();

        if (accounts.isEmpty) {
          return const Center(
            child: Text('No cash and bank accounts added yet.'),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(8),
          itemCount: accounts.length,
          separatorBuilder: (_, _) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return _CashAndBankAccountCard(account: accounts[index]);
          },
        );
      },
    );
  }
}

class _CashAndBankAccountCard extends GetView<AccountController> {
  final AccountsTableData account;
  // final VoidCallback? onTap;

  const _CashAndBankAccountCard({required this.account});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    final isNegative = account.currentValue < 0;

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Icon(AppIcons.categories.resolve(account.icon), size: 24),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        account.name,
                        style: AppTextStyle.bodyM,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                account.currentValue.toCurrency(),
                style: AppTextStyle.amountL.copyWith(
                  color: isNegative
                      ? colorScheme.appOutflow
                      : colorScheme.appInflow,
                ),
                softWrap: false,
                maxLines: 1,
                textAlign: TextAlign.right,
              ),
            ],
          ),

          if (isNegative) ...[
            const SizedBox(height: 12),

            Container(
              padding: const EdgeInsets.only(
                left: 12,
                top: 4,
                bottom: 4,
                right: 4,
              ),
              decoration: BoxDecoration(
                color: colorScheme.appOutflow.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    size: 24,
                    color: colorScheme.appOutflow,
                  ),

                  const SizedBox(width: 8),

                  Expanded(
                    child: Text(
                      'Balance needs updating',
                      style: AppTextStyle.labelS.copyWith(
                        color: colorScheme.appOutflow,
                      ),
                    ),
                  ),
                  AdaptivePressable(
                    onTap: () {
                      controller.initializeBalanceUpdate(account);
                      Get.bottomSheet(
                        UpdateAccountBalanceSheet(account: account),
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        // color: colorScheme.appText,
                        border: Border.all(color: colorScheme.appOutflow),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 8,
                        ),
                        child: Text(
                          'Update',
                          style: TextStyle(color: colorScheme.appOutflow),
                        ),
                      ),
                    ),
                  ),
                  // TextButton(
                  //   onPressed: () {
                  //     controller.initializeBalanceUpdate(account);
                  //     Get.bottomSheet(
                  //       UpdateAccountBalanceSheet(account: account),
                  //       backgroundColor: Colors.transparent,
                  //       isScrollControlled: true,
                  //     );
                  //   },
                  //   child: const Text('Update'),
                  // ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
