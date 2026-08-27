import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/account_controller.dart';
import 'package:getx_drift_app/features/widgets/fields/app_amount_field.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/core/num_extension.dart';

class UpdateAccountBalanceSheet extends GetView<AccountController> {
  final AccountsTableData account;

  const UpdateAccountBalanceSheet({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return AppSheet(
      adaptiveHeight: true,
      title: 'Update Balance',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Current Balance',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 4),

            Text(
              account.currentValue.toCurrency(),
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),
            Obx(
              () => AppAmountField(
                label: 'Amount',
                amount: controller.enteredBalance.value,
                onChanged: (value) => controller.enteredBalance.value = value,
              ),
            ),

            // AppTextField(
            //   onChanged: controller.onBalanceChanged,
            //   label: 'Actual Balance',
            //   focusNode: controller.balanceFocusNode,
            //   controller: controller.balanceController,
            // ),
            const SizedBox(height: 20),

            Obx(() {
              final adjustment = controller.getBalanceAdjustment(
                account.currentValue,
              );

              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Adjustment'),
                  Text(
                    adjustment.toCurrency(),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              );
            }),

            const SizedBox(height: 24),

            Obx(
              () => SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: controller.actualBalance < 0
                      ? null
                      : () {
                          controller.updateAccountBalance(account);
                        },
                  child: const Text('Update Balance'),
                ),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
