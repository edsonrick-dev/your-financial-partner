import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/networth_planner/subpages/accounts/create_account_controller.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

class UpdateAccountBalanceSheet extends GetView<AccountController> {
  final AccountsTableData account;

  const UpdateAccountBalanceSheet({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(99),
                ),
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Update Balance',
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 24),

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

            Text(
              'Actual Balance',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 8),

            TextField(
              controller: controller.balanceController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                prefixText: '₱',
                hintText: 'Enter actual balance',
              ),
              onChanged: controller.onBalanceChanged,
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Adjustment'),

                Text(
                  controller
                      .getBalanceAdjustment(account.currentValue)
                      .toCurrency(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),

            const SizedBox(height: 24),

            SizedBox(
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
          ],
        ),
      ),
    );
  }
}
