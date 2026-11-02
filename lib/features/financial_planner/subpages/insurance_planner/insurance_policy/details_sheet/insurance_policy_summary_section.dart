import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/adaptive_pressable.dart';
import 'package:getx_drift_app/core/design_system/app_gradient_card.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';

class InsurancePolicySummaryContent {
  final String insurerName;
  final String productName;
  final String policyNumber;
  final BillsFrequency paymentFrequency;
  final DateTime? nextDue;

  const InsurancePolicySummaryContent({
    required this.insurerName,
    required this.productName,
    required this.policyNumber,
    required this.nextDue,
    required this.paymentFrequency,
  });
}

class InsurancePolicySummarySection extends StatelessWidget {
  const InsurancePolicySummarySection({super.key, required this.content});
  final InsurancePolicySummaryContent content;

  @override
  Widget build(BuildContext context) {
    final colorScheme = context.colors;

    return AppGradientCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  content.insurerName,
                  style: AppTextStyle.bodyS.copyWith(
                    color: colorScheme.appInversedtext,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              AdaptivePressable(
                child: SizedBox(
                  width: 44,
                  child: Icon(
                    Icons.more_horiz,
                    color: colorScheme.appInversedtext,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  content.productName,
                  style: AppTextStyle.titleL.copyWith(
                    color: colorScheme.appInversedtext,
                  ),
                ),
              ),
              Text(
                content.policyNumber,
                style: AppTextStyle.amountL.copyWith(
                  color: colorScheme.appInversedtext,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),
          Row(
            spacing: 16,
            children: [
              Expanded(
                child: Column(
                  spacing: 4,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      content.paymentFrequency.billsLabel,
                      style: AppTextStyle.labelS.copyWith(
                        color: colorScheme.appInversedtext,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
