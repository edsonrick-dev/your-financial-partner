import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_drift_app/core/design_system/addaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CashAndBankSummarySection extends StatelessWidget {
  final AccountsTableData account;

  const CashAndBankSummarySection({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    // final reservedFund = account.initialBalance;
    final totalFund = account.currentValue;
    final availableFunds = totalFund;
    final colorScheme = context.colors;
    return AppSection(
      child: Container(
        padding: EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [colorScheme.text, colorScheme.gradient2],
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Fund',
                      style: AppTextStyle.titleL.copyWith(
                        color: colorScheme.appInversedtextMuted,
                      ),
                    ),
                    const SizedBox(height: 4),

                    Text(
                      totalFund.toCurrency(),
                      style: AppTextStyle.amountXL.copyWith(
                        color: colorScheme.textInversed,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                AdaptivePressable(
                  onTap: () {
                    Get.bottomSheet(
                      UpdateAccountBalanceSheet(account: account),
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                    );
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Opacity(
                        opacity: 0.2,
                        child: Container(
                          height: 44,
                          width: 44,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(999),
                            color: colorScheme.textInversed,
                          ),
                        ),
                      ),
                      Icon(
                        PhosphorIconsRegular.dotsThree,
                        color: colorScheme.text,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            Row(
              children: [
                Expanded(
                  child: _Metric(
                    label: 'Available Fund',
                    value: availableFunds.toCurrency(),
                  ),
                ),
                Expanded(
                  child: _Metric(label: 'Reserved Fund', value: 0.toCurrency()),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Metric extends StatelessWidget {
  final String label;
  final String value;

  const _Metric({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.titleS.copyWith(
            color: colorScheme.appInversedtextMuted,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyle.amountM.copyWith(color: colorScheme.textInversed),
        ),
      ],
    );
  }
}

class UpdateAccountBalanceSheet extends StatefulWidget {
  final AccountsTableData account;

  const UpdateAccountBalanceSheet({super.key, required this.account});

  @override
  State<UpdateAccountBalanceSheet> createState() =>
      _UpdateAccountBalanceSheetState();
}

class _UpdateAccountBalanceSheetState extends State<UpdateAccountBalanceSheet> {
  late final TextEditingController amountController;

  @override
  void initState() {
    super.initState();

    amountController = TextEditingController(
      text: widget.account.currentValue.toStringAsFixed(2),
    );
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  double get actualBalance {
    return double.tryParse(amountController.text) ?? 0;
  }

  double get adjustment {
    return actualBalance - widget.account.currentValue;
  }

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
              widget.account.currentValue.toCurrency(),
              style: Theme.of(context).textTheme.titleLarge,
            ),

            const SizedBox(height: 20),

            Text(
              'Actual Balance',
              style: Theme.of(context).textTheme.bodyMedium,
            ),

            const SizedBox(height: 8),

            TextField(
              controller: amountController,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: const InputDecoration(
                prefixText: '₱',
                hintText: 'Enter actual balance',
              ),
              onChanged: (_) {
                setState(() {});
              },
            ),

            const SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Adjustment'),

                Text(
                  adjustment.toCurrency(),
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),

            const SizedBox(height: 24),

            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: actualBalance < 0
                    ? null
                    : () {
                        // Save adjustment here
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
