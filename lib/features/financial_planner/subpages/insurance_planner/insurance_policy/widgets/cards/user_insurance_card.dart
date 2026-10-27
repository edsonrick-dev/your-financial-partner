import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/num_extension.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/data/enums/bills_frequency_enum.dart';
import 'package:getx_drift_app/features/financial_planner/subpages/insurance_planner/insurance_policy/models/insurance_policy_list_item.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';
import 'package:intl/intl.dart';

class InsurancePolicyCard extends StatelessWidget {
  final InsurancePolicyListItem item;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const InsurancePolicyCard({
    super.key,
    required this.item,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return AppCard(
      onTap: onTap,
      onLongPressed: onLongPress,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.insurerName,
                      style: AppTextStyle.bodyS.copyWith(
                        color: colors.appTextMuted,
                      ),
                    ),

                    Text(
                      item.productName,
                      style: AppTextStyle.titleL,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(height: 1),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _PolicyDetail(
                  label: 'Policy Number',
                  value: item.policyNumber.isEmpty
                      ? 'Not provided'
                      : item.policyNumber,
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _PolicyDetail(
                  isLeft: false,
                  label: 'Payment Frequency',
                  value: item.paymentFrequency.label,
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _PolicyDetail(
                  label: 'Next Due',
                  value: item.nextDue == null
                      ? 'No upcoming payment'
                      : DateFormat('MMM d, yyyy').format(item.nextDue!),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: _PolicyDetail(
                  isLeft: false,
                  label: 'Amount Due',
                  value: item.amountDue.toCurrency(),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PolicyDetail extends StatelessWidget {
  final String label;
  final String value;
  final bool isLeft;
  const _PolicyDetail({
    required this.label,
    required this.value,
    this.isLeft = true,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Column(
      crossAxisAlignment: isLeft
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: AppTextStyle.bodyS.copyWith(color: colors.appTextMuted),
        ),
        const SizedBox(width: 12),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            value,
            style: AppTextStyle.bodyL,
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
