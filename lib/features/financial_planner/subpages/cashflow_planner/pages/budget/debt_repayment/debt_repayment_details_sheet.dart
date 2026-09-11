import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:getx_drift_app/core/constants/sheet_height.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/cashflow_planner/pages/bills/model/bill_with_next_occurrence.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_section.dart';
import 'package:getx_drift_app/features/widgets/miscellaneous/app_sheet.dart';
import 'package:getx_drift_app/shared/app_details_page_action_section.dart';

class DebtRepaymentDetailsSheet extends StatelessWidget {
  const DebtRepaymentDetailsSheet({super.key, required this.bill});

  final BillWithNextOccurrence bill;

  @override
  Widget build(BuildContext context) {
    final RxInt selectedIndex = 0.obs;

    final loan = bill.loanAccount;

    final frequency = BillsFrequency.values.firstWhere(
      (frequency) => frequency.name == bill.bill.frequency,
    );

    final paymentAmount = bill.bill.expectedAmount;

    final annualAmount = frequency.toAnnual(paymentAmount);

    return AppSheet(
      height: AppSheetHeight.full,
      title: bill.bill.name,
      child: Column(
        children: [
          _DebtRepaymentSummarySection(
            loanName: loan?.name,
            paymentAmount: paymentAmount,
            annualAmount: annualAmount,
            frequency: frequency,
            nextPaymentDate: bill.occurrence.dueDate,
          ),

          const SizedBox(height: 12),

          AppDetailsPageActionSection(
            selectedIndex: selectedIndex,
            actions: const ['Payment History'],
          ),

          Expanded(
            child: Obx(
              () => IndexedStack(
                index: selectedIndex.value,
                children: [_PaymentHistoryPlaceholder(loanAccountId: loan?.id)],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DebtRepaymentSummarySection extends StatelessWidget {
  const _DebtRepaymentSummarySection({
    required this.loanName,
    required this.paymentAmount,
    required this.annualAmount,
    required this.frequency,
    required this.nextPaymentDate,
  });

  final String? loanName;
  final double paymentAmount;
  final double annualAmount;
  final BillsFrequency frequency;
  final DateTime nextPaymentDate;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(loanName ?? 'Loan Payment', style: AppTextStyle.titleL),

          const SizedBox(height: 4),

          Text(
            billFrequencyLabel(frequency),
            style: AppTextStyle.bodyS.copyWith(color: colorScheme.appTextMuted),
          ),

          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: _Metric(
                  label: 'Payment',
                  value: paymentAmount.toCurrency(),
                ),
              ),
              Expanded(
                child: _Metric(
                  label: 'Annual',
                  value: annualAmount.toCurrency(),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Text(
            'Next payment',
            style: AppTextStyle.bodyS.copyWith(color: colorScheme.appTextMuted),
          ),

          const SizedBox(height: 4),

          Text(
            DateFormat('MMMM d, yyyy').format(nextPaymentDate),
            style: AppTextStyle.bodyM,
          ),
        ],
      ),
    );
  }

  String billFrequencyLabel(BillsFrequency frequency) {
    return frequency.label;
  }
}

class _Metric extends StatelessWidget {
  const _Metric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyS.copyWith(color: colorScheme.appTextMuted),
        ),
        const SizedBox(height: 4),
        Text(value, style: AppTextStyle.amountM),
      ],
    );
  }
}

class _PaymentHistoryPlaceholder extends StatelessWidget {
  const _PaymentHistoryPlaceholder({required this.loanAccountId});

  final int? loanAccountId;

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Payment history'));
  }
}
