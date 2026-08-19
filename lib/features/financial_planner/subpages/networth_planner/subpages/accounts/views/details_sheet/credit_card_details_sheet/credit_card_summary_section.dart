import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/data/app_database.dart';
import 'package:getx_drift_app/data/tables/accounts_table.dart';
import 'package:getx_drift_app/organize_THIS/num_extension.dart';

class CreditCardSummarySection extends StatelessWidget {
  final AccountsTableData account;

  const CreditCardSummarySection({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    final creditLimit = account.creditLimit ?? 0;
    final payable = account.currentValue.abs();
    final availableCredit = account.availableCredit ?? 0;

    final utilization = creditLimit > 0 ? payable / creditLimit : 0.0;

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Current Payable', style: AppTextStyle.bodyS),

          const SizedBox(height: 4),

          Text(payable.toCurrency(), style: AppTextStyle.amountXL),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _Metric(
                  label: 'Available Credit',
                  value: availableCredit.toCurrency(),
                ),
              ),
              Expanded(
                child: _Metric(
                  label: 'Credit Limit',
                  value: creditLimit.toCurrency(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          LinearProgressIndicator(
            value: utilization.clamp(0.0, 1.0),
            minHeight: 6,
            borderRadius: BorderRadius.circular(10),
          ),

          const SizedBox(height: 6),

          Text(
            '${(utilization * 100).toStringAsFixed(1)}% utilized',
            style: AppTextStyle.bodyS,
          ),
        ],
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyle.bodyS),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyle.amountM),
      ],
    );
  }
}
