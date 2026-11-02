import 'package:flutter/material.dart';
import 'package:getx_drift_app/core/design_system/app_text_style.dart';
import 'package:getx_drift_app/core/theme/app_color_scheme.dart';
import 'package:getx_drift_app/features/widgets/cards/account_cards/app_card.dart';

class BeneficiaryCard extends StatelessWidget {
  const BeneficiaryCard({
    super.key,
    required this.name,
    required this.relationship,
    required this.faceAmount,
    required this.share,
    this.isMinor = false,
    this.isIrrevocable = false,
    this.trustee,
  });
  final bool isMinor;
  final String relationship;
  final String name;
  final String? trustee;
  final bool isIrrevocable;
  final double faceAmount;
  final double share;
  @override
  Widget build(BuildContext context) {
    // final benefitShare = faceAmount * share;
    final colorScheme = context.colors;
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: AppTextStyle.bodyL),
                    Text(relationship, style: AppTextStyle.labelM),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${(share * 100).toStringAsFixed(0)}%',
                    //  benefitShare.toCompactCurrency(kThreshold: 10000000),
                    style: AppTextStyle.amountL,
                  ),
                  Row(
                    children: [
                      Text(
                        'share',
                        style: AppTextStyle.labelM.copyWith(
                          color: colorScheme.appTextMuted,
                        ),
                      ),
                      if (isMinor) ...[Text('| Trustee: $trustee')],
                    ],
                  ),
                ],
              ),
            ],
          ),

          if (isMinor)
            _BeneficiaryRow(
              label: 'Trustee for Minor',
              item: trustee ?? 'Not specified',
            ),
        ],
      ),
    );
  }
}

class _BeneficiaryRow extends StatelessWidget {
  const _BeneficiaryRow({required this.label, required this.item});

  final String label;
  final String item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(label, style: AppTextStyle.bodyM)),
        Text(item, style: AppTextStyle.titleL),
      ],
    );
  }
}
